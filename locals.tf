locals {
    region = var.region
    tags = {
        Name = "${var.project}-${var.env}-vpc"
        project = var.project
        env = var.env
 }
    # public_snet_tags = {
    #     Name = "${var.project}-publicsnet-${data.aws_availability_zones.available[count.index]}"
    # }
    # private_snet_tags = {
    #     Name = "${var.project}-privatesnet-${data.aws_availability_zones.available[count.index]}"
    # }
    vpc_final_tags = merge(local.tags , var.user_tags)
}

