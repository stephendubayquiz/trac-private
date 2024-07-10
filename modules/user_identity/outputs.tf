output "identity_id" {
  value = azurerm_user_assigned_identity.aks_identity.id
}

output "identity_name" {
  value = azurerm_user_assigned_identity.aks_identity.name
}

output "identity_principal_id" {
  value = azurerm_user_assigned_identity.aks_identity.principal_id
}

output "client_id" {
    value = azurerm_user_assigned_identity.aks_identity.client_id
  
}