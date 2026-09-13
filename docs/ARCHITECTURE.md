# Architecture

## Control plane

OpenTofu is the source of truth for container identity, resources, networking, and storage attachment. `locals.tf` defines the service catalog. The `lxc_container` module owns the common Proxmox container lifecycle.

## Data plane

Each workload receives an isolated LXC container with a static address on the private LAN. Nginx Proxy Manager terminates HTTPS and routes to internal services. AdGuard Home provides local DNS records and filtering.

## Access paths

- Local clients use the LAN bridge and AdGuard DNS.
- Administrators use Tailscale for private remote access.
- Optional public services use Cloudflare Tunnel and are still routed through the reverse proxy.

## Recovery boundary

ZFS snapshots provide fast local rollback. Compressed `zfs send` exports are stored under `backups/` and should be copied to an independent host or object storage. A snapshot is not a backup until it exists outside the failure domain.
