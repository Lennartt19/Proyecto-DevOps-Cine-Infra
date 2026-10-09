# Entorno PROD: Container Registry básico para las imágenes backend/frontend.
resource "azurerm_container_registry" "prod" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.prod.name
  location            = var.location
  sku                 = var.acr_sku
  admin_enabled       = false

  tags = {
    project = var.project
    env     = var.environment
  }
}

# Permiso para que el AKS descargue imágenes del ACR (sin secretos).
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.prod.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.prod.kubelet_identity[0].object_id
}
