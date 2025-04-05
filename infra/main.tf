resource "random_id" "unique_id" {
  byte_length = 8
}

module "app_service" {
  source           = "./resources/app_service"
  app_service_name = var.app_service_name
}

module "container_registry" {
  source = "./resources/container_registory"
}