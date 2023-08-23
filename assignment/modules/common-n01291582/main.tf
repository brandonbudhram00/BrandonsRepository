resource "azurerm_log_analytics_workspace" "log_aw" {
    name                = "LogAnalyticsw"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name
    sku                 = "PerGB2018"
    retention_in_days   = 30

    tags = {
        Assignment     = "CCGC 5502 Automation Assignment"
        Name           = "brandon.budhram"
        ExpirationDate = "2024-12-31"
        Environment    = "Learning"
    }
}

resource "azurerm_recovery_services_vault" "recovery_services_vault" {
    name                = var.recovery_service_vault["recovery_vault_name"]
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name
    sku                 = var.recovery_service_vault["recovery_sku"]
    soft_delete_enabled = true 
}

resource "azurerm_storage_account" "storage_account" {
    name                     = "n01291582sa"
    location                 = var.resource_group_location
    resource_group_name      = var.resource_group_name
    account_tier             = "Standard"
    account_replication_type = "LRS"
}
