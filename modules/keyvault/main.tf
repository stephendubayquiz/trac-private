
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                = "kvttracaks${var.environment}${var.location_short}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = true
}

resource "azurerm_role_assignment" "role" {
  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = "Reader"
  principal_id         = var.user_assigned_principal_id
}


resource "azurerm_key_vault_access_policy" "server" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.user_assigned_principal_id

  key_permissions    = ["Get", "UnwrapKey", "WrapKey"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "GetRotationPolicy"]
  secret_permissions = ["Get"]
}


resource "azurerm_key_vault_key" "key" {
  name         = "key-trac-aks-${var.environment}-${var.location_short}"
  key_vault_id = azurerm_key_vault.keyvault.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey"
  ]

  depends_on = [
    azurerm_key_vault_access_policy.client,
    azurerm_key_vault_access_policy.server,
  ]
}

resource "azurerm_private_endpoint" "kvt-pe" {
  name                = "pe-kvt-trac-${var.environment}-${var.location_short}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "psc-kvt-trac-${var.environment}-${var.location_short}"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
}

locals{
  kvt_private_endpoint_details = {
    name                  = azurerm_private_endpoint.kvt-pe.name
    private_ip_address    = azurerm_private_endpoint.kvt-pe.private_service_connection[0].private_ip_address
    private_dns_zone_name = "privatelink.vaultcore.azure.net"
    resource_group_name   = var.resource_group_name
  }
} 

module "private_dns" {
  source                      = "../private_dns"
  private_endpoint_details    = local.kvt_private_endpoint_details
  virtual_network_id = var.virtual_network_id
}





