resource "aws_route" "ori-public-route" {
  route_table_id = aws_route_table.ori-public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.ori-igw.id
}

resource "aws_route" "ori-private-route-01" {
  route_table_id = aws_route_table.ori-private_rt-01.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.ori-ngw-01.id
}

resource "aws_route" "ori-private-route-02" {
  route_table_id = aws_route_table.ori-private_rt-02.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.ori-ngw-02.id
}