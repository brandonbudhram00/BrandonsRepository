resource "azurerm_managed_disk" "data_disk" {
    count                   = length(var.vm_windows_name)
    name                    = "${var.vm_windows_name[0][0]}-data-disk${format("%1d", count.index + 1)}"
    location                = var.resource_group_location
    resource_group_name     = var.resource_group_name 
    storage_account_type    = "Standard_LRS"
    create_option           = "Empty"
    disk_size_gb            = 10
   
    tags = {
        Assignment     = "CCGC 5502 Automation Assignment"
        Name           = "brandon.budhram"
        ExpirationDate = "2024-12-31"
        Environment    = "Learning"
    }
}

resource "azurerm_virtual_machine_data_disk_attachment" "win_data_disk" {
    count               = length(var.vm_windows_name)
    managed_disk_id     = element(azurerm_managed_disk.data_disk[*].id, count.index + 1)
    virtual_machine_id  = var.windows_vm_id[count.index]
    lun                 = "0"
    caching             = "ReadWrite"
        depends_on      = [
            azurerm_managed_disk.data_disk
        ]
}   

resource "azurerm_managed_disk" "vmlinux_data_disk" {
    count                = length(var.vmlinux_name)
    name                 = "${var.vmlinux_name[0]}-data-disk${format("%1d", count.index + 1)}"
    location             = var.resource_group_location
    resource_group_name  = var.resource_group_name
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    disk_size_gb         = 10

    tags = {
        Assignment     = "CCGC 5502 Automation Assignment"
        Name           = "brandon.budhram"
        ExpirationDate = "2024-12-31"
        Environment    = "Learning"
    }
  
}

resource "azurerm_virtual_machine_data_disk_attachment" "linux_data_disk" {
    count               = length(var.vmlinux_name)
    managed_disk_id     = element(azurerm_managed_disk.vmlinux_data_disk[*].id, count.index + 1)
    virtual_machine_id  = var.linux_vm_id[count.index]
    lun                 = "0"
    caching             = "ReadWrite"
        depends_on = [ 
        azurerm_managed_disk.vmlinux_data_disk
         ]
}