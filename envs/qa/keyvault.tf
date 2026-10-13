# Entorno QA: Key Vault para los secretos de la app (BD, JWT).
# Los VALORES no viven aquí: el CD los escribe desde GitHub Secrets
# (az keyvault secret set). Terraform solo crea la caja fuerte y los permisos.
data "azurerm_client_config" "current" {}

# AKS COMPARTIDO (cupo Students: 3 IPs en chilecentral, 1 AKS+Ingress = 2).
# qa/prod corren como namespaces (cine-qa/cine-prod) en aks-cine-dev:
# no hay AKS propio aquí, así que los permisos van al kubelet de dev.
data "azurerm_kubernetes_cluster" "shared" {
  name                = var.shared_cluster_name
  resource_group_name = var.shared_cluster_resource_group
}

resource "azurerm_key_vault" "qa" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = azurerm_resource_group.qa.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku

  # Permisos por RBAC de Azure (modelo actual, sin access policies).
  rbac_authorization_enabled = true

  tags = {
    project = var.project
    env     = var.environment
  }
}

# El kubelet del AKS COMPARTIDO (dev) puede LEER secretos de este vault.
# Sin esto, el driver CSI de los pods de cine-qa falla con 403.
resource "azurerm_role_assignment" "aks_kv_secrets_user" {
  scope                = azurerm_key_vault.qa.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = data.azurerm_kubernetes_cluster.shared.kubelet_identity[0].object_id
}

# El CD (la misma identidad que ejecuta Terraform/CI vía OIDC) puede
# ESCRIBIR secretos. Requiere el bootstrap "User Access Administrator"
# (ver README); con él, este `apply` auto-repara el permiso en cada recreate.
resource "azurerm_role_assignment" "cd_kv_secrets_officer" {
  scope                = azurerm_key_vault.qa.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

# Acceso manual del humano (opcional, para depurar sin depender del CD).
# Se crea solo si `keyvault_admin_object_id` trae valor (object id del usuario).
resource "azurerm_role_assignment" "admin_kv_secrets_officer" {
  count                = var.keyvault_admin_object_id != "" ? 1 : 0
  scope                = azurerm_key_vault.qa.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.keyvault_admin_object_id
}
