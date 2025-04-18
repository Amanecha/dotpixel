resource "random_string" "unique" {
  length           = 8
  special          = false   # 特殊文字を使わない
  upper             = false  # 大文字を使わない（必要ならTrueに）
  lower             = true   # 小文字を使う
  numeric = true
}

resource "azurerm_resource_group" "example" {
  name     = "acr-example-resources"
  location = "japaneast"
}

resource "azurerm_container_registry" "example" {
  name                = var.acr_username
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                  = "Basic"
  admin_enabled       = true
}
