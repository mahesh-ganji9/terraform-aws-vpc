locals {
    region = var.region
    tags = {
        project = var.project
        env = var.env
        terraform = true
        
    }
    vpc_final_tags = merge(local.tags , var.user_tags )
}

