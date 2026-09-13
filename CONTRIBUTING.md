# Contributing

## Workflow

1. Create a focused branch from `main`.
2. Describe the infrastructure change and its rollback plan.
3. Run `./scripts/validate.sh` before opening a pull request.
4. Include the OpenTofu plan summary for changes affecting resources.
5. Never commit credentials, state files, private keys, or personal data.

## Standards

- Keep modules small and reusable.
- Prefer variables and locals over duplicated resource blocks.
- Use least-privilege Proxmox permissions.
- Document operational impact and recovery steps.
- Use conventional commit messages where possible.
