data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = var.sku_name

  enable_rbac_authorization  = true 

  purge_protection_enabled    = false
  soft_delete_retention_days  = 7
}

resource "random_uuid" "role_assignment" {}

resource "azurerm_role_assignment" "keyvault_cert_access" {
  name               = random_uuid.role_assignment.result
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = var.service_principal_object_id
}