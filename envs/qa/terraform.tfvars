# Valores del entorno QA (nombres, sin secretos).
location            = "chilecentral"
resource_group_name = "rg-cine-qa"
project             = "cine"
environment         = "qa"
cluster_name        = "aks-cine-qa"
sku_tier            = "Free"
node_count          = 1
vm_size             = "Standard_B2s_v2"
acr_name            = "acrcineqa01"
acr_sku             = "Basic"
key_vault_name      = "kvcineqa01"
key_vault_sku       = "standard"
# Humano con acceso manual al vault (para depurar sin el CD).
# Vacío = no se crea el rol. Object id, no es secreto.
keyvault_admin_object_id = "c15cee35-a0e9-4fcc-8362-96514d3dcc2e"
