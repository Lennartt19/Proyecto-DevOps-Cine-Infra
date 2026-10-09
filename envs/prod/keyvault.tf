# Entorno PROD: Key Vault para los secretos de la app (BD, JWT).
# Los VALORES no viven aquí: el CD los escribe desde GitHub Secrets
# (az keyvault secret set). Terraform solo crea la caja fuerte y los permisos.
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "prod" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = azurerm_resource_group.prod.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku

  # Permisos por RBAC de Azure (modelo actual, sin access policies).
  rbac_authorization_enabled = true

  tags = {
    project = var.project
    env     = var.environment
  }
}

# El AKS (identidad kubelet) puede LEER secretos del vault. Sin esto,
# el driver CSI de los pods falla con 403.
resource "azurerm_role_assignment" "aks_kv_secrets_user" {
  scope                = azurerm_key_vault.prod.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_kubernetes_cluster.prod.kubelet_identity[0].object_id
}

# El CD (la misma identidad que ejecuta Terraform/CI vía OIDC) puede
# ESCRIBIR secretos. Requiere el bootstrap "User Access Administrator"
# (ver README); con él, este `apply` auto-repara el permiso en cada recreate.
resource "azurerm_role_assignment" "cd_kv_secrets_officer" {
  scope                = azurerm_key_vault.prod.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

# Acceso manual del humano (opcional, para depurar sin depender del CD).
# Se crea solo si `keyvault_admin_object_id` trae valor (object id del usuario).
resource "azurerm_role_assignment" "admin_kv_secrets_officer" {
  count                = var.keyvault_admin_object_id != "" ? 1 : 0
  scope                = azurerm_key_vault.prod.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.keyvault_admin_object_id
}
