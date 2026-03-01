resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  region = var.region
  tags = local.vpc_final_tags
}


resource "aws_subnet" "public_snet" {
  vpc_id     = aws_vpc.main.id
  count = length(var.public_subnet_cidrs)
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available[count.index]
  # roboshop-public-snet-us-east-1a
  tags = {
    Name = "${var.project}-publicsnet-${data.aws_availability_zones.available[count.index]}"
  }
}

resource "aws_subnet" "private_snet" {
  vpc_id     = aws_vpc.main.id
  count = length(var.private_subnet_cidrs)
  cidr_block = var.public_subnet_cidrs[count]
  availability_zone = data.aws_availability_zones.available[count.index]
  # roboshop-private-snet-us-east-1a
  tags = {
    Name = "${var.project}-privatesnet-${data.aws_availability_zones.available[count.index]}"
  }
}