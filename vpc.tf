resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  region = var.region
  tags = merge(local.common_tags,
              {
                Name = "${var.project}-${var.env}-vpc"
              },
              var.user_tags

  )
}


resource "aws_subnet" "public_snet" {
  vpc_id     = aws_vpc.main.id
  count = length(var.public_subnet_cidrs)
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = local.local.az_list[count.index]
  # roboshop-public-snet-us-east-1a
  tags =merge(local.common_tags,
        {
           Name = "${var.project}-publicsnet-${data.aws_availability_zones.available.names[count.index]}"
        },
        var.user_tags
  )
}

resource "aws_subnet" "private_snet" {
  vpc_id     = aws_vpc.main.id
  count = length(var.private_subnet_cidrs)
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = local.az_list[count.index]
  # roboshop-private-snet-us-east-1a
  tags = merge(local.common_tags,
        {
           Name = "${var.project}-privatesnet-${data.aws_availability_zones.available.names[count.index]}"
        },
        var.user_tags
  )
}

resource "aws_subnet" "db_private_snet" {
  vpc_id     = aws_vpc.main.id
  count = length(var.db_private_subnet_cidrs)
  cidr_block = var.db_private_subnet_cidrs[count.index]
  availability_zone = local.az_list[count.index]
  # roboshop-private-snet-us-east-1a
    tags = merge(local.common_tags,
        {
           Name = "${var.project}-db-privatesnet-${data.aws_availability_zones.available.names[count.index]}"
        },
        var.user_tags
  )
}

resource "aws_internet_gateway" "internetgw" {
  vpc_id = aws_vpc.main.id
tags = merge(local.common_tags,
        {
           Name = "${var.project}-${var.env}-InternetGW"
        },
        var.user_tags)
   }


resource "aws_route_table" "Private_rt_table" {
  vpc_id = aws_vpc.main.id
   route {
     cidr_block = "0.0.0.0/0"
     nat_gateway_id = aws_nat_gateway.main.id
  }
  tags = merge(local.common_tags,
   {
    Name = "${var.project}-${var.env}-private-rttable"
  },
  var.user_tags)
}

resource "aws_route_table" "Public_rt_table" {
  vpc_id = aws_vpc.main.id
  route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.internetgw.id
  }
  tags = merge(local.common_tags,
   {
    Name = "${var.project}-${var.env}-public-rttable"
  },
  var.user_tags)
}

resource "aws_route_table" "db_private_rt_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
 tags = merge(local.common_tags,
   {
    Name = "${var.project}-${var.env}-db-private-rttable"
  },
  var.user_tags)
}

resource "aws_route_table_association" "private_rt_assoc" {
  count = length(aws_subnet.private_snet)
  subnet_id      = aws_subnet.private_snet[count.index].id
  route_table_id = aws_route_table.Private_rt_table.id
}

resource "aws_route_table_association" "public_rt_assoc" {
  count = length(aws_subnet.public_snet)
  subnet_id      = aws_subnet.public_snet[count.index].id
  route_table_id = aws_route_table.Public_rt_table.id
}

resource "aws_route_table_association" "private_db_rt_assoc" {
  count = length(aws_subnet.db_private_snet)
  subnet_id      = aws_subnet.db_private_snet[count.index].id
  route_table_id = aws_route_table.db_private_rt_table.id 
}

resource "aws_eip" "main" {
  address = vpc
  depends_on = [ aws_internet_gateway.internetgw ]
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.allocation_id
  subnet_id = aws_subnet.public_snet[0].id
  depends_on = [ aws_eip.main ]
  tags = merge(local.common_tags,
   {
    Name = "${var.project}-${var.env}-natgw"
  },
  var.user_tags)
}

