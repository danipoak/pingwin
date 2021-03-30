set -o errexit
set -o nounset
set -o pipefail

#Directories to include:
INCLUDES=(
    "--include=/"
)
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

readonly DESTINATION="/mnt/SLON/pingwin_backup"
readonly DATETIME="$(date '+%Y-%m-%d_%H:%M:S')"
readonly BACKUP_PATH="${DESTINATION}/${DATETIME}"
readonly LATEST_LINK="${DESTINATION}/latest"

mkdir -p "${DESTINATION}"

sudo rsync -ahAX "${EXCLUDES[@]}" --info=progress2 "${INCLUDES[@]}" /mnt/SLON/pingwin_backup/
