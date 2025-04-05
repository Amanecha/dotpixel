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