resource "azurerm_availability_set" "linux_availability_set" {
    name                         = var.vmlinux_avs
    location                     = var.resource_group_location
    resource_group_name          = var.resource_group_name
    platform_update_domain_count = 5
    platform_fault_domain_count  = var.nb_count
    tags = {
        environment = "production"
    } 
}

resource "azurerm_network_interface" "vmlinux_network_interface" {
    count               = var.nb_count
    name                = "${var.vmlinux_name}-nic${format("%1d", count.index + 1)}"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name

    ip_configuration {
      name                          = "${var.vmlinux_name}1-ipconfig1${format("%1d", count.index + 1)}"
      subnet_id                     = var.subnet_id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = element(azurerm_public_ip.vmlinux_public_ip[*].id, count.index + 1) 
    }

    tags = {
        Assignment     = "CCGC 5502 Automation Assignment"
        Name           = "brandon.budhram"
        ExpirationDate = "2024-12-31"
        Environment    = "Learning"
    }
}

resource "azurerm_public_ip" "vmlinux_public_ip" {
    count                   = var.nb_count
    name                    = "${var.vmlinux_name}-pip${format("%1d", count.index + 1)}"
    resource_group_name     = var.resource_group_name
    location                = var.resource_group_location
    allocation_method       = "Dynamic"
    domain_name_label       = "domain1-${lower(replace(var.vmlinux_name, "/[^a-zA-Z0-9-]/", ""))}-${format("%1d", count.index + 1)}"
    idle_timeout_in_minutes = 30

    tags = {
        Assignment     = "CCGC 5502 Automation Assignment"
        Name           = "brandon.budhram"
        ExpirationDate = "2024-12-31"
        Environment    = "Learning"
    }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
    count               = var.nb_count
    name                = "${var.vmlinux_name}${format("%1d", count.index + 1)}"
    computer_name       = "${var.vmlinux_name}${format("%1d", count.index + 1)}"
    resource_group_name = var.resource_group_name
    location            = var.resource_group_location
    size                = var.vmlinux_size
    admin_username      = var.admin_username
    availability_set_id = azurerm_availability_set.linux_availability_set.id

    tags = {
        Assignment     = "CCGC 5502 Automation Assignment"
        Name           = "brandon.budhram"
        ExpirationDate = "2024-12-31"
        Environment    = "Learning"
    }

    network_interface_ids = [
        element(azurerm_network_interface.vmlinux_network_interface[*].id, count.index + 1)
    ]

    depends_on = [ 
        azurerm_availability_set.linux_availability_set
    ]

    boot_diagnostics {
        storage_account_uri = var.st_acc_u.primary_blob_endpoint
    }

    admin_ssh_key {
        username   = var.admin_username
        public_key = file(var.public_key)
    }

    os_disk {
        name                 = "${var.vmlinux_name}-os-disk${format("%1d", count.index + 1)}"
        caching              = var.os_disk_attributes["os-disk-caching"]
        storage_account_type = var.os_disk_attributes["os-storage-account-type"]
        disk_size_gb         = var.os_disk_attributes["os-disk-size"] 
    }

    source_image_reference {
      publisher              = var.source_images_details["os-publisher"]
      offer                  = var.source_images_details["os-offer"]
      sku                    = var.source_images_details["os-sku"]
      version                = var.source_images_details["os-version"]
    }
}

resource "azurerm_virtual_machine_extension" "vmlinux_network_watcher" {
    count                      = var.nb_count
    name                       = "vmlinx_network_watcher-${count.index + 1}"
    virtual_machine_id         = azurerm_linux_virtual_machine.linux_vm[count.index].id
    publisher                  = "Microsoft.Azure.NetworkWatcher"
    type                       = "NetworkWatcherAgentLinux"
    type_handler_version       = "1.4"
    auto_upgrade_minor_version = true 

    tags = {
        Assignment     = "CCGC 5502 Automation Assignment"
        Name           = "brandon.budhram"
        ExpirationDate = "2024-12-31"
        Environment    = "Learning"
    }

    settings =  <<SETTINGS
        {
            "XMLCfg": ""
        }
SETTINGS

    protected_settings = <<PROTECTED_SETTINGS
        {
            "storageAccountName": "${var.storage_account_name}",
            "storageAccountKey": "${var.storage_account_key.primary_access_key}"
        }
PROTECTED_SETTINGS
}


resource "azurerm_virtual_machine_extension" "azure_monitor_extension" {
    count                      = var.nb_count
    name                       = "azure_monitor_extension-${count.index + 1}"
    virtual_machine_id         = azurerm_linux_virtual_machine.linux_vm[count.index].id
    publisher                  = "Microsoft.Azure.Monitor"
    type                       = "AzureMonitorLinuxAgent"
    type_handler_version       = "1.0"
    auto_upgrade_minor_version = true

    tags = {
        Assignment     = "CCGC 5502 Automation Assignment"
        Name           = "brandon.budhram"
        ExpirationDate = "2024-12-31"
        Environment    = "Learning"
    }
    settings = <<SETTINGS
        {
        }
SETTINGS
}


