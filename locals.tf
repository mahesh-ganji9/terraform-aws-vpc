locals {
    region = var.region
    common_tags = {
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
    
    az_list = slice(data.aws_availability_zones.available.names,0,2)
}

