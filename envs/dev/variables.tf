# Variables del entorno DEV. Los valores van en terraform.tfvars.
variable "location" {
  type        = string
  description = "Región de Azure"
}

variable "resource_group_name" {
  type        = string
  description = "Nombre fijo del RG de dev"
}

variable "project" {
  type        = string
  description = "Etiqueta project"
}

variable "environment" {
  type        = string
  description = "Etiqueta env"
}

variable "cluster_name" {
  type        = string
  description = "Nombre del AKS en dev"
}

variable "sku_tier" {
  type        = string
  description = "Tier del control-plane (Free para Students)"
}

variable "node_count" {
  type        = number
  description = "Nodos del pool default"
}

variable "vm_size" {
  type        = string
  description = "Tamaño de VM de los nodos"
}

variable "acr_name" {
  type        = string
  description = "Nombre global único del Container Registry (minúsculas y números, 5-50)"
}

variable "acr_sku" {
  type        = string
  description = "SKU del ACR (Basic para dev Students)"
}

variable "key_vault_name" {
  type        = string
  description = "Nombre global único del Key Vault (letras, números y guiones, 3-24)"
}

variable "key_vault_sku" {
  type        = string
  description = "SKU del Key Vault (standard para dev)"
}
