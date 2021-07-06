echo "ADDING USER AND GIVING SUDO PRIVILEGES"
useradd darshan
passwd darshan
usermod -aG wheel darshan
echo "SEARCH FOR THE LINE WHICH BEGINS WITH WHEEL AND UNCOMMENT IT"
sleep 10
EDITOR=vim visudo
echo "################################################################"

echo "INCLUDE [multilib] REPOSITORY AND ENABLE ParallelDownloads"
echo "ParallelDownloads is case-sensitive"
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
pacman -S pacman-contrib p7zip unrar zip unzip gvfs gvfs-mtp youtube-dl vlc libreoffice-fresh firefox htop neofetch gdb geany bleachbit ranger git curl wget gvim vim-airline vim-airline-themes vim-syntastic qbittorrent xfce4-terminal keepassxc gimp arc-gtk-theme --noconfirm
echo "################################################################"

echo "INSTALLING PACKAGES FOR PLAYING SOUND"
pacman -S pulseaudio pulseaudio-alsa pavucontrol alsa-utils alsa-plugins alsa-lib alsa-firmware gstreamer volumeicon --noconfirm
echo "################################################################"

echo "WIFI CONNECTION"
pacman -S broadcom-wl-dkms network-manager-applet --noconfirm
rmmod b43 b43legacy bcm43xx bcma brcm80211 brcmfmac brcmsmac ssb wl
modprobe wl
echo "################################################################"

echo "REBOOT"
sleep 5
reboot
