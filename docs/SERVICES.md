# Services

## Forgejo

Use for source control and internal automation repositories. Restrict registration, enforce SSH keys, and back up the repository data and database.

## Nextcloud

Use for documents and file synchronization. Place user data on a dedicated ZFS dataset and schedule application-aware backups.

## Immich

Use for photo ingestion and browsing. Treat the library as irreplaceable data and keep an off-host copy before enabling automatic phone uploads.

## AdGuard Home

Configure the LAN DHCP service to advertise the AdGuard address as DNS. Add local rewrites for the service hostnames and keep a secondary DNS plan for outages.

## Nginx Proxy Manager

Define one proxy host per service, restrict administrative access to Tailscale or the LAN, and issue certificates only for domains you control.
