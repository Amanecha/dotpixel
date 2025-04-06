module "app_gateway" {
  source              = "../app_gateway"
}

resource "azurerm_container_group" "example" {
  name                = "example-container-group"
  location            = "japaneast"
  resource_group_name = "acr-example-resources"
  os_type             = "Linux"
  ip_address_type     = "Public"
  dns_name_label      = "dot-pixel-api-app"
  network_profile_id = azurerm_network_profile.aci_profile.id

  container {
    name   = "flask-pixel-app"
    image  = "${var.acr_username}.azurecr.io/flask-pixel-app:0406_1"
    cpu    = "1"
    memory = "1.5"
    ports {
      port     = 5000
      protocol = "TCP"
    }
  }
  
  image_registry_credential {
    server = "${var.acr_username}.azurecr.io"
    username = var.acr_username
    password = var.acr_password
  }
  
  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_profile" "aci_profile" {
  name                = "aci-netprofile"
  location            = "japaneast"
  resource_group_name = "acr-example-resources"

  container_network_interface {
    name = "aci-nic"
    ip_configuration {
      name      = "aci-ipconfig"
      subnet_id = module.app_gateway.aci_subnet_id
    }
  }
}

output "container_group_ip" {
  value = azurerm_container_group.example.ip_address
}

