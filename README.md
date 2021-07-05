# ArchLinux
My Arch Linux Installation Scripts for `UEFI` systems  

The bash scripts that I have written for installing Arch Linux (UEFI only) are heavily customised according to my preferences. So examine the scripts before using them.  

My Arch Linux setup is simple and it **doesn't** use LUKS/LVM/RAID disk encryption. `Ext4` filesystem is used for my root partition along with swap and EFI partition for boot. I prefer `MATE` as my Desktop Environment on my machines.  

There are three scripts that I have written for installing Arch Linux.  
<ol>
<li>First script does the installation procedure until arch-chrooting to /mnt.</li>  
<li>Second script will finish the base installation.</li>  
<li>And third script installs XORG, MATE DE and installs the packages that I use on my system regularly. I have also done some custom configurations in my third script.</li>  
</ol>

## PROCEDURE TO USE MY INSTALL SCRIPTS    
So, in the CLI environment use curl to get my scipts and give it the permission to make it an executable script.  

Script 1  
```bash
    curl -LJO https://raw.githubusercontent.com/quantumsnippet/ArchLinux/master/01_baseInstall.sh > 01_baseInstall.sh    
    sudo chmod +x 01_baseInstall.sh  
    ./01_baseInstall.sh  
```

Script 2  
```bash
    curl -LJO https://raw.githubusercontent.com/quantumsnippet/ArchLinux/master/02_baseInstall.sh > 02_baseInstall.sh    
    sudo chmod +x 02_baseInstall.sh  
    ./02_baseInstall.sh  
```

Script 3  
```bash
    curl -LJO https://raw.githubusercontent.com/quantumsnippet/ArchLinux/master/03_postBaseInstall.sh > 03_postBaseInstall.sh    
    sudo chmod +x 03_postBaseInstall.sh    
    ./03_postBaseInstall.sh   
```

## My Documentation  
My documentation for installing Arch Linux is in `archlinux_installation.txt` file. I have explained the procedure that goes into installing Arch Linux in that file. I highly recommend checking out the official [Arch Linux Installation Guide](https://wiki.archlinux.org/title/Installation_guide) and the [ArchWiki](https://wiki.archlinux.org/) as well before carrying out the installation process.  



