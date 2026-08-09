module "rgs" {
  source = "../../Module/azurerm_resource_group"
  rgs    = var.rgs
}

module "vnet" {
  depends_on = [module.rgs]
  source     = "../../Module/azurerm_virtual_network"
  vnet       = var.vnet
}

module "snet" {
  depends_on = [module.vnet]
  source     = "../../Module/azurerm_subnet"
  snet       = var.snet
}

module "vms" {
  depends_on = [module.rgs, module.snet, module.keyvault]
  source     = "../../Module/azurerm_virtual_machine"
  vm         = var.vms
  kv           = var.kvs
}

module "keyvault" {
  depends_on   = [module.rgs]
  source       = "../../Module/azurerm_keyvault"
  kv           = var.kvs
  vm_passwords = var.vm_passwords
}
