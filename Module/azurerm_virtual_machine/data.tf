data "azurerm_subnet" "sdata" {
    for_each = var.vm
    name=each.value.snet_name
    resource_group_name = each.value.rg_name
    virtual_network_name = each.value.vnet_name
  
}

data "azurerm_key_vault" "keyvault" {
    for_each = var.kv
  name                = each.value.kv_name
  resource_group_name = each.value.rg_name
}

data "azurerm_key_vault_secret" "secret" {
    for_each = var.kv
  name         = each.value.secret_name
  key_vault_id = data.azurerm_key_vault.keyvault[each.key].id
}

