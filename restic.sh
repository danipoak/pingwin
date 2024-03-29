#!/bin/bash
#restic backup script
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
    "--exclude=/.snapshots/"
    "--exclude=/home/steve/.local/share/steam"
    "--exclude=/home/steve/Games"
)

sudo restic -r /mnt/SLON/restic_repo backup "${EXCLUDES[@]}" / -p /home/steve/restic_pass.txt
sudo -E restic -r b2:pingwin-backup:/ forget \
                --keep-within-daily 7d \
                --keep-within-weekly 1m \
                --keep-within-monthly 1y \
                --keep-within-yearly 100y
sudo -E restic -r b2:pingwin-backup:/ prune
