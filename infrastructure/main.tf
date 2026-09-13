module "services" {
  source   = "./modules/lxc_container"
  for_each = local.enabled_services

  name             = each.key
  vm_id            = each.value.vm_id
  node_name        = var.node_name
  template_file_id = var.template_file_id
  storage_pool     = var.storage_pool
  network_bridge   = var.network_bridge
  ip_address       = each.value.ip_address
  network_gateway  = var.network_gateway
  network_cidr     = var.network_cidr
  memory_mb        = each.value.memory_mb
  cpu_cores        = each.value.cpu_cores
  disk_gb          = each.value.disk_gb
  description      = each.value.description
  ssh_public_key   = var.ssh_public_key
}

module "storage" {
  source = "./modules/storage"

  node_name    = var.node_name
  storage_pool = var.storage_pool
}

module "networking" {
  source = "./modules/networking"

  gateway = var.network_gateway
  cidr    = var.network_cidr
  bridge  = var.network_bridge
}
