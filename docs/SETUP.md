# Setup

## 1. Prepare Proxmox

Create a dedicated API token for automation, download a Debian 12 LXC template, and verify the target datastore and bridge names. Grant only the permissions required to manage the project containers.

## 2. Configure locally

```bash
cp infrastructure/terraform.tfvars.example infrastructure/terraform.tfvars
$EDITOR infrastructure/terraform.tfvars
./scripts/ssh-key-setup.sh
```

Use the generated public key in `ssh_public_key`. Keep API tokens in the ignored tfvars file or, preferably, inject them with environment variables in your CI system.

## 3. Plan and deploy

```bash
./scripts/init.sh
./scripts/validate.sh
./scripts/deploy.sh
```

The deploy script creates a saved plan and applies that exact plan. Run it from a trusted network with access to the Proxmox API.

## 4. Verify

```bash
./scripts/health-check.sh
```

The first application setup is completed through each service's web interface after the containers are reachable.
