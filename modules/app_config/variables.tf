variable "name" {
  description = "Name of the Azure App Configuration"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where Azure App Configuration will be created"
  type        = string
}

variable "location" {
  description = "Location for Azure App Configuration"
  type        = string
}

variable "sku" {
  description = "SKU of Azure App Configuration"
  type        = string
  default     = "standard"
}

variable "local_auth_enabled" {
  description = "Flag indicating if local authentication is enabled"
  type        = bool
  default     = true
}

variable "public_network_access" {
  description = "Flag indicating if public network access is enabled"
  type        = string
  default     = "Enabled"
}

variable "purge_protection_enabled" {
  description = "Flag indicating if purge protection is enabled"
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain soft deleted resources"
  type        = number
  default     = 1
}

variable "identity_type" {
  description = "Type of identity for Azure App Configuration"
  type        = string
  default     = "UserAssigned"
}

variable "identity_ids" {
  description = "List of User Assigned Identity IDs"
  type        = list(string)
}

variable "encryption_key_vault_key_identifier" {
  description = "Key Vault Key Identifier for encryption"
  type        = string
}

variable "encryption_identity_client_id" {
  description = "Client ID of User Assigned Identity for encryption"
  type        = string
}

variable "replica_name" {
  description = "Name of the replica"
  type        = string
}

variable "replica_location" {
  description = "Location of the replica"
  type        = string
}

variable "tags" {
  description = "Tags for Azure App Configuration"
  type        = map(string)
}

