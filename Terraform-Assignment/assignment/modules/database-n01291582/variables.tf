variable "resource_group_name" {}

variable "resource_group_location" {}

variable "database_username" {
    default = "posqladmin"
}

variable "database_password" {
    default = "Terraform123!"
}

variable "database_version" {
    default = "9.5"
}