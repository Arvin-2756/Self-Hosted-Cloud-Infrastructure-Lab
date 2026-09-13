# SSL and TLS

Nginx Proxy Manager is the certificate boundary. Create proxy hosts for the required DNS names, use DNS-01 validation when inbound HTTP validation is not possible, and enable automatic renewal through Let's Encrypt.

Cloudflare Tunnel should point to the reverse proxy rather than directly to application containers. Keep origin services private and use strict TLS validation where the deployment supports it.
