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

variable "subnet_id" {
  description = "ID of the subnet for Container Instances"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "vnet_id" {
  description = ""
  type = string
}