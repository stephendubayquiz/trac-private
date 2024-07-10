subscription_id         = "6e1fe5ed-3359-43df-b4b1-946796a9eaea"
location_short          = "E1"
environment             = "PROD"
environments            = ["dev", "qa"]
applications            = ["ezbook", "imp", "tracconnect", "mos-tdp", "mos-udp", "mdms", "trac-gpt"]
deployments             = ["b", "g"]
base_name               = "devqa"
location                = "EastUS"
dns_prefix              = "tracintermodal"

aks_kubernetes_version    = "1.29.2"

tags = {
  environment = "Development"
  project     = "MOS"
  owner       = "John Doe"
}


node_pools = {
  0 = {
    environment = "dev"
    vm_size             = "Standard_DS2_v2"
    node_count          = 1
    os_disk_size_gb     = 30
    max_pods            = 110
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
    tags                = {
      environment = "production"
      cost_center = "12345"
    }
    kubelet_config = {
      cpu_manager_policy     = "static"
      cpu_cfs_quota          = true
      image_gc_high_threshold = 85
      image_gc_low_threshold  = 80
      topology_manager_policy = "best-effort"
      pod_max_pids            = 200
      allowed_unsafe_sysctls  = []
    }
  }
  1 = {
    environment = "qa"
    vm_size             = "Standard_DS3_v2"
    node_count          = 1
    os_disk_size_gb     = 50
    max_pods            = 110
    enable_auto_scaling = false
    min_count           = 1
    max_count           = 3
    tags                = {
      environment = "development"
      cost_center = "67890"
    }
    kubelet_config = {
      cpu_manager_policy     = "static"
      cpu_cfs_quota          = true
      image_gc_high_threshold = 85
      image_gc_low_threshold  = 80
      topology_manager_policy = "best-effort"
      pod_max_pids            = 200
      allowed_unsafe_sysctls  = []
    }
  }
}

  
    // Add more node pool configurations as needed
  
