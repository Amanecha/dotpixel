resource "azurerm_container_group" "example" {
  name                = "example-container-group"
  location            = "japaneast"
  resource_group_name = "acr-example-resources"
  os_type             = "Linux"

  container {
    name   = "flask-pixel-app"
    image  = "exampleacrv4f3gjji.azurecr.io/flask-pixel-app:0405_1"
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