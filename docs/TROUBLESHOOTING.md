# Troubleshooting

## OpenTofu cannot reach Proxmox

Check DNS, the API endpoint, token permissions, and TLS settings. Use `proxmox_insecure = true` only for a trusted lab endpoint with a certificate problem you understand.

## Container has no network

Confirm the bridge exists, the static address is unused, the gateway is reachable, and the template has a working network configuration.

## Health check fails

Run the check from a host that can reach the private addresses. Then inspect the service logs inside the container and verify that the expected application port has not changed.

## Restore does not boot

Confirm that the template, storage pool, and container configuration match the OpenTofu state. Restore application data separately from the container lifecycle.
