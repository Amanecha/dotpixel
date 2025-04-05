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