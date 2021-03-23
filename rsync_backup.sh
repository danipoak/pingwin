
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

sudo rsync -ahAXv "${EXCLUDES[@]}" --progress / /mnt/SLON/pingwin_backup/