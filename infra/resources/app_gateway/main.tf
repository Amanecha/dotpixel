data "azurerm_key_vault_certificate" "appgw_cert" {
  name         = var.cert_name
  key_vault_id = var.key_vault_id
}

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
  domain_name_label = "dotapp-front-domain"
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
  name = "https-port"
  port = 443
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
    name                  = "httpsettings"
    port                  = 5000
    protocol              = "Http"
    cookie_based_affinity = "Disabled"
    request_timeout       = 60
  }

  ssl_certificate {
    name     = "appgw-cert"
    data     = var.ssl_cert_data
    password = var.cert_password
  }

  http_listener {
    name                           = "appGwHttpsListener"
    frontend_ip_configuration_name = "appGwFrontendIP"
    frontend_port_name             = "https-port"
    protocol                       = "Https"
    ssl_certificate_name           = "appgw-cert"
  }

  request_routing_rule {
    name                       = "https-rule"
    rule_type                  = "Basic"
    http_listener_name         = "appGwHttpsListener"
    backend_address_pool_name  = "aci-backend-pool"
    backend_http_settings_name = "httpsettings"
    priority                   = 1 
  }
}


resource "azurerm_monitor_diagnostic_setting" "appgw_diag" {
  name               = "appgw-diagnostics"
  target_resource_id = azurerm_application_gateway.appgw.id

  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "ApplicationGatewayAccessLog"
  }

  enabled_log {
    category = "ApplicationGatewayPerformanceLog"
  }

  enabled_log {
    category = "ApplicationGatewayFirewallLog"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
