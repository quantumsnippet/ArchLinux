echo """"""ADDING USER AND GIVING SUDO PRIVILEGES""""""
useradd darshan
passwd darshan
usermod -aG wheel darshan
sed '/wheel ALL=(ALL) ALL/s/^#//' -i /etc/sudoers
#EDITOR=vim visudo

su darshan
groups
sleep 5
sudo whoami
sleep 5
echo "-------------------------------------------------"


echo """"""INCLUDING MULTILIB REPOSITORY AND ENABLING PARALLEL DOWNLOADS""""""
sudo sed '/ParallelDownloads = 5/s/^#//' -i /etc/pacman.conf
echo """"""Uncomment the [multilib] repository line, its mirrorlist include line and save it""""""
sleep 10
sudo vim /etc/pacman.conf
echo "-------------------------------------------------"


echo """"""UPDATING THE REPOSITORIES""""""
sudo pacman -Syyu --noconfirm
echo "-------------------------------------------------"


echo """"""INSTALLATION OF XORG, DESKTOP ENVIRONMENT AND LOGIN DISPLAY MANAGER""""""
sudo pacman -S xorg --noconfirm
sudo pacman -S mate mate-extra --noconfirm
sudo pacman -S lxdm --noconfirm
sudo systemctl enable lxdm.service
echo "-------------------------------------------------"


echo """"""WIFI CONNECTION""""""
sudo pacman -S broadcom-wl-dkms network-manager-applet --noconfirm
sudo rmmod b43 b43legacy bcm43xx bcma brcm80211 brcmfmac brcmsmac ssb wl
sudo modprobe wl
echo "-------------------------------------------------"


echo """"""INSTALLING MY NECESSARY PACKAGES""""""
sudo pacman -S pacman-contrib p7zip unrar zip unzip gvfs gvfs-mtp youtube-dl vlc libreoffice-fresh firefox htop neofetch gdb geany bleachbit ranger git curl wget gvim vim-airline vim-airline-themes vim-syntastic qbittorrent xfce4-terminal keepassxc --noconfirm
echo "-------------------------------------------------"
 

echo """"""INSTALLING PACKAGES FOR PLAYING SOUND""""""
sudo pacman -S pulseaudio pulseaudio-alsa pavucontrol alsa-utils alsa-plugins alsa-lib alsa-firmware gstreamer volumeicon --noconfirm
echo "-------------------------------------------------"


echo """"""MAKING USE OF ALL CORES FOR COMPILING""""""
echo """"""Search for "MAKEFLAGS" and replace the "-j2" with "-j$(nproc)"
sudo vim /etc/makepkg.conf
echo "-------------------------------------------------"


echo """"""CLEANING PACMAN CACHE HOOK""""""
sudo mkdir /etc/pacman.d/hooks
sudo touch /etc/pacman.d/hooks/clean_package_cache.hook
cat > /etc/pacman.d/hooks/clean_package_cache.hook <<EOF
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
echo "-------------------------------------------------"


echo """"""CLEANING PACMAN CACHE HOOK""""""
sudo touch /etc/pacman.d/hooks/pacdiff.hook
cat > /etc/pacman.d/hooks/pacdiff.hook <<EOF

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
echo "-------------------------------------------------"


echo """"""SETTING JOURNAL SIZE LIMIT""""""
sudo sed '/SystemMaxUse/s/^#//' -i /etc/systemd/journald.conf
sudo systemctl restart systemd-journald.service
echo "-------------------------------------------------"


echo """"""REBOOT""""""
sleep 5
reboot
