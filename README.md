# Self-Hosted Cloud Infrastructure Lab

Production-inspired self-hosted infrastructure managed with OpenTofu on Proxmox VE.

## What this demonstrates

- Declarative infrastructure with reusable HCL modules
- Isolated LXC workloads for Forgejo, Nextcloud, Immich, AdGuard Home, and Nginx Proxy Manager
- ZFS-backed storage and snapshot-oriented recovery
- Secure remote access through Tailscale and Cloudflare Tunnel
- Operational scripts, health checks, and monitoring configuration

## Architecture

```text
Internet
  |-- Cloudflare Tunnel (optional public HTTPS)
  |-- Tailscale (private remote access)
        |
   Proxmox VE host
        |-- LXC: Forgejo
        |-- LXC: Nextcloud
        |-- LXC: Immich
        |-- LXC: AdGuard Home
        |-- LXC: Nginx Proxy Manager
        |-- ZFS storage and snapshots
```

## Prerequisites

- Proxmox VE 8.x
- OpenTofu 1.7+
- A Proxmox API token with least-privilege permissions
- An accessible Linux template on the Proxmox storage pool
- Tailscale and Cloudflare accounts when those integrations are enabled

## Quick start

```bash
cp infrastructure/terraform.tfvars.example infrastructure/terraform.tfvars
$EDITOR infrastructure/terraform.tfvars
./scripts/init.sh
./scripts/validate.sh
./scripts/deploy.sh
./scripts/health-check.sh
```

Review the plan before applying. `terraform.tfvars` is ignored by Git and must never contain credentials committed to the repository.

## Project layout

- `infrastructure/`: OpenTofu root module and reusable service modules
- `scripts/`: guarded operational commands
- `docs/`: setup, operations, networking, services, and recovery documentation
- `playbooks/`: optional Ansible configuration tasks
- `monitoring/`: Prometheus scrape and alerting configuration

## Design decisions

Each service is represented as data in `locals.tf` and instantiated through the reusable `lxc_container` module. Service-specific modules provide clear ownership boundaries for future cloud-init and application configuration. The default network design uses a private bridge and avoids exposing service ports directly to the Internet.

## Safety

`destroy.sh` requires an explicit confirmation phrase. Backups and production credentials are intentionally not included. Test changes in a non-production Proxmox pool first.

## License

MIT. See [LICENSE](LICENSE).
