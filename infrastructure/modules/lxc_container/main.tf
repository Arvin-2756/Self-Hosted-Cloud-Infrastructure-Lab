resource "proxmox_virtual_environment_container" "this" {
  node_name = var.node_name
  vm_id     = var.vm_id
  tags      = ["homelab", "managed", var.name]
  description = var.description

  initialization {
    hostname = var.name

    ip_config {
      ipv4 {
        address = "${var.ip_address}/${var.network_cidr}"
        gateway = var.network_gateway
      }
    }

    user_account {
      keys = [var.ssh_public_key]
    }
  }

  operating_system {
    template_file_id = var.template_file_id
    type             = "debian"
  }

  cpu {
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.memory_mb
  }

  disk {
    datastore_id = var.storage_pool
    size         = var.disk_gb
  }

  network_interface {
    name   = "eth0"
    bridge = var.network_bridge
  }
}
