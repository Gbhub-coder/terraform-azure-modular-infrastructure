data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  for_each = var.kv
  name                        = each.value.kv_name
  location                    = each.value.location
  resource_group_name         = each.value.rg_name
  rbac_authorization_enabled  = each.value.rbac_authorization_enabled
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled

  sku_name = each.value.sku_name

access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get"
    ]

     secret_permissions = [
    "Get",
    "Set",
    "Delete"
  ]

    storage_permissions = [
      "Get",
    ]
  }
  
}

resource "azurerm_key_vault_secret" "admin_password" {
  for_each = var.kv
  name         = each.value.secret_name
  value        = var.vm_passwords[each.key]
  key_vault_id = azurerm_key_vault.keyvault[each.key].id
}