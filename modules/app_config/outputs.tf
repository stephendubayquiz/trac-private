

output "app_configuration_id" {
  description = "The ID of the created Azure App Configuration"
  value       = azurerm_app_configuration.example.id
}

output "app_configuration_endpoint" {
  description = "The endpoint URL of the Azure App Configuration"
  value       = azurerm_app_configuration.example.endpoint
}