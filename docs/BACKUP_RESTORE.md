# Backup and Restore

## Backup

```bash
ZFS_DATASET=rpool/data BACKUP_ROOT=/srv/homelab-backups ./scripts/backup.sh
```

Copy resulting files to independent storage and periodically test decompression and restore. Record the snapshot name with the deployment change that created it.

## Restore outline

1. Stop writes to the affected service.
2. Restore the latest known-good application backup.
3. Roll back or recreate the LXC from OpenTofu if the container is damaged.
4. Restore application data and verify permissions.
5. Run `./scripts/health-check.sh` and validate user-facing workflows.
