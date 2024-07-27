 # ori-sg-bastion => SSH(22)
resource "aws_security_group" "ori-sg-bastion" {
  name = "ori-sg-bastion"
  vpc_id = var.vpc_id
  tags = {
    Name = "ori-sg-bastion"
  }
}

resource "aws_security_group_rule" "ori-sg-bastion-inbound" {
  security_group_id = aws_security_group.ori-sg-bastion.id
  type = "ingress"
  description = "allow all for ssh"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ori-sg-bastion-outbound" {
  security_group_id = aws_security_group.ori-sg-bastion.id
  type = "egress"
  description = "allow all outbound"
  from_port = 0
  to_port = 0
  protocol = "-1" #상관 없이
  cidr_blocks = ["0.0.0.0/0"]
}

# ori-sg-elb => HTTP(80), HTTPS(443)
resource "aws_security_group" "ori-sg-elb" {
  name = "ori-sg-elb"
  vpc_id = var.vpc_id
  tags = {
    Name = "ori-sg-elb"
  }
}

resource "aws_security_group_rule" "ori-sg-elb-inbound" {
  security_group_id = aws_security_group.ori-sg-elb.id
  type = "ingress"
  description = "allow all for http"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ori-sg-elb-inbound2" {
  security_group_id = aws_security_group.ori-sg-elb.id
  type = "ingress"
  description = "allow all for https"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ori-sg-elb-outbound" {
  security_group_id = aws_security_group.ori-sg-elb.id
  type = "egress"
  description = "allow all outbound"
  from_port = 0
  to_port = 0
  protocol = "-1" #상관 없이
  cidr_blocks = ["0.0.0.0/0"]
}

# ori-sg-db => MySQL(3306)
resource "aws_security_group" "ori-sg-db" {
  name = "ori-sg-db"
  vpc_id = var.vpc_id
  tags = {
    Name = "ori-sg-db"
  }
}

resource "aws_security_group_rule" "ori-sg-db-inbound" {
  security_group_id = aws_security_group.ori-sg-db.id
  type = "ingress"
  description = "allow all for MySQL"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ori-sg-db-outbound" {
  security_group_id = aws_security_group.ori-sg-db.id
  type = "egress"
  description = "allow all outbound"
  from_port = 0
  to_port = 0
  protocol = "-1" #상관 없이
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ori-sg-elb-inbound-backend" {
  security_group_id = aws_security_group.ori-sg-elb.id
  type              = "ingress"
  description       = "allow all for backend"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ori-sg-elb-inbound-react" {
  security_group_id = aws_security_group.ori-sg-elb.id
  type              = "ingress"
  description       = "allow all for react app"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

