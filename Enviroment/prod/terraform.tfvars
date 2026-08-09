rgs = {
  rg = {
    rg_name  = "gb-prodrg"
    location = "centralindia"
  }
}

vnet = {
  vnet1 = {
    vnet_name     = "prodvnet"
    rg_name       = "gb-prodrg"
    location      = "centralindia"
    address_space = ["10.0.0.0/16"]

  }
}

snet = {
  snet1 = {
    snet_name        = "frontend_subnet"
    vnet_name        = "prodvnet"
    rg_name          = "gb-prodrg"
    address_prefixes = ["10.0.0.0/24"]
  }
  snet2 = {
    snet_name        = "backend_subnet"
    vnet_name        = "prodvnet"
    rg_name          = "gb-prodrg"
    address_prefixes = ["10.0.2.0/24"]
  }
}


vms = {
  vm1 = {
    vm_name              = "frontendvm"
    nic_name             = "frontend_vm_nic"
    location             = "centralindia"
    rg_name              = "gb-prodrg"
    vnet_name            = "prodvnet"
    snet_name            = "frontend_subnet"
    vm_size              = "Standard_D2s_v3"
    computer_name        = "frontend"
    admin_username       = "devfrontend"
    kv_key               = "kv1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    publisher            = "Canonical"
    offer                = "0001-com-ubuntu-server-jammy"
    sku                  = "22_04-lts"
    version              = "latest"


  }
  vm2 = {
    vm_name              = "backendvm"
    nic_name             = "backend_vm_nic"
    location             = "centralindia"
    rg_name              = "gb-prodrg"
    vnet_name            = "prodvnet"
    snet_name            = "backend_subnet"
    vm_size              = "Standard_D2s_v3"
    computer_name        = "backend"
    admin_username       = "devbackend"
    kv_key               = "kv2"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    publisher            = "Canonical"
    offer                = "0001-com-ubuntu-server-jammy"
    sku                  = "22_04-lts"
    version              = "latest"



  }
}

kvs = {
  kv1 = {
    kv_name                     = "gb-prod-frontend-kv"
    secret_name                 = "frontendvm-secret"
    location                    = "centralindia"
    rg_name                     = "gb-prodrg"
    rbac_authorization_enabled  = false
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false

    sku_name = "standard"

  }

  kv2 = {
    kv_name                     = "gb-prod-backend-kv"
    secret_name                 = "backendvm-secret"
    location                    = "centralindia"
    rg_name                     = "gb-prodrg"
    rbac_authorization_enabled  = false
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false

    sku_name = "standard"

  }

}

vm_passwords = {
  kv1 = "Front@123"
  kv2 = "Back@123"
}
