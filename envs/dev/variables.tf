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
