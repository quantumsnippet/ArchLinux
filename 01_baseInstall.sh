echo """"""CHECKING INTERNET CONNECTION""""""
ping -c 5 archlinux.org
echo "-------------------------------------------------"


echo """"""UPDATING SYSTEM CLOCK""""""
timedatectl set-ntp true
echo "-------------------------------------------------"


echo """"""CHECKING PARTITIONS AS OF NOW""""""
lsblk
echo "-------------------------------------------------"
sleep 10


echo """"""LAUNCHING PARTITION TOOL""""""
cfdisk
echo "-------------------------------------------------"


echo """"""CHECKING PARTITIONS AGAIN""""""
lsblk
echo "-------------------------------------------------"
sleep 10


echo """"""FORMATTING THE PARTITIONS""""""
echo """"""FORMATTING THE EFI PARTITION""""""
mkfs.fat -F32 /dev/sda2
echo "-------------------------------------------------"

echo """"""FORMATTING THE SWAP PARTITION AND ACTIVATING IT""""""
mkswap /dev/sda1
swapon /dev/sda1
echo "-------------------------------------------------"

echo """"""FORMATTING THE ROOT PARTITION""""""
mkfs.ext4 /dev/sda3
echo "-------------------------------------------------"


echo """"""MOUNTING THE FILE SYSTEMS""""""
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda2 /mnt/boot
echo "-------------------------------------------------"


echo """"""INSTALLING ESSENTIAL PACKAGES USING PACSTRAP""""""
pacstrap /mnt base base-devel linux-lts linux-lts-headers linux-firmware nano vim bash-completion
echo "-------------------------------------------------"


echo """"""FSTAB""""""
genfstab -U /mnt >> /mnt/etc/fstab
echo "-------------------------------------------------"


echo """"""CHROOT""""""
arch-chroot /mnt
