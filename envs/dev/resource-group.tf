# Entorno DEV: solo crea su resource group.
resource "azurerm_resource_group" "dev" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    project = var.project
    env     = var.environment
  }
}
