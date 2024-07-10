
data "azurerm_client_config" "current" {}
/*
resource "azurerm_resource_group" "aks_rg" {
  name     = "${var.aks_resource_group_name}-${var.environment}-${var.location_short}"
  location = var.location
  
}*/

/*
module "aks_user_assigned_identity" {
  source              = "../modules/user_identity"
  user_identity_name  = "uai-aks-${var.base_name}-${var.location_short}"
  resource_group_name = upper("RG-ALS-${var.base_name}-MGMT-${var.location_short}")
  location            = var.location

}*/

module "aks_cluster" {
  source                    = "../modules/aks"
  resource_group            = upper("RG-AKS-${var.base_name}-MGMT-${var.location_short}")
  node_resource_group       = upper("RG-AKS-${var.base_name}-CLUSTER-${var.location_short}")
  cluster_name              = "aks-${var.base_name}-${var.location_short}"
  location                  = var.location
  location_short            = var.location_short
  kubernetes_version        = var.aks_kubernetes_version
  user_assigned_identity_id = "/subscriptions/6e1fe5ed-3359-43df-b4b1-946796a9eaea/resourceGroups/RG-AKS-DEVQA-MGMT-E1/providers/Microsoft.ManagedIdentity/userAssignedIdentities/uai-aks-devqa-E1"
  node_pools = var.node_pools
  namespaces = local.namespaces
  node_subnet_id = data.azurerm_subnet.aks_subnet.id
  dns_service_ip = var.dns_service_ip
  docker_bridge_cidr = var.docker_bridge_cidr
  service_cidr = var.service_cidr
  tags = var.tags
}

/*
module "keyvault" {
  source     = "../modules/keyvault"
  resource_group_name       = azurerm_resource_group.aks_rg.name
  location                  = var.location
  user_assigned_principal_id = module.aks_user_assigned_identity.identity_principal_id
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  pe_subnet_id              = var.pe_subnet_id
  virtual_network_id = var.virtual_network_id
  location_short            = var.location_short
  environment =             var.environment
}
/*
module "app_configuration" {
  source = "./modules/app_config"
  depends_on = [ module.keyvault ]
  name                       = "appConf2"
  resource_group_name        = var.aks_resource_group_name
  location                   = var.location
  sku                        = "standard"
  local_auth_enabled         = true
  public_network_access      = "Enabled"
  purge_protection_enabled   = false
  soft_delete_retention_days = 1

  identity_type              = "UserAssigned"
  identity_ids               = [module.aks_user_assigned_identity.identity_id]

  encryption_key_vault_key_identifier = module.keyvault.key_vault_key_identifier
  encryption_identity_client_id       = module.user_assigned_identity.client_id
  replica_name               = "replica1"
  replica_location           = "West US"

  tags = {
    environment = "development"
  }
/*
  depends_on = [
    azurerm_key_vault_access_policy.client,
    azurerm_key_vault_access_policy.server,
  ]

}  
*/