locals {
  environments_map = { for env in var.environments : env => env }
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
