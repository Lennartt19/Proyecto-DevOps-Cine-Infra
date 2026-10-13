# Valores del entorno PROD (nombres, sin secretos).
location                      = "chilecentral"
resource_group_name           = "rg-cine-prod"
project                       = "cine"
environment                   = "prod"
cluster_name                  = "aks-cine-prod"
sku_tier                      = "Free"
node_count                    = 1
vm_size                       = "Standard_B2s_v2"
shared_acr_name               = "acrcinedev01"
shared_acr_resource_group     = "rg-cine-dev"
shared_cluster_name           = "aks-cine-dev"
shared_cluster_resource_group = "rg-cine-dev"
key_vault_name                = "kvcineprod01"
key_vault_sku                 = "standard"
# Humano con acceso manual al vault (para depurar sin el CD).
# Vacío = no se crea el rol. Object id, no es secreto.
keyvault_admin_object_id = "c15cee35-a0e9-4fcc-8362-96514d3dcc2e"
