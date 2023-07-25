output "log_aw_name" {
    value = azurerm_log_analytics_workspace.log_aw 
}

output "recovery_services_vault_name" {
    value = azurerm_recovery_services_vault.recovery_services_vault
}

output "storage_account_name" {
    value = azurerm_storage_account.storage_account
}

output "storage_account_key" {
    value = azurerm_storage_account.storage_account
}