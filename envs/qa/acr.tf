# QA no tiene ACR propio: usa el ACR compartido de dev (ver terraform.tfvars).
# Dev/QA/Prod despliegan el mismo SHA desde ese único registry (ver cd-qa.yml).
# Este bloque solo da permiso AcrPull al AKS de QA sobre el ACR compartido.
data "azurerm_container_registry" "shared" {
  name                = var.shared_acr_name
  resource_group_name = var.shared_acr_resource_group
}

# Permiso para que el AKS de QA descargue imágenes del ACR compartido (sin secretos).
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = data.azurerm_container_registry.shared.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.qa.kubelet_identity[0].object_id
}
