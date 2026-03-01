locals {
    region = "us-east-1a"
    tags = {
        Project = var.project
        env = var.env
        component = var.component
    }

    vpc_final_tags = merge(local.tags , var.user_tags)
}

