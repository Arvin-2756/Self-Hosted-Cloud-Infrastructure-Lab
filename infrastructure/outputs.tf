output "service_addresses" {
  description = "Addresses for enabled homelab services."
  value = {
    for name, service in module.services : name => service.ip_address
  }
}

output "service_ids" {
  description = "Proxmox VM IDs for enabled LXC services."
  value = {
    for name, service in module.services : name => service.vm_id
  }
}

output "network_summary" {
  value = module.networking.summary
}
