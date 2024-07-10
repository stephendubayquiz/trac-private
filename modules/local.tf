locals {
  environments_map = { for env in var.environments : env => env }
}

locals {
  subnet_ids = {
    for env in var.environments : env => data.azurerm_subnet.aks_subnet[env].id
  }
}


locals {
  namespaces = flatten([
    for env in var.environments : [
      for app in var.applications : [
        for suffix in var.deployment_suffixes : "${app}-${env}-${suffix}"
      ]
    ]
  ])
}
