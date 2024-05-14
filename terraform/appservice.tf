terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.95.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Configuration options
}


data "azurerm_resource_group" "test1" {
  name     = "raja-appgrp"
}

resource "azurerm_app_service_plan" "example" {
  name                = "test-terra-plan"
  location            = data.azurerm_resource_group.test1.location
  resource_group_name = data.azurerm_resource_group.test1.name
  kind                = "Linux"  # Or "Windows" if you prefer
  reserved            = true
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "test-terra-appservice"
  location            = data.azurerm_resource_group.test1.location
  resource_group_name = data.azurerm_resource_group.test1.name
  app_service_plan_id = azurerm_app_service_plan.example.id
  site_config {
    linux_fx_version      = "DOTNETCORE|3.1"  # Adjust according to your application
    # windows_fx_version = "NODE|14-lts"      # Uncomment and adjust for Windows
    
  }
}
