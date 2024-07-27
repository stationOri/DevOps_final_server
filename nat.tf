resource "aws_eip" "ip-for-ngw-01" {
  domain = "vpc"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "ip-for-ngw-01"
  }
}

resource "aws_eip" "ip-for-ngw-02" {
  domain = "vpc"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "ip-for-ngw-02"
  }
}

resource "aws_nat_gateway" "ori-ngw-01" {
  allocation_id = aws_eip.ip-for-ngw-01.id
  subnet_id = aws_subnet.ori-subnet-public-01.id
  tags = {
    Name = "ori-ngw-01"
  }
}

resource "aws_nat_gateway" "ori-ngw-02" {
  allocation_id = aws_eip.ip-for-ngw-02.id
  subnet_id = aws_subnet.ori-subnet-public-02.id
  tags = {
    Name = "ori-ngw-02"
  }
}