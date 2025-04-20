data "azurerm_client_config" "current" {}

resource "random_id" "unique_id" {
  byte_length = 8
}

module "app_service" {
  source           = "./resources/app_service"
  app_service_name = var.app_service_name
}

module "networking" {
  source              = "./resources/networking"
  resource_group_name = module.app_service.resource_group_name 
}

module "keyvault" {
  source = "./resources/key_vault"
  name                = var.keyvault_name
  resource_group_name = module.app_gateway.resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  service_principal_object_id  = data.azurerm_client_config.current.object_id
}

module "app_gateway" {
  source              = "./resources/app_gateway"
  appgw_dns_name = var.appgw_dns_name
  subnet_id           = module.networking.subnet_appgw_id
  vnet_id             = module.networking.vnet_id
  subnet_appgw_id = module.networking.subnet_appgw_id 
  subnet_aci_id = module.networking.subnet_aci_id
  vnet_name = module.networking.vnet_name
  log_analytics_workspace_id = module.loganalytics_workspace.log_analytics_workspace_id
  cert_name     = "appgw-cert"
  ssl_cert_data   = var.ssl_cert_data
  cert_password = var.cert_password
  key_vault_id   = module.keyvault.key_vault_id 
}


module "container_registry" {
  source = "./resources/container_registory"
  acr_username = var.acr_username
}

module "container_instances" {
  source = "./resources/container_instances"
  subnet_id           = module.networking.subnet_aci_id
  acr_username = var.acr_username
  acr_password = var.acr_password
  appgw_dns_name = var.appgw_dns_name
  resource_group_name = module.app_service.resource_group_name
  vnet_id             = module.networking.vnet_id
}

module "loganalytics_workspace" {
  source = "./resources/loganalytics_workspace"
  resource_group_name = module.app_gateway.resource_group_name
}

