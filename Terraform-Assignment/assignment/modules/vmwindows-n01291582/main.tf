resource "azurerm_availability_set" "windows_availability_set" {
    name                         = var.windows_availability_set
    location                     = var.resource_group_location
    resource_group_name          = var.resource_group_name
    platform_update_domain_count = 5
    tags = {
        environment = "production"
    }
}

resource "azurerm_windows_virtual_machine" "vm_windows" {
    name                        = each.key
    computer_name               = each.key
    for_each                    = var.vm_windows_name
    resource_group_name         = var.resource_group_name
    location                    = var.resource_group_location
    size                        = each.value
    admin_username              = var.admin_username
    admin_password              = var.admin_password

    tags = {
        Assignment     = "CCGC 5502 Automation Assignment"
        Name           = "brandon.budhram"
        ExpirationDate = "2024-12-31"
        Environment    = "Learning"
    }

    winrm_listener {
        protocol = "Http"
    }

    network_interface_ids = [
        azurerm_network_interface.windows_network_interface[each.key].id
    ]

    depends_on = [
        azurerm_availability_set.windows_availability_set
    ]

    os_disk {
        name                 = each.key
        caching              = var.vmwindows_os_disk_attributes["os-disk-caching"]
        storage_account_type = var.vmwindows_os_disk_attributes["os-storage-account-type"]
        disk_size_gb         = var.vmwindows_os_disk_attributes["os-disk-size"] 
    }

    source_image_reference {
        publisher            = var.vmwindows_source_images_details["os-publisher"]
        offer                = var.vmwindows_source_images_details["os-offer"]
        sku                  = var.vmwindows_source_images_details["os-sku"]
        version              = var.vmwindows_source_images_details["os-version"]
    }

        boot_diagnostics {
            storage_account_uri = var.storage_account.primary_blob_endpoint
    }
}

resource "azurerm_network_interface" "windows_network_interface" {
    for_each            = var.vm_windows_name
    name                = "${each.key}-nic"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name

    tags = {
        Assignment     = "CCGC 5502 Automation Assignment"
        Name           = "brandon.budhram"
        ExpirationDate = "2024-12-31"
        Environment    = "Learning"
    }

    ip_configuration {
        name                          = "${each.key}-nic"
        subnet_id                     = var.subnet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.vmwindows_public_ip[each.key].id
    }
}

resource "azurerm_public_ip" "vmwindows_public_ip" {
    name                = "${each.key}-public-ip"
    for_each            = var.vm_windows_name 
    resource_group_name = "n01291582-rg"
    location            = var.resource_group_location
    allocation_method   = "Dynamic"
    domain_name_label   = "automation-assignment1-${lower(replace(each.key, "/[^a-z0-9-]/", ""))}"

    tags = {
        Assignment     = "CCGC 5502 Automation Assignment"
        Name           = "brandon.budhram"
        ExpirationDate = "2024-12-31"
        Environment    = "Learning"
    }
}

resource "azurerm_virtual_machine_extension" "windows_extension" {
    for_each                    = var.vm_windows_name
    name                        = "IaaSAntimalware"
    publisher                   = "Microsoft.Azure.Security"
    type                        = "IaaSAntimalware"
    type_handler_version        = "1.3"
    auto_upgrade_minor_version  = "true"
    virtual_machine_id          = azurerm_windows_virtual_machine.vm_windows[each.key].id

    settings = <<SETTINGS
        {
            "AntimalwareEnabled": true,
            "RealtimeProtectionEnabled": "true",
            "ScheduledScanSettings": {
                "isEnabled": "true",
                "day": "1",
                "time": "120",
                "scanType": "Quick"
            },
        "Exclusions": {
            "Extensions": "",
            "Paths": "",
            "Processes": ""
            }
        }
SETTINGS
}
