output "windows_availability_set" {
    value = azurerm_availability_set.windows_availability_set
}

output "win_vm" {
    value = values(azurerm_windows_virtual_machine.vm_windows)[*].id
}

output "vm_windows_hostname" {
    value = [values(azurerm_windows_virtual_machine.vm_windows)[*].name]
}

output "windows_public_ip" {
    value = [values(azurerm_windows_virtual_machine.vm_windows)[*].public_ip_address]
}

output "windows_private_ip" {
    value = [values(azurerm_windows_virtual_machine.vm_windows)[*].private_ip_address]
}