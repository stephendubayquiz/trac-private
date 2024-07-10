

resource "azurerm_private_dns_zone" "zone" {
  name                = var.private_endpoint_details.private_dns_zone_name
  resource_group_name = var.private_endpoint_details.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "zone_link" {
  name                  = "${var.private_endpoint_details.name}-vnet-link"
  resource_group_name   = var.private_endpoint_details.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.zone.name
  virtual_network_id    = var.virtual_network_id
}

resource "azurerm_private_dns_a_record" "record" {
  name                = var.private_endpoint_details.name
  zone_name           = azurerm_private_dns_zone.zone.name
  resource_group_name = var.private_endpoint_details.resource_group_name
  ttl                 = 300
  records             = [var.private_endpoint_details.private_ip_address]
}
