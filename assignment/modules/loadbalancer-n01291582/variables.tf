variable "resource_group_name" {}

variable "resource_group_location" {}

variable "vmlinux_public_ip" {}

variable "vmlinux_nic_id" { 
    type = list(string)
}

variable "nb_count" {}

variable "subnet_id" {}

variable "vmlinux_name" {}