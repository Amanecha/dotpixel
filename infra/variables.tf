variable "app_service_name" {
  description = "App Service name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "japaneast"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}
variable "acr_password" {
  description = "ACR admin password"
  type        = string
  sensitive   = true
}

variable "acr_username" {
  description = "ACR admin username"
  type        = string
}

variable "appgw_dns_name" {
  description = "application gateway backend pool"
  type        = string
}

variable "keyvault_name" {
  type        = string
}

variable "cert_name" {
  default = "appgw-cert"
}

variable "cert_password" {
  description = "Password for the .pfx certificate"
  type        = string
}

variable "ssl_cert_data" {
  description = "SSL certificate data"
  type        = string
}