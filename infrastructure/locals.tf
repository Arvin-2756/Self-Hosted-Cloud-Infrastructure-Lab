locals {
  services = {
    forgejo = {
      vm_id       = 201
      ip_address  = "192.168.1.201"
      memory_mb   = 2048
      cpu_cores   = 2
      disk_gb     = 50
      description = "Self-hosted Git service"
    }
    nextcloud = {
      vm_id       = 202
      ip_address  = "192.168.1.202"
      memory_mb   = 4096
      cpu_cores   = 4
      disk_gb     = 200
      description = "Private cloud storage and sync"
    }
    immich = {
      vm_id       = 203
      ip_address  = "192.168.1.203"
      memory_mb   = 3072
      cpu_cores   = 2
      disk_gb     = 150
      description = "Photo management platform"
    }
    adguard = {
      vm_id       = 204
      ip_address  = "192.168.1.204"
      memory_mb   = 1024
      cpu_cores   = 1
      disk_gb     = 20
      description = "DNS filtering and network visibility"
    }
    nginx_proxy_manager = {
      vm_id       = 205
      ip_address  = "192.168.1.205"
      memory_mb   = 1024
      cpu_cores   = 1
      disk_gb     = 10
      description = "Reverse proxy and certificate management"
    }
  }

  effective_services = {
    for name, defaults in local.services : name => merge(
      defaults,
      lookup(var.service_overrides, name, {}),
      { enabled = try(var.service_overrides[name].enabled, true) }
    )
  }

  enabled_services = {
    for name, config in local.effective_services : name => config
    if config.enabled
  }
}
