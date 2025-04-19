output "resource_group_name" {
  value = azurerm_resource_group.app_gateway_rg.name
}

output "appgw_fqdn" {
  value = azurerm_public_ip.appgw.fqdn
}