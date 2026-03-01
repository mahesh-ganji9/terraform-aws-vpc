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