#!/usr/bin/env bash
set -euo pipefail

: "${ZFS_DATASET:=rpool/data}"
: "${BACKUP_ROOT:=./backups/zfs-snapshots}"
: "${SNAPSHOT_NAME:=homelab-$(date -u +%Y%m%dT%H%M%SZ)}"

zfs list "$ZFS_DATASET" >/dev/null
echo "Creating snapshot ${ZFS_DATASET}@${SNAPSHOT_NAME}"
sudo zfs snapshot "${ZFS_DATASET}@${SNAPSHOT_NAME}"
mkdir -p "$BACKUP_ROOT"
sudo zfs send "${ZFS_DATASET}@${SNAPSHOT_NAME}" | gzip > "${BACKUP_ROOT}/${SNAPSHOT_NAME}.zfs.gz"
echo "Backup written to ${BACKUP_ROOT}/${SNAPSHOT_NAME}.zfs.gz"
