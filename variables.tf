variable "cidr_block" {
   type = string
}

variable "region" {
  type = string
}

variable "project" {
  type = string
}

variable "env" {
    type = string
}

variable "user_tags" {
    type = map(string)
    default = {}
}

variable "component" {
  type = string
}

variable "public_subnet_cidrs" {
   type = list(string)
   default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "public_subnet_tags" {
   type = map
   default = {}
}

variable "private_subnet_cidrs" {
   type = list(string)
   default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_subnet_tags" {
   type = map
   default = {}
}

variable "db_private_subnet_cidrs" {
   type = list(string)
   default = ["10.0.21.0/24","10.0.22.0/24"]
}

variable "db_private_subnet_tags" {
   type = map
   default = {}
}

# variable "availability_zones" {
#    type = list(string)
# }

variable "is_peering_required" {
   type = bool
}