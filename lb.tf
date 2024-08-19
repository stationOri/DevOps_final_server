resource "aws_lb" "ori-lb" {
  name               = "ori-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    aws_security_group.ori-sg-bastion.id,
    aws_security_group.ori-sg-elb.id,
    aws_security_group.ori-sg-db.id
  ]
  subnets            = [aws_subnet.ori-subnet-public-01.id, aws_subnet.ori-subnet-public-02.id]

  enable_deletion_protection = false

  tags = {
    Name = "ori-lb"
  }
}

resource "aws_lb_target_group" "frontend-tg" {
  name     = "frontend-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    matcher             = "200-299"
  }

  tags = {
    Name = "frontend-tg"
  }
}

resource "aws_lb_target_group" "backend-tg" {
  name     = "backend-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/api/healthy"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 10
    interval            = 20
    matcher             = "200-299"
  }

  tags = {
    Name = "backend-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.ori-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-tg.arn
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.ori-lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-tg.arn
  }
}

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  action {
    type = "redirect"
    redirect {
      host          = "waitmate.shop"
      path          = "/"
      port          = "443"
      protocol      = "HTTPS"
      query         = ""
      status_code   = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

resource "aws_lb_listener_rule" "frontend_http" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-tg.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

resource "aws_lb_listener_rule" "backend_http" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend-tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}

resource "aws_lb_listener_rule" "frontend_https" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-tg.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

resource "aws_lb_listener_rule" "backend_https" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend-tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}