#!/bin/bash

# A script to perform incremental backups using rsync
# This script should be placed at /backup/incr_backup.sh
set -o errexit
set -o nounset
set -o pipefail

readonly SOURCE_DIR="/"
readonly BACKUP_DIR="."
readonly DATETIME="$(date '+%Y%m%d%H%M%S')"
readonly BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
readonly LATEST_LINK="../latest"

mkdir -p "${BACKUP_DIR}"

rsync -aAHX --info=progress2 --no-i-r --delete \
  "${SOURCE_DIR}/" \
  --link-dest "${LATEST_LINK}" \
  --exclude={"/backup/*","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} \
  "${BACKUP_PATH}"

rm -rf "latest"
ln -s "${BACKUP_PATH}" "latest" 
