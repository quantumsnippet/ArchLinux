echo "ADDING USER AND GIVING SUDO PRIVILEGES"
useradd darshan
passwd darshan
usermod -aG wheel darshan
echo "SEARCH FOR THE LINE WHICH BEGINS WITH WHEEL AND UNCOMMENT IT"
sleep 10
EDITOR=vim visudo
echo "################################################################"

echo "INCLUDE [multilib] REPOSITORY AND ENABLE ParallelDownloads"
sed '/ParallelDownloads/s/^#//' -i /etc/pacman.conf
sleep 15
vim /etc/pacman.conf
echo "################################################################"

echo "UPDATING THE REPOSITORIES"
pacman -Syyu --noconfirm
echo "################################################################"

echo "INSTALLATION OF XORG, DESKTOP ENVIRONMENT AND LOGIN DISPLAY MANAGER"
pacman -S xorg --noconfirm
pacman -S mate mate-extra 
pacman -S lxdm --noconfirm
systemctl enable lxdm.service
echo "################################################################"

echo "INSTALLING MY REQUIRED PACKAGES"
pacman -S pacman-contrib p7zip unrar zip unzip gvfs gvfs-mtp youtube-dl vlc libreoffice-fresh firefox htop neofetch gdb geany bleachbit ranger git curl wget gvim qbittorrent xfce4-terminal keepassxc gimp rofi openssh
echo "################################################################"

echo "INSTALLING PACKAGES FOR PLAYING SOUND"
pacman -S pulseaudio pulseaudio-alsa pavucontrol alsa-utils alsa-plugins alsa-lib alsa-firmware gstreamer volumeicon --noconfirm
echo "################################################################"

echo "INSTALLING TLP"
pacman -S tlp x86_energy_perf_policy
systemctl enable tlp.service
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket
echo "################################################################"

echo "ENABLING OS-PROBER TO DETECT OTHER OPERATING SYSTEMS"
echo GRUB_DISABLE_OS_PROBER=false > /etc/default/grub
echo GRUB_DEFAULT=saved > /etc/default/grub
echo GRUB_SAVEDEFAULT=true > /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
echo "################################################################"

echo "CREATING PACMAN HOOKS TO CLEAN PACKAGE CACHE AND DEALING WITH PACNEW FILES"
sed '/HookDir/s/^#//' -i /etc/pacman.conf
mkdir /etc/pacman.d/hooks
cat > /etc/pacman.d/hooks/clean_package_cache.hook << EOF
[Trigger]
Operation = Upgrade
Operation = Install         
Operation = Remove                       
Type = Package
Target = *

[Action]
Description = CLEANING PACMAN CACHE...
When = PostTransaction
Exec = /usr/bin/paccache -r
EOF

cat > /etc/pacman.d/hooks/pacdiff.hook << EOF
[Trigger]
Operation = Install
Operation = Upgrade
Operation = Remove
Type = Package
Target = *

[Action]
Description = CHECKING FOR PACNEW FILES...
When = PostTransaction
Exec = /usr/bin/pacdiff
EOF
echo "################################################################"

echo "SETTING JOURNAL SIZE LIMIT"
sed '/SystemMaxUse/s/^#//' -i /etc/systemd/journald.conf
systemctl restart systemd-journald.service
echo "################################################################"

echo "WIFI CONNECTION"
pacman -S broadcom-wl-dkms network-manager-applet nm-connection-editor --noconfirm
rmmod b43 b43legacy bcm43xx bcma brcm80211 brcmfmac brcmsmac ssb tg3 wl
modprobe wl
depmod -a
echo "################################################################"

echo "REBOOT"
sleep 5
reboot
