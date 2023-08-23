resource "azurerm_postgresql_server" "postgresql_server" {
    name                = "postgresql-n01291582"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name
    sku_name = "B_Gen5_2"
    storage_mb                   = 5120
    backup_retention_days        = 7
    geo_redundant_backup_enabled = false
    auto_grow_enabled            = true
    administrator_login          = var.database_username
    administrator_login_password = var.database_password
    version                      = var.database_version
    ssl_enforcement_enabled      = true

    tags = {
        Assignment     = "CCGC 5502 Automation Assignment"
        Name           = "brandon.budhram"
        ExpirationDate = "2024-12-31"
        Environment    = "Learning"
    }
}