#!/bin/bash
# openSUSE btrfs style subvolumes

set -o errexit
set -o nounset
set -o pipefail



# create the subvolumes
btrfs subvolume create /mnt/gentoo/@
btrfs subvolume create /mnt/gentoo/@/.snapshots
mkdir -p /mnt/gentoo/@/.snapshots/1
btrfs subvolume create /mnt/gentoo/@/.snapshots/1/snapshot
mkdir -p /mnt/gentoo/@/boot/grub/
btrfs subvolume create /mnt/gentoo/@/boot/grub/x86_64-efi
btrfs subvolume create /mnt/gentoo/@/home
btrfs subvolume create /mnt/gentoo/@/home/SIOSTRA
btrfs subvolume create /mnt/gentoo/@/opt
btrfs subvolume create /mnt/gentoo/@/root
btrfs subvolume create /mnt/gentoo/@/srv
btrfs subvolume create /mnt/gentoo/@/tmp
mkdir -p /mnt/gentoo/@/usr/
btrfs subvolume create /mnt/gentoo/@/usr/local
btrfs subvolume create /mnt/gentoo/@/var
btrfs subvolume create /mnt/gentoo/@/mnt
btrfs subvolume create /mnt/gentoo/@/media

# disable copy on write for var to improve performance
chattr +C /mnt/gentoo/@/var

# Create /mnt/gentoo/@/.snapshots/1/info.xml file 
# for snapper’s configuration. Include the following 
# content, replacing $DATE with the current system date/time.da1
DATE=$(date +"%D %T")
cat > /mnt/gentoo/@/.snapshots/1/info.xml <<EOF
<snapshot>
  <type>single</type>
  <num>1</num>
  <date>$DATE</date>
  <description>first root filesystem</description>
</snapshot>
EOF

# set snapshot 1 as the default, unmount, remount
btrfs subvolume set-default $(btrfs subvolume list /mnt/gentoo | grep "@/.snapshots/1/snapshot" | grep -oP '(?<=ID )[0-9]+') /mnt/gentoo
umount /mnt/gentoo
mount /dev/nvme0n1p2 /mnt/gentoo

# create the skeleton filesystem to mount the subvolumes
mkdir -p /mnt/gentoo/.snapshots
mkdir -p /mnt/gentoo/boot/grub/x86_64-efi
mkdir -p /mnt/gentoo/home
mkdir -p /mnt/gentoo/home/SIOSTRA
mkdir -p /mnt/gentoo/opt
mkdir -p /mnt/gentoo/root
mkdir -p /mnt/gentoo/srv
mkdir -p /mnt/gentoo/tmp
mkdir -p /mnt/gentoo/usr/local
mkdir -p /mnt/gentoo/var
mkdir -p /mnt/gentoo/mnt
mkdir -p /mnt/gentoo/media

# mount all subvolumes
mount /dev/nvme0n1p2 /mnt/gentoo/.snapshots -o subvol=@/.snapshots
mount /dev/nvme0n1p2 /mnt/gentoo/boot/grub/x86_64-efi -o subvol=@/boot/grub/x86_64-efi
mount /dev/nvme0n1p2 /mnt/gentoo/home -o subvol=@/home
mount /dev/nvme0n1p2 /mnt/gentoo/home/SIOSTRA -o subvol=@/home/SIOSTRA
mount /dev/nvme0n1p2 /mnt/gentoo/opt -o subvol=@/opt
mount /dev/nvme0n1p2 /mnt/gentoo/root -o subvol=@/root
mount /dev/nvme0n1p2 /mnt/gentoo/srv -o subvol=@/srv
mount /dev/nvme0n1p2 /mnt/gentoo/tmp -o subvol=@/tmp
mount /dev/nvme0n1p2 /mnt/gentoo/usr/local -o subvol=@/usr/local
mount /dev/nvme0n1p2 /mnt/gentoo/var -o subvol=@/var
mount /dev/nvme0n1p2 /mnt/gentoo/mnt -o subvol=@/mnt
mount /dev/nvme0n1p2 /mnt/gentoo/media -o subvol=@/media