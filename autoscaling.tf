resource "aws_autoscaling_group" "ori_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  vpc_zone_identifier  = [aws_subnet.ori-subnet-public-01.id, aws_subnet.ori-subnet-public-02.id]
  target_group_arns    = [aws_lb_target_group.frontend-tg.arn, aws_lb_target_group.backend-tg.arn]
  health_check_type    = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.ori_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ori-autoscaling"
    propagate_at_launch = true
  }
}

# 시작 템플릿
resource "aws_launch_template" "ori_lt" {
  name          = "ori-launch-template"
  image_id      = "ami-0e432553babc1a8ca"
  instance_type = "t2.medium"
  key_name      = "ori"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ori-sg-bastion.id,
                                   aws_security_group.ori-sg-elb.id,
                                   aws_security_group.ori-sg-db.id]
  }

  user_data = base64encode(<<-EOF
              sudo docker pull ${data.aws_ecr_repository.ori_frontend.repository_url}:latest
              sudo docker pull ${data.aws_ecr_repository.ori_backend.repository_url}:latest
              sudo docker run -d -p 3000:3000 ${data.aws_ecr_repository.ori_frontend.repository_url}:latest
              sudo docker run -d -p 8080:8080 ${data.aws_ecr_repository.ori_backend.repository_url}:latest
              EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ori-autoscaling-instance"
    }
  }
}