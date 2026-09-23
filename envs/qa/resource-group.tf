# Entorno QA: solo crea su resource group.
resource "azurerm_resource_group" "qa" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    project = var.project
    env     = var.environment
  }
}
