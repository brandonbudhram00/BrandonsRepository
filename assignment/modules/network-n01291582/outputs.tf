output "virtual_network_subnet_name" {
    value = azurerm_subnet.virtual_network_subnet
}

output "virtual_network_security_group_name" {
    value = azurerm_network_security_group.network_security_group
}

output "virtual_network_name" {
    value = azurerm_virtual_network.virtual_network
}