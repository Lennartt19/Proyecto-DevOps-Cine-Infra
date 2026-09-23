# Variables del entorno PROD. Los valores van en terraform.tfvars.
variable "location" {
  type        = string
  description = "Región de Azure"
}

variable "resource_group_name" {
  type        = string
  description = "Nombre fijo del RG de prod"
}

variable "project" {
  type        = string
  description = "Etiqueta project"
}

variable "environment" {
  type        = string
  description = "Etiqueta env"
}
