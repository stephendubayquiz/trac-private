# Resource block for creating resource groups for each VNet
resource "azurerm_resource_group" "vnets_rg" {
  for_each = var.vnets

  name     = each.value.resource_group
  location = each.value.location



}



# Resource block for creating VNets within their respective resource groups
resource "azurerm_virtual_network" "vnets" {
  for_each = var.vnets

  name                = each.key
  resource_group_name = azurerm_resource_group.vnets_rg[each.key].name
  location            = each.value.location
  address_space       = each.value.address_space



}

# Resource block for creating subnets within each VNet
resource "azurerm_subnet" "subnets" {
  for_each = var.subnets
depends_on = [ azurerm_resource_group.vnets_rg, azurerm_virtual_network.vnets]
  name                 = each.key
  resource_group_name  = each.value.resource_group
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefix
   service_endpoints = ["Microsoft.ContainerRegistry"]
  
}
