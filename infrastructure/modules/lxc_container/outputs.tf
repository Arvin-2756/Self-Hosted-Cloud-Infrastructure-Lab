output "ip_address" {
  value = var.ip_address
}

output "vm_id" {
  value = proxmox_virtual_environment_container.this.vm_id
}

output "name" {
  value = var.name
}
