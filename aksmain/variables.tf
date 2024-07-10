variable "subscription_id" {
  description = "The connectivity subscription"
}

variable "location_short" {
  description = "short abbv region"
}


variable "base_name" {
  description = "The base name for the resource group"
  type = string
  }

variable "environment" {
  description = "value of the environment (prod/non-prod)"
  type = string
}

variable "environments" {
  description = "List of environments"
  type        = list(string)
  default     = ["dev", "qa"]
}

variable "applications" {
  description = "List of applications"
  type        = list(string)
  default     = ["ezbook", "imp", "tracconnect", "mos-tdp", "mos-udp", "mdms", "trac-gpt"]
}

variable "deployment_suffixes" {
  description = "List of deployment suffixes"
  type        = list(string)
  default     = ["blue", "green"]
}

variable "deployments" {
  description = "List of deployment types"
  type        = list(string)
  default     = ["b", "g"]
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
}


variable "aks_kubernetes_version" {
  description = "The version of Kubernetes to use for the AKS cluster"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to the AKS cluster"
  type        = map(string)
  default     = {}
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



