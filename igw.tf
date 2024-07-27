 resource "aws_internet_gateway" "ori-igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "ori-igw"
  }
}

