variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "tenant_id" {}
variable "sku_name" {
  default = "standard"
}

variable "service_principal_object_id" {
  description = "Object ID of the service principal that needs access to Key Vault"
  type        = string
}
