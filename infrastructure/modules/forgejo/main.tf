variable "container_ip" { type = string }
variable "domain" { type = string }

output "url" {
  value = "https://git.${var.domain}"
}

output "container_ip" {
  value = var.container_ip
}
