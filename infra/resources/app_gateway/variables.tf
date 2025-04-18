variable "location" {
  description = "Azure region"
  type        = string
  default     = "japaneast"
}

variable "appgw_dns_name" {
  description = "application gateway backend pool"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for Application Gateway"
  type        = string
}

variable "subnet_appgw_id" {
  description =""
  type = string
}

variable "subnet_aci_id" {
  description =""
  type = string
}

variable "vnet_id" {
  description = "ID of the virtual network"
  type        = string
}

variable "vnet_name" {
  description = "name of the virtual network"
  type        = string
}