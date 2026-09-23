terraform {
  required_version = ">= 1.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

# Entorno DEV: solo crea su resource group.
resource "azurerm_resource_group" "dev" {
  name     = "rg-cine-dev"
  location = "chilecentral"

  tags = {
    project = "cine"
    env     = "dev"
  }
}
