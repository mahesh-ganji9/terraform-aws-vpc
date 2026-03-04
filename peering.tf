resource "aws_vpc_peering_connection" "peering" {
  count = var.is_peering_required ? 1 : 0
  #acceptor
  peer_vpc_id = data.aws_vpc.default_vpc.id
  #requestor
  vpc_id = aws_vpc.main.id
  auto_accept = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }
  requester {
    allow_remote_vpc_dns_resolution = true
  }
   tags = merge(local.common_tags,
   {
    Name = "${var.project}-${var.env}-peering"
  },
  var.user_tags)
}

resource "aws_route" "private_route" {
  count = var.is_peering_required ? 1 : 0
  destination_cidr_block = data.aws_vpc.default_vpc.cidr_block
  route_table_id = aws_route_table.Private_rt_table.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
}


resource "aws_route" "default_route" {
  count = var.is_peering_required ? 1 : 0
  destination_cidr_block = aws_vpc.main.cidr_block
  route_table_id = data.aws_route_table.default_routetable.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
}

resource "aws_route" "db_private_route" {
  count = var.is_peering_required ? 1 : 0
  destination_cidr_block = data.aws_vpc.default_vpc.cidr_block
  route_table_id = aws_route_table.db_private_rt_table.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
}

resource "aws_route" "public_route" {
  count = var.is_peering_required ? 1 : 0
  destination_cidr_block = data.aws_vpc.default_vpc.cidr_block
  route_table_id = aws_route_table.Public_rt_table.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
}