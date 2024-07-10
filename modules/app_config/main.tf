resource "azurerm_app_configuration" "example" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  sku                        = var.sku
  local_auth_enabled         = var.local_auth_enabled
  public_network_access      = var.public_network_access
  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  encryption {
    key_vault_key_identifier = var.encryption_key_vault_key_identifier
    identity_client_id       = var.encryption_identity_client_id
  }

  replica {
    name     = var.replica_name
    location = var.replica_location
  }

  tags = var.tags


}
