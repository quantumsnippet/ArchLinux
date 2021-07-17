echo "CHECKING INTERNET CONNECTION"
ping -c 5 archlinux.org
echo "################################################################"

echo "UPDATING THE SYSTEM CLOCK"
timedatectl set-ntp true
echo "################################################################"

echo "CHECKING PARTITIONS AS OF NOW"
lsblk
echo "################################################################"
sleep 15

echo "LAUNCHING PARTITION TOOL"
cfdisk
echo "################################################################"

echo "VERIFYING PARTITIONS AGAIN"
lsblk
echo "################################################################"
sleep 15

echo "FORMATTING THE EFI PARTITION"
mkfs.fat -F32 /dev/sda10
echo "################################################################"

echo "FORMATTING THE SWAP PARTITION AND ACTIVATING IT"
mkswap /dev/sda11
swapon /dev/sda11
echo "################################################################"

echo "FORMATTING THE ROOT PARTITION"
mkfs.ext4 /dev/sda12
echo "################################################################"

echo "MOUNTING THE FILE SYSTEMS"
mount /dev/sda12 /mnt
mkdir /mnt/boot
mount /dev/sda10 /mnt/boot
echo "################################################################"

echo "INSTALLING ESSENTIAL PACKAGES USING PACSTRAP"
pacstrap /mnt base base-devel linux-lts linux-lts-headers linux-firmware nano vim bash-completion intel-ucode
echo "################################################################"

echo "FSTAB"
genfstab -U /mnt >> /mnt/etc/fstab
echo "################################################################"

echo "ARCH CHROOT INTO THE NEW SYSTEM NOW i.e.arch-chroot /mnt"

