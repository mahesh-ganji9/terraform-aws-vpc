data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "default_vpc" {
cidr_block = "172.31.0.0/16"
}

data "aws_route_table" "default_routetable" {
  route_table_id = rtb-0322ed59b804dd591
}