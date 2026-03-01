locals {
    region = var.region
    tags = {
        Name = "${var.component}-${var.env}"
        project = var.project
        env = var.env
        terraform = true
 }
    vpc_final_tags = merge(local.tags , var.user_tags )
}

