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

module "app_gateway" {
  source              = "./resources/app_gateway"
  appgw_dns_name = var.appgw_dns_name
  subnet_id           = module.networking.subnet_appgw_id
  vnet_id             = module.networking.vnet_id
  subnet_appgw_id = module.networking.subnet_appgw_id 
  subnet_aci_id = module.networking.subnet_aci_id
  vnet_name = module.networking.vnet_name
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