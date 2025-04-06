resource "random_id" "unique_id" {
  byte_length = 8
}

module "app_gateway" {
  source              = "./resources/app_gateway"
}

module "app_service" {
  source           = "./resources/app_service"
  app_service_name = var.app_service_name
}

module "container_registry" {
  source = "./resources/container_registory"
  acr_username = var.acr_username
}

module "container_instances" {
  source = "./resources/container_instances"
  acr_username = var.acr_username
  acr_password = var.acr_password
}