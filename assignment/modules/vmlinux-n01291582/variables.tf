variable "resource_group_name" {}

variable "resource_group_location" {}

variable "vmlinux_avs" {
    default = "linux_availability_set"
}

variable "nb_count" {}

variable "vmlinux_name" {}

variable "vmlinux_size" {
    default = "Standard_B1s"
}

variable "linux_private_key" {
    default = "C:\\Users\\brand\\.ssh\\id_rsa"
}

variable "admin_username" {
    default = "n01291582"
}

variable "public_key" {
    default = "C:\\Users\\brand\\.ssh\\id_rsa.pub"
}

variable "os_disk_attributes" {
    type = map(string)
    default = {
      "os-disk-caching"         = "ReadWrite"
      "os-disk-size"            = "32"
      "os-storage-account-type" = "Premium_LRS"
    }
}

variable "source_images_details" {
    type = map(string)
    default = {
      "os-publisher" = "OpenLogic"
      "os-offer"     = "CentOS"
      "os-sku"       = "8_2"
      "os-version"   = "latest"
    }
}

variable "storage_account_name" {}

variable "storage_account_key" {}

variable "st_acc_u" {}

variable "subnet_id" {}