variable "proxmox_endpoint" {
  description = "Proxmox API endpoint, including the port and trailing slash."
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API token in user@realm!token format."
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Skip TLS certificate verification for a lab endpoint."
  type        = bool
  default     = false
}

variable "node_name" { type = string }
variable "template_file_id" { type = string }
variable "storage_pool" { type = string }
variable "network_bridge" { type = string }
variable "network_gateway" { type = string }
variable "network_cidr" { type = number }
variable "domain" { type = string }
variable "ssh_public_key" { type = string }

variable "service_overrides" {
  description = "Optional per-service overrides for IP, resources, and enablement."
  type = map(object({
    enabled      = optional(bool, true)
    ip_address   = optional(string)
    memory_mb    = optional(number)
    cpu_cores    = optional(number)
    disk_gb      = optional(number)
    description  = optional(string)
  }))
  default = {}
}
