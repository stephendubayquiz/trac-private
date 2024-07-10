variable "private_endpoint_details" {
  description = "Details of the private endpoint"
  type        = object({
    name                  = string
    private_ip_address    = string
    private_dns_zone_name = string
    resource_group_name   = string
  })
}

variable "virtual_network_id" {
  description = "The ID of the virtual network"
  type        = string
  
}