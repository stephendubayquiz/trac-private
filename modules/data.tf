data "azurerm_virtual_network" "aks_vnet" {
  name = "VNET-TRAC-HUB-Non-PROD-E1"
  resource_group_name = "RG-AKS-DEVQA-MGMT-E1"
}

data "azurerm_subnet" "aks_subnet" {
  for_each = local.environments_map

  name                 = "SNET-AKS-${each.value}-E1"
  virtual_network_name = data.azurerm_virtual_network.aks_vnet.name
  resource_group_name  = "RG-AKS-DEVQA-MGMT-E1"
}


/*

data "azurerm_virtual_network" "aks_vnet" {
  name = "VNET-TRAC-HUB-${var.environment}-E1"
  resource_group_name = "RG-Networks-Shared-E1"
}

data "azurerm_subnet" "aks_subnet" {
  for_each = local.environments_map

  name                 = "SNET-AKS-${each.value}-E1"
  virtual_network_name = data.azurerm_virtual_network.aks_vnet.name
  resource_group_name  = "RG-Networks-Shared-E1"
}*/