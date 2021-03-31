#!/bin/bash
#rsync backup script
set -o errexit
set -o nounset
set -o pipefail

#Directories to exclude:
EXCLUDES=(
    "--exclude=/dev/"
    "--exclude=/var/tmp/"
    "--exclude=/var/lock/"
    "--exclude=/var/log/"
    "--exclude=/var/run/"
    "--exclude=/proc/"
    "--exclude=/sys/"
    "--exclude=/tmp/"
    "--exclude=/run/"
    "--exclude=/mnt/"
    "--exclude=/media/"
    "--exclude=/lost+found/"
)

readonly SOURCE="/"
readonly DESTINATION="/mnt/SLON/pingwin_backup"
readonly DATETIME="$(date '+%Y-%m-%d_%H:%M')"
readonly BACKUP_PATH="${DESTINATION}/${DATETIME}"
readonly LATEST_LINK="${DESTINATION}/latest"

mkdir -p "${DESTINATION}"

sudo rsync -ahAX --info=progress2 --delete \
    "${SOURCE}" \
    --link-dest "${LATEST_LINK}" \
    "${EXCLUDES}" \
    "${BACKUP_PATH}"

sudo rm -rf "${LATEST_LINK}"
ln -s "${BACKUP_PATH}" "${LATEST_LINK}"
