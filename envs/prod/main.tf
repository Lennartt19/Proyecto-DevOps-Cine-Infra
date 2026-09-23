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

# Entorno PROD: solo crea su resource group.
resource "azurerm_resource_group" "prod" {
  name     = "rg-cine-prod"
  location = "chilecentral"

  tags = {
    project = "cine"
    env     = "prod"
  }
}
