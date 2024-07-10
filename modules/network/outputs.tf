
output "vnets" {
 
      value = { for v in azurerm_virtual_network.vnets : v.name => {
    name = v.name
    id                   = v.id
    address_space      = v.address_space
    location = v.location
    resource_group_name  = v.resource_group_name
  }}
}

 output "subnets" {
  description = "The attributes of the subnet details"
  value = { for s in azurerm_subnet.subnets : s.name => {
    name = s.name
    id                   = s.id
    address_prefix       = s.address_prefixes
    virtual_network_name = s.virtual_network_name
    resource_group_name  = s.resource_group_name
  }}
}

output "network_info" {
  value = { for v in azurerm_virtual_network.vnets : v.name => {
    name                = v.name
    id                  = v.id
    address_space       = v.address_space
    location            = v.location
    resource_group_name = v.resource_group_name
    subnets             = { for s in azurerm_subnet.subnets : s.name => {
      name                = s.name
      id                  = s.id
      address_prefix      = s.address_prefixes
      virtual_network_name= s.virtual_network_name
      resource_group_name = s.resource_group_name
    } if s.virtual_network_name == v.name }
  }}
}

