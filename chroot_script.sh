#tar -I pbzip2 -xpf Stage4_20200315.tar.bz2 --xattrs-include='*.*' --numeric-owner
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev 
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"
mount /dev/nvme0n1p1 /boot
