
#Directories to exclude:
EXCLUDES=(
    "--exclude=/dev/*"
    "--exclude=/var/tmp/*"
    "--exclude=/var/lock/*"
    "--exclude=/var/log/*"
    "--exclude=/var/run/*"
    "--exclude=/proc/*"
    "--exclude=/sys/*"
    "--exclude=/tmp/*"
    "--exclude=/run/*"
    "--exclude=/mnt/*"
    "--exclude=/media/*"
    "--exclude=/lost+found/*"
)

rsync -aqAXv --progress  --dry-run --log-file=/home/steve/rsync_backup.log / "${EXCLUDES[@]}" /run/media/steve/ZEBRA/pingwin_backup/