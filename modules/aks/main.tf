
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  

  default_node_pool {
    name                           = "defaultpool"
    node_count = 1
    vm_size    = var.node_vm_size
    vnet_subnet_id = var.node_subnet_id
   
  }


 http_application_routing_enabled = true

azure_policy_enabled = true

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
    service_cidr       = var.service_cidr
    network_policy     = "calico"
  }

  identity {
    type = "UserAssigned"
    identity_ids = [var.user_assigned_identity_id]
  }

  tags = var.tags 

  
}


resource "azurerm_kubernetes_cluster_node_pool" "example" {
  for_each = var.node_pools

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = lower("aksnp${each.key}${var.location_short}")
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  vnet_subnet_id        = var.node_subnet_id
  os_disk_size_gb       = each.value.os_disk_size_gb
  max_pods              = each.value.max_pods
  enable_auto_scaling   = each.value.enable_auto_scaling
  os_type = "Linux"
  os_sku = "AzureLinux"
  min_count             = each.value.enable_auto_scaling ? each.value.min_count : null
  max_count             = each.value.enable_auto_scaling ? each.value.max_count : null

  kubelet_config {
    cpu_manager_policy     = each.value.kubelet_config.cpu_manager_policy
   
    image_gc_high_threshold = each.value.kubelet_config.image_gc_high_threshold
    image_gc_low_threshold  = each.value.kubelet_config.image_gc_low_threshold
    topology_manager_policy = each.value.kubelet_config.topology_manager_policy

    allowed_unsafe_sysctls  = each.value.kubelet_config.allowed_unsafe_sysctls
  }

  tags = each.value.tags
}


resource "kubernetes_namespace" "app_namespace" {
  depends_on = [ azurerm_kubernetes_cluster.aks ]
  for_each = toset(var.namespaces)
  
  metadata {
    name = each.key
  }
}

resource "azurerm_private_endpoint" "aks_private_endpoint" {
  name                = "${var.cluster_name}-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group
  subnet_id           = var.node_subnet_id

  private_service_connection {
    name                           = "aksPrivateLink"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_kubernetes_cluster.aks.id
    subresource_names              = ["management"]
  }
}


 