resource "aws_db_instance" "ori-db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.micro"
  identifier           = "ori-db"
  username             = "ori"
  password             = "kosta6006"
  final_snapshot_identifier = "my-final-snapshot"
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.ori-db-subnet-group.name
  vpc_security_group_ids = [
    aws_security_group.ori-sg-bastion.id, 
    aws_security_group.ori-sg-elb.id, 
    aws_security_group.ori-sg-db.id
    ]
  tags = {
    Name = "ori-db"
  }
}

resource "aws_db_subnet_group" "ori-db-subnet-group" {
  name       = "ori-db-subnet-group"
  subnet_ids = [aws_subnet.ori-subnet-private-01.id, aws_subnet.ori-subnet-private-02.id]
#   subnet_ids = [aws_subnet.ori-subnet-private-01.id]
  tags = {
    Name = "ori-db-subnet-group"
  }
}