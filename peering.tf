resource "aws_vpc_peering_connection" "peering" {
  peer_vpc_id = data.aws_vpc.default_vpc.id
  vpc_id = aws_vpc.main.id
  auto_accept = true
}

resource "aws_route" "private_route" {
  destination_cidr_block = data.aws_vpc.default_vpc.id
  route_table_id = aws_route_table.Private_rt_table.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}


resource "aws_route" "default_route" {
  destination_cidr_block = aws_vpc.main.id
  route_table_id = data.aws_route_table.default_routetable.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}