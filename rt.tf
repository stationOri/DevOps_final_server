# public
resource "aws_route_table" "ori-public_rt" {
  vpc_id = var.vpc_id
  tags = {
    Name = "ori-public_rt"
  }
}

# private 01
resource "aws_route_table" "ori-private_rt-01" {
  vpc_id = var.vpc_id
  tags = {
    Name = "ori-private_rt-01"
  }
}

# private 02
resource "aws_route_table" "ori-private_rt-02" {
  vpc_id = var.vpc_id
  tags = {
    Name = "ori-private_rt-02"
  }
}