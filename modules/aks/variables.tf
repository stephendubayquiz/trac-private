variable "resource_group" {
  description = "Name of the resource group where AKS will be deployed"
}

variable "location_short" {
  description = "short abbv region"
}

variable "node_resource_group" {
  description = "Name of the node resource group"
}
variable "cluster_name" {
  description = "Name of the AKS cluster"
}

variable "location" {
  description = "Azure region where AKS will be deployed"
}

variable "node_count" {
  description = "Number of nodes in the AKS node pool"
  default     = 3
}

variable "node_vm_size" {
  description = "VM size for AKS nodes"
  default     = "Standard_DS2_v2"
}

variable "namespaces" {
  description = "List of namespaces to create in the AKS cluster"
  type        = list(string)
  default     = []
}

variable "node_subnet_id" {
  description = "ID of the subnet where the AKS nodes will be deployed."
  type        = string
}

variable "dns_service_ip" {
  description = "The IP address for the Kubernetes DNS service"
  default     = "10.240.0.10"
}

variable "docker_bridge_cidr" {
  description = "The CIDR for the Docker bridge network"
  default     = "172.17.0.1/16"
}

variable "service_cidr" {
  description = "The IP range for Kubernetes services"
  default     = "10.240.0.0/16"
}

variable "node_pools" {
  description = "Map of node pools to create"
  type = map(object({
    environment         = string
    vm_size             = string
    node_count          = number
    os_disk_size_gb     = number
    max_pods            = number
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
    tags                = map(string)
    kubelet_config      = object({
      cpu_manager_policy     = string
      cpu_cfs_quota          = bool
      image_gc_high_threshold = number
      image_gc_low_threshold  = number
      topology_manager_policy = string
      pod_max_pids            = number
      allowed_unsafe_sysctls  = list(string)
    })
  }))
}

variable "tags" {
  description = "A map of tags to add to the AKS cluster"
  type        = map(string)
  default     = {}  
  
}

variable "user_assigned_identity_id" {
  description = "The name of the user assigned identity"
  type        = string
} 

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the AKS cluster"
  default     = "1.19.3"
}