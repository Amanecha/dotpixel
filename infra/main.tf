terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  cloud {
    organization = "mol-org"
    workspaces {
      name = "dotapp"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_id" "unique_id" {
  byte_length = 8
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "japaneast"
}

resource "azurerm_service_plan" "example" {
  name                = "example-app-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "example" {
  name                = var.app_service_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.example.location
  service_plan_id     = azurerm_service_plan.example.id
  site_config {
    app_command_line = "pm2 serve /home/site/wwwroot --no-daemon --spa"
  }
}