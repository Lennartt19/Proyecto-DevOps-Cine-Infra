# Variables del entorno QA. Los valores van en terraform.tfvars.
variable "location" {
  type        = string
  description = "Región de Azure"
}

variable "resource_group_name" {
  type        = string
  description = "Nombre fijo del RG de qa"
}

variable "project" {
  type        = string
  description = "Etiqueta project"
}

variable "environment" {
  type        = string
  description = "Etiqueta env"
}
