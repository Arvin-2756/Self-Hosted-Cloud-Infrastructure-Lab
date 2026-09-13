# Enterprise Homelab Infrastructure

A self-hosted virtualization and container orchestration platform built on Proxmox VE, managed entirely through Infrastructure-as-Code using OpenTofu. This homelab serves as a testbed for cloud engineering concepts, self-hosted services, and production-like infrastructure patterns.

**Duration:** March 2026 – Present  
**Status:** Active & Evolving

---

## 📋 Project Overview

This project demonstrates:
- **Virtualization & Container Management** with Proxmox VE
- **Infrastructure-as-Code (IaC)** using OpenTofu (Terraform-compatible)
- **Self-Hosted Services** (Git, Cloud Storage, Photo Management, DNS, Reverse Proxy)
- **Remote Access & Networking** with Tailscale and Cloudflare Tunnels
- **Security & SSL/TLS** management via Nginx Proxy Manager and Let's Encrypt

The homelab is designed to be **reproducible**, **scalable**, and **production-inspired**—enabling experimentation with cloud engineering patterns without expensive cloud infrastructure costs.

---

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│              Proxmox VE Host (Baremetal)                │
│           Ryzen 3200G | Integrated Vega GPU             │
├─────────────────────────────────────────────────────────┤
│                                                           │
│  ┌──────────────────────────────────────────────────┐   │
│  │        LXC Containers (OpenTofu-Managed)         │   │
│  ├──────────────────────────────────────────────────┤   │
│  │                                                   │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────┐  │   │
│  │  │   Forgejo   │  │  Nextcloud  │  │ Immich  │  │   │
│  │  │  (Git Repo) │  │ (Cloud Drive)│ │ (Photos)│  │   │
│  │  └─────────────┘  └─────────────┘  └─────────┘  │   │
│  │                                                   │   │
│  │  ┌──────────────┐  ┌──────────────────────────┐ │   │
│  │  │   AdGuard    │  │  Nginx Proxy Manager     │ │   │
│  │  │  (DNS/Pi-Hole)  │  (Reverse Proxy + SSL)  │ │   │
│  │  └──────────────┘  └──────────────────────────┘ │   │
│  │                                                   │   │
│  │  ┌──────────────────────────────────────────┐   │   │
│  │  │      Local AI/LLM Services (Optional)     │   │   │
│  │  └──────────────────────────────────────────┘   │   │
│  │                                                   │   │
│  └──────────────────────────────────────────────────┘   │
│                                                           │
│  ┌──────────────────────────────────────────────────┐   │
│  │         Storage Layer (ZFS)                       │   │
│  │  • Snapshots & Backups                            │   │
│  │  • Data Integrity & Redundancy                    │   │
│  └──────────────────────────────────────────────────┘   │
│                                                           │
└─────────────────────────────────────────────────────────┘
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
    ┌───────┐      ┌──────────────┐    ┌──────────┐
    │Tailscale│    │ Cloudflare   │    │  Local   │
    │ (VPN)   │    │   Tunnel     │    │ Network  │
    └───────┘      └──────────────┘    └──────────┘
        │                  │                  │
        └──────────────────┼──────────────────┘
                           │
                ┌──────────────────────┐
                │   Remote Access      │
                │  • Secure VPN        │
                │  • Public HTTPS      │
                │  • Local LAN Access  │
                └──────────────────────┘
```

---

## 🛠️ Core Tools & Technologies

### Virtualization & Infrastructure
| Tool | Version | Purpose |
|------|---------|---------|
| **Proxmox VE** | 8.x | Type-1 Hypervisor for VM & LXC management |
| **LXC Containers** | - | Lightweight containerization (used over VMs for efficiency) |
| **ZFS** | - | Advanced storage with snapshots, compression, redundancy |

### Infrastructure-as-Code (IaC)
| Tool | Purpose |
|------|---------|
| **OpenTofu** | Terraform-compatible IaC tool for declarative infrastructure management |
| **bpg/proxmox Provider** | Terraform provider for Proxmox API automation |
| **HCL** | Infrastructure definition language (locals, maps, objects, for_each, modules) |

### Self-Hosted Services
| Service | Container Type | Purpose |
|---------|----------------|---------|
| **Forgejo** | LXC | Self-hosted Git repository (GitHub alternative) |
| **Nextcloud** | LXC | Cloud storage & file sync (Dropbox alternative) |
| **Immich** | LXC | Photo management & gallery (Google Photos alternative) |
| **AdGuard Home** | LXC | DNS-level ad blocking & network monitoring |
| **Nginx Proxy Manager** | LXC | Reverse proxy with SSL/TLS automation |

### Networking & Security
| Tool | Purpose |
|------|---------|
| **Tailscale** | Secure mesh VPN for remote access |
| **Cloudflare Tunnel** | Public HTTPS access without port forwarding |
| **Let's Encrypt** | Automated SSL/TLS certificates |
| **Nginx Proxy Manager** | Centralized SSL management & routing |

### Monitoring & Automation
| Tool | Purpose |
|------|---------|
| **Proxmox Web UI** | Native cluster & resource monitoring |
| **OpenTofu State Management** | Infrastructure drift detection & management |

---

## 📁 Project Directory Structure

```
enterprise-homelab-infrastructure/
├── README.md                          # Main project documentation
├── ARCHITECTURE.md                    # Detailed architecture & design decisions
│
├── infrastructure/                    # OpenTofu IaC modules
│   ├── main.tf                        # Root module configuration
│   ├── variables.tf                   # Input variables (VM specs, counts, etc.)
│   ├── outputs.tf                     # Output values (IP addresses, URLs, etc.)
│   ├── terraform.tfvars               # Variable values (gitignored for secrets)
│   │
│   ├── modules/
│   │   ├── proxmox_provider/
│   │   │   └── main.tf                # Proxmox provider configuration
│   │   │
│   │   ├── lxc_container/             # Reusable LXC container module
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   │
│   │   ├── forgejo/                   # Forgejo (Git) service
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   └── cloud-init.yaml        # Initialization script
│   │   │
│   │   ├── nextcloud/                 # Nextcloud (Cloud storage) service
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   └── cloud-init.yaml
│   │   │
│   │   ├── immich/                    # Immich (Photo management) service
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   └── cloud-init.yaml
│   │   │
│   │   ├── adguard/                   # AdGuard (DNS/Ad-blocking) service
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   └── cloud-init.yaml
│   │   │
│   │   ├── nginx_proxy_manager/       # Nginx Proxy Manager (Reverse Proxy)
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   └── cloud-init.yaml
│   │   │
│   │   ├── networking/                # Virtual networking setup
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   │
│   │   └── storage/                   # ZFS storage & backup configuration
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   │
│   └── locals.tf                      # Local values (centralized config)
│
├── scripts/                           # Deployment & operational scripts
│   ├── init.sh                        # Initialize OpenTofu workspace
│   ├── deploy.sh                      # Plan & apply infrastructure
│   ├── destroy.sh                     # Teardown (careful!)
│   ├── backup.sh                      # ZFS snapshot & backup management
│   ├── health-check.sh                # Container & service health verification
│   └── ssh-key-setup.sh               # SSH key generation for containers
│
├── docs/                              # Comprehensive documentation
│   ├── SETUP.md                       # Initial setup instructions
│   ├── NETWORKING.md                  # Network architecture & Tailscale setup
│   ├── SSL_TLS.md                     # SSL/TLS certificates & Let's Encrypt config
│   ├── SERVICES.md                    # Individual service configurations
│   ├── BACKUP_RESTORE.md              # Backup & disaster recovery procedures
│   ├── TROUBLESHOOTING.md             # Common issues & solutions
│   └── COST_ANALYSIS.md               # Power consumption & infrastructure costs
│
├── playbooks/                         # Ansible playbooks (optional automation)
│   ├── provision.yml
│   ├── configure-services.yml
│   └── health-check.yml
│
├── monitoring/                        # Monitoring & alerting configs
│   ├── prometheus.yml                 # Prometheus configuration
│   ├── grafana-dashboards/            # Grafana JSON dashboards
│   └── alerting-rules.yml             # Alert definitions
│
├── backups/                           # Backup location
│   ├── zfs-snapshots/
│   ├── container-backups/
│   └── data-exports/
│
├── .gitignore                         # Git ignore rules
├── .terraformignore                   # Terraform ignore rules
├── LICENSE                            # Project license (MIT)
└── CONTRIBUTING.md                    # Contribution guidelines

```

---

## 🔑 Key Features

### 1. **Infrastructure-as-Code (IaC) with OpenTofu**
- Fully declarative infrastructure definitions using HCL
- Module-based architecture for reusability and maintainability
- State management for drift detection
- Variables & locals for centralized configuration
- SSH key generation and management

**Example Structure:**
```hcl
locals {
  containers = {
    forgejo = {
      memory = 2048
      cores  = 2
      storage = 50
    }
    nextcloud = {
      memory = 4096
      cores  = 4
      storage = 200
    }
  }
}

resource "proxmox_lxc" "services" {
  for_each = local.containers
  # Configuration...
}
```

### 2. **Modular Container Design**
- Each service in its own LXC container
- Reusable `lxc_container` module
- Easy scaling and service isolation
- Cloud-init for automated provisioning

### 3. **Networking & Remote Access**
- **Tailscale VPN**: Secure mesh VPN for remote access
- **Cloudflare Tunnel**: Public HTTPS without port forwarding
- **Internal DNS**: AdGuard for local network DNS resolution
- **Reverse Proxy**: Nginx Proxy Manager for SSL termination & routing

### 4. **Storage & Data Management**
- **ZFS Storage**: Advanced filesystem with snapshots & compression
- **Automated Backups**: ZFS snapshots for disaster recovery
- **Data Integrity**: Built-in checksums & redundancy

### 5. **Security**
- SSH key authentication (no passwords)
- SSL/TLS certificates via Let's Encrypt
- Network isolation via virtual networking
- Secure remote access (Tailscale + Cloudflare Tunnel)

### 6. **Production-Like Patterns**
- Environment separation (dev, staging, prod)
- Disaster recovery & backup procedures
- Health checks & monitoring
- Scalable & repeatable deployments

---

## 📊 Resource Allocation

| Service | Memory | CPU Cores | Storage |
|---------|--------|-----------|---------|
| Forgejo | 2 GB | 2 | 50 GB |
| Nextcloud | 4 GB | 4 | 200 GB |
| Immich | 3 GB | 2 | 150 GB |
| AdGuard | 1 GB | 1 | 20 GB |
| Nginx Proxy Mgr | 1 GB | 1 | 10 GB |
| **Total** | **11 GB** | **10** | **430 GB** |

*Note: Optimized for Ryzen 3200G with integrated Vega graphics*

---

## 🚀 Quick Start

### Prerequisites
- Proxmox VE 8.x installed on bare metal
- OpenTofu installed locally
- SSH access to Proxmox host
- Tailscale account (for remote access)
- Cloudflare account (optional, for public HTTPS)

### Initial Setup
```bash
# Clone the repository
git clone https://github.com/yourusername/enterprise-homelab-infrastructure.git
cd enterprise-homelab-infrastructure

# Initialize OpenTofu
./scripts/init.sh

# Review the infrastructure plan
tofu plan

# Deploy infrastructure
./scripts/deploy.sh

# Verify health of deployed containers
./scripts/health-check.sh
```

For detailed setup instructions, see [docs/SETUP.md](docs/SETUP.md)

---

## 📚 Documentation Files

| File | Content |
|------|---------|
| **README.md** | Project overview & quick start |
| **ARCHITECTURE.md** | Detailed design decisions & rationale |
| **SETUP.md** | Step-by-step initial setup guide |
| **NETWORKING.md** | Network configuration & remote access |
| **SSL_TLS.md** | Certificate management & HTTPS setup |
| **SERVICES.md** | Individual service documentation |
| **BACKUP_RESTORE.md** | Backup procedures & DR |
| **TROUBLESHOOTING.md** | Common issues & solutions |

---

## 🎓 Learning Outcomes

This project demonstrates mastery in:
- ✅ Virtualization & containerization (Proxmox, LXC)
- ✅ Infrastructure-as-Code (OpenTofu, HCL, Terraform patterns)
- ✅ Network design & remote access (Tailscale, Cloudflare, DNS)
- ✅ Security best practices (SSH, SSL/TLS, network isolation)
- ✅ Storage management (ZFS, snapshots, backups)
- ✅ Self-hosted services (Git, cloud storage, photo management)
- ✅ Production-inspired DevOps patterns
- ✅ Automation & scripting (Bash, cloud-init)

---

## 📈 Future Enhancements

- [ ] Kubernetes cluster (k3s) for container orchestration
- [ ] Prometheus + Grafana stack for monitoring
- [ ] Ansible playbooks for service configuration management
- [ ] Database replication & clustering (PostgreSQL)
- [ ] Load balancing & high availability
- [ ] CI/CD pipeline integration (Forgejo Actions)
- [ ] Cost optimization analysis & reporting
- [ ] Multi-node clustering for redundancy

---

## 📝 License

This project is licensed under the MIT License – see [LICENSE](LICENSE) for details.

---

## 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## 📧 Contact

**Aravind S**  
AWS Certified Cloud Practitioner  
Cloud Infrastructure | DevOps | Infrastructure-as-Code  

📱 +91 8248119695  
📧 aravinddev56@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/aravind-s) | [GitHub](https://github.com/Arvin-2756)

---

**Last Updated:** September 2026  
**Status:** Active Development

