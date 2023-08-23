module "resource_group" {
    source                  = "./modules/rgroup-n01291582"
    resource_group_name     = "n01291582-RG"
    resource_group_location = "Canada Central" 
}

module "network" {
    source                  = "./modules/network-n01291582"
    resource_group_name     = module.resource_group.resource_group_name.name
    resource_group_location = module.resource_group.resource_group_location.location
    depends_on              = [ 
                                module.resource_group
        ]
}

module "common" {
    source                  = "./modules/common-n01291582"
    resource_group_name     = module.resource_group.resource_group_name.name
    resource_group_location = module.resource_group.resource_group_location.location
    subnet_id               = module.network.virtual_network_subnet_name
    depends_on               = [ 
                                module.resource_group
     ]
}

module "vmlinux" { 
    source                  = "./modules/vmlinux-n01291582"
    nb_count                = "3"
    vmlinux_name            = "vmlinux-n01291582"
    resource_group_name     = module.resource_group.resource_group_name.name
    resource_group_location = module.resource_group.resource_group_location.location
    subnet_id               = module.network.virtual_network_subnet_name.id
    depends_on              = [
                                module.resource_group,
                                module.network,
                                module.common
    ]
    storage_account_name    = module.common.storage_account_name.name
    storage_account_key     = module.common.storage_account_key
    st_acc_u                = module.common.storage_account_name
}

module "vmwindows" {
    source                  = "./modules/vmwindows-n01291582"
    vm_windows_name          = {
            n01291582-vm1   = "Standard_B1S"
            n01291582-vmw   = "Standard_B1S"
    }
    windows_nb_count        = "1"
    subnet_id               = module.network.virtual_network_subnet_name.id
    resource_group_name     = module.resource_group.resource_group_name.name
    resource_group_location = module.resource_group.resource_group_location.location
    storage_account                  = module.common.storage_account_name
    depends_on              = [
                            module.resource_group,
                            module.network,
                            module.common
    ]

}

module "data_disk" {
    source                  = "./modules/datadisk-n01291582"
    resource_group_name     = module.resource_group.resource_group_name.name
    resource_group_location = module.resource_group.resource_group_location.location
    vm_windows_name          = module.vmwindows.vm_windows_hostname
    windows_vm_id           = module.vmwindows.win_vm
    vmlinux_name            = module.vmlinux.linux_hostname
    linux_vm_id             = module.vmlinux.linux_id
    depends_on              = [ 
                                module.resource_group,
                                module.vmlinux,
                                module.vmwindows
     ]
}

module "load_balancer" {
    source                  = "./modules/loadbalancer-n01291582"
    resource_group_name     = module.resource_group.resource_group_name.name
    resource_group_location = module.resource_group.resource_group_location.location
    vmlinux_public_ip       = module.vmlinux.linux_public_ip
    vmlinux_nic_id          = module.vmlinux.linux_nic_id[0]
    nb_count                = "1"
    vmlinux_name            = module.vmlinux.linux_hostname
    subnet_id               = module.network.virtual_network_subnet_name
    depends_on              = [ 
                                module.resource_group,
                                module.vmlinux,
     ]
}

module "database" {
    source                  = "./modules/database-n01291582"
    resource_group_name     = module.resource_group.resource_group_name.name
    resource_group_location = module.resource_group.resource_group_location.location
    depends_on              = [ 
                                module.resource_group
     ]
}