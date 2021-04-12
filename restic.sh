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
)

restic -r /mnt/SLON/restic_repo backup "${EXCLUDES[@]}" / 