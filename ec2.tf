# resource "aws_instance" "ori-ec2-web1" {
#   ami           = "ami-0a6f5535bb7949f11"
#   instance_type = "t2.small"
#   key_name = "ori"
#   subnet_id     = aws_subnet.ori-subnet-public-01.id
#   security_groups = [
#     aws_security_group.ori-sg-bastion.id,
#     aws_security_group.ori-sg-elb.id,
#     aws_security_group.ori-sg-db.id
#     ]
#   tags = {
#     Name = "ori-ec2-web1"
#   }
#   user_data = <<-EOF
#               #!/bin/bash
#               sudo apt-get update
#               sudo apt-get install -y nginx
#               sudo systemctl start nginx
#               sudo systemctl enable nginx
#               EOF
# }
#
# resource "aws_instance" "ori-ec2-web2" {
#   ami           = "ami-0a6f5535bb7949f11"
#   instance_type = "t2.small"
#   key_name = "ori"
#   subnet_id     = aws_subnet.ori-subnet-public-02.id
#   security_groups = [
#     aws_security_group.ori-sg-bastion.id,
#     aws_security_group.ori-sg-elb.id,
#     aws_security_group.ori-sg-db.id
#     ]
#   tags = {
#     Name = "ori-ec2-web2"
#   }
#   user_data = <<-EOF
#               #!/bin/bash
#               sudo apt-get update
#               sudo apt-get install -y nginx
#               sudo systemctl start nginx
#               sudo systemctl enable nginx
#               EOF
# }

# Bastion Host 설정
# resource "aws_instance" "bastion" {
#   ami           = "ami-062cf18d655c0b1e8"
#   instance_type = "t3.micro"
#   subnet_id     = aws_subnet.ori-subnet-public-02.id
#   key_name       = "ori"

#   security_groups = [aws_security_group.ori-sg-bastion.id, aws_security_group.ori-sg-elb.id, aws_security_group.ori-sg-db.id]

#   tags = {
#     Name = "bastion-host"
#   }
# }

# # Elastic IP 생성
# resource "aws_eip" "bastion_eip" {
#   instance = aws_instance.bastion.id

#   tags = {
#     Name = "bastion-eip"
#   }
# }