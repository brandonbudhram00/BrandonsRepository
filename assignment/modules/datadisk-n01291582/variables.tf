locals {
    vms_name = "${var.prefix}-vm"
}

variable "prefix" {
    default = "n01291582"
}

variable "resource_group_name" {}

variable "resource_group_location" {}

variable "vm_windows_name" {}

variable "windows_vm_id" {}

variable "vmlinux_name" {}

variable "linux_vm_id" {}

variable "counts_vms" {
    default = "4"
}
