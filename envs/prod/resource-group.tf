# Entorno PROD: solo crea su resource group.
resource "azurerm_resource_group" "prod" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    project = var.project
    env     = var.environment
  }
}
