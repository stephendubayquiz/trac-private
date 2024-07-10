variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "location_short" {
  description = "The short location of the resource group"
  type        = string
  
}

variable "user_assigned_principal_id" {
  description = "The ID of the user-assigned managed identity for the AKS cluster"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the AKS cluster"
  type        = string
  
}

variable "pe_subnet_id" {
  description = "The subnet ID for the private endpoint"
  type        = string
  
}

variable "virtual_network_id" {
  description = "The ID of the virtual network"
  type        = string
}


variable "environment" {
  description = "The environment for the resource group"
  type        = string
}