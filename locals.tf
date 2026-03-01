locals {
    region = var.region
    tags = {
        Name = "${var.component}-${var.env}-vpc"
        project = var.project
        env = var.env
 }
    vpc_final_tags = merge(local.tags , var.user_tags)
}

