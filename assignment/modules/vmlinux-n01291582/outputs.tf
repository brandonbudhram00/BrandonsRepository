output "linux_hostname" {
    value = azurerm_linux_virtual_machine.linux_vm[*].name
}

output "linux_id" {
    value = azurerm_linux_virtual_machine.linux_vm[*].id
}

output "Linux_FQDN" {
    value = [azurerm_public_ip.vmlinux_public_ip[*].fqdn]
}

output "vmlinux_private_ip" {
    value = [azurerm_linux_virtual_machine.linux_vm[*].private_ip_address]
}

output "linux_public_ip" {
    value = azurerm_linux_virtual_machine.linux_vm[*].public_ip_address
}

output "linux_avs" {
    value = azurerm_availability_set.linux_availability_set.name
}

output "vm_linux" {
    value = [azurerm_linux_virtual_machine.linux_vm[*].name]
}

output "linux_domain_label" {
    value = [azurerm_public_ip.vmlinux_public_ip[*].domain_name_label]
}

output "linux_nic_id" {
    value = [azurerm_network_interface.vmlinux_network_interface[*].id]
}