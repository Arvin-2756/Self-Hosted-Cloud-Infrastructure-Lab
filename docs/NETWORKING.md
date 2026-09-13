# Networking

The default layout uses one Proxmox bridge and a dedicated static address per service:

| Service | Address | Role |
|---|---:|---|
| Forgejo | 192.168.1.201 | Git hosting |
| Nextcloud | 192.168.1.202 | File sync |
| Immich | 192.168.1.203 | Photo management |
| AdGuard Home | 192.168.1.204 | DNS |
| Nginx Proxy Manager | 192.168.1.205 | HTTP reverse proxy |

Change these values in `infrastructure/locals.tf` or with `service_overrides` before deployment. Do not expose container ports directly to the Internet. Use Tailscale ACLs for administrative access and Cloudflare Tunnel for carefully selected public hostnames.
