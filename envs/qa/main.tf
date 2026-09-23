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

# Entorno QA: solo crea su resource group.
resource "azurerm_resource_group" "qa" {
  name     = "rg-cine-qa"
  location = "chilecentral"

  tags = {
    project = "cine"
    env     = "qa"
  }
}
