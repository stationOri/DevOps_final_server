# public
resource "aws_route_table_association" "ori-subnet-public-01" {
  subnet_id      = aws_subnet.ori-subnet-public-01.id
  route_table_id = aws_route_table.ori-public_rt.id
}

resource "aws_route_table_association" "ori-subnet-public-02" {
  subnet_id      = aws_subnet.ori-subnet-public-02.id
  route_table_id = aws_route_table.ori-public_rt.id
}

# private 01
resource "aws_route_table_association" "ori-subnet-private-01" {
  subnet_id      = aws_subnet.ori-subnet-private-01.id
  route_table_id = aws_route_table.ori-private_rt-01.id
}

# private 02
resource "aws_route_table_association" "ori-subnet-private-02" {
  subnet_id      = aws_subnet.ori-subnet-private-02.id
  route_table_id = aws_route_table.ori-private_rt-02.id
}