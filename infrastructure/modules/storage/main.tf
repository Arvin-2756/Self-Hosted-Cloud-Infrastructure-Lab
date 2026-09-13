variable "node_name" { type = string }
variable "storage_pool" { type = string }

output "summary" {
  value = {
    node         = var.node_name
    storage_pool = var.storage_pool
    strategy     = "ZFS snapshots with off-host backup recommended"
  }
}
