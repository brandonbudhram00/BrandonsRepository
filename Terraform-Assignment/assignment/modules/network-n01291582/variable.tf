variable "resource_group_name" {
    description = "name of the resource group"
    type        = string
    default     = "n01291582-rg"
}

variable "resource_group_location" {
    description = "location of the resource group"
    type        = string
    default     = "Canada Central" 
}

variable "virtual_network_address_space" {
    description = "virtual network space"
    type        = list(string)
    default     = [ "10.0.0.0/16" ]
}

variable "subnet_address_space" {
    description = "address space of subnet"
    type        = list(string)
    default     = ["10.0.0.0/24"]
}