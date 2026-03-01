resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  region = var.region

  tags = local.vpc_final_tags
}

