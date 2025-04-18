
resource "azurerm_resource_group" "app_gateway_rg" {
  name     = "app_gateway_rg"
  location = "japaneast"
}

resource "azurerm_public_ip" "appgw" {
  name                = "example-appgw-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.app_gateway_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "appgw" {
  name                = "example-appgw"
  location            = var.location
  resource_group_name = azurerm_resource_group.app_gateway_rg.name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "frontendPort"
    port = 5000
  }

  frontend_ip_configuration {
    name                 = "appGwFrontendIP"
    public_ip_address_id = azurerm_public_ip.appgw.id
  }

  backend_address_pool {
    name = "aci-backend-pool"
    fqdns = [ "${var.appgw_dns_name}.japaneast.azurecontainer.io" ]
  }

  backend_http_settings {
    name                  = "httpSettings"
    port                  = 5000
    protocol              = "Http"
    cookie_based_affinity = "Disabled"
    request_timeout       = 60
    request_body_buffering = true
    max_request_body_size   = 32
  }

  http_listener {
    name                           = "appGwHttpListener"
    frontend_ip_configuration_name = "appGwFrontendIP"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "appGwHttpListener"
    backend_address_pool_name  = "aci-backend-pool"
    backend_http_settings_name = "httpSettings"
    priority                   = 1 
  }
}

