# Valores del entorno DEV (nombres, sin secretos).
location            = "chilecentral"
resource_group_name = "rg-cine-dev"
project             = "cine"
environment         = "dev"
cluster_name        = "aks-cine-dev"
sku_tier            = "Free"
node_count          = 1
vm_size             = "Standard_B2s_v2"
acr_name            = "acrcinedev01"
acr_sku             = "Basic"
