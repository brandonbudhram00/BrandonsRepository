output "rgroup_net_name" {
    value = module.resource_group.resource_group_name.name
}

output "rgroup_net_location" {
    value = module.resource_group.resource_group_location.location 
}

output "virtual_network_subnet_name" {
    value = module.network.virtual_network_subnet_name.name
}

output "virtual_network_name" {
    value = module.network.virtual_network_name.name 
}

output "vnet_space" {
    value = module.network.virtual_network_name.address_space
}

output "vnet_sg_name1" {
    value = module.network.virtual_network_security_group_name.name
}

output "log_aw_name" {
    value = module.common.log_aw_name.name
}

output "recovery_services_vault_name" {
    value = module.common.recovery_services_vault_name.name
}

output "storage_account_name" {
    value = module.common.storage_account_name.name
}

output "vmlinux_private_ip" {
    value = module.vmlinux.vmlinux_private_ip
}

output "linux_public_ip" {
    value = module.vmlinux.linux_public_ip
}

output "vm_linux" {
    value = module.vmlinux.vm_linux 
}

output "linux_hostname" {
    value = module.vmlinux.linux_hostname
}

output "vmwindows_hostname" {
    value = module.vmwindows.vm_windows_hostname
}

output "windows_public_ip" {
    value = module.vmwindows.windows_public_ip
}

output "windows_private_ip" {
    value = module.vmwindows.windows_private_ip
}

output "database_name" {
    value = module.database.database_name.name
}