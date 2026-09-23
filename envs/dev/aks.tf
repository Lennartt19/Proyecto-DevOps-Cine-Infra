# Entorno DEV: AKS básico sobre el RG ya creado.
resource "azurerm_kubernetes_cluster" "dev" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = azurerm_resource_group.dev.name
  dns_prefix          = var.cluster_name
  sku_tier            = var.sku_tier

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    project = var.project
    env     = var.environment
  }
}
