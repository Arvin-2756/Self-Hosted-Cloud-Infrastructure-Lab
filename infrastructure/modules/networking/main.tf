variable "gateway" { type = string }
variable "cidr" { type = number }
variable "bridge" { type = string }

output "summary" {
  value = {
    bridge  = var.bridge
    gateway = var.gateway
    cidr    = var.cidr
  }
}
