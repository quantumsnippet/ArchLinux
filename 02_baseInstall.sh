echo "TIME ZONE"
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "################################################################"

echo "LOCALIZATION"
sed '/en_IN UTF-8/s/^#//' -i /etc/locale.gen
locale-gen
echo LANG=en_IN.UTF-8 > /etc/locale.conf
echo "################################################################"

echo "HOSTNAME"
echo arch > /etc/hostname
cat > /etc/hosts << EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   arch.localdomain	arch
EOF
echo "################################################################"

echo "NETWORK CONFIGURATION"
pacman -S networkmanager --noconfirm
systemctl enable NetworkManager
echo "################################################################"

echo "ROOT PASSWORD"
passwd
echo "################################################################"

echo "INSTALLATION OF GRUB BOOT LOADER"
pacman -S grub efibootmgr os-prober ntfs-3g --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
echo "################################################################"

echo "EXIT AND REBOOT NOW"
