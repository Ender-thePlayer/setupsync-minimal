#!/usr/bin/env bash


### EFISTUB
# Makes an efi entry for linux-zen kernel
if command -v efibootmgr >> /dev/null; then
    UUID=$( lsblk -dno UUID /dev/nvme0n1p2 || exit 1)
    sudo efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "EFI Arch" --loader /vmlinuz-linux-zen --unicode "rd.luks.name=${UUID}=root root=/dev/mapper/root initrd=\\initramfs-linux-zen.img"
fi



## POWER MANAGEMENT
# Installs tlp for performance.

sudo pacman -Rns power-profiles-daemon --noconfirm
sudo pacman -S tlp --noconfirm
sudo pacman -S tlp-rdw --noconfirm
sudo pacman -S smartmontools --noconfirm

if command -v tlp >> /dev/null; then
    sudo sed -i 's/#DEVICES_TO_DISABLE_ON_STARTUP="bluetooth nfc wifi wwan"/DEVICES_TO_DISABLE_ON_STARTUP="bluetooth"/g' /etc/tlp.conf
    sudo sed -i 's/#CPU_SCALING_GOVERNOR_ON_AC=powersave/CPU_SCALING_GOVERNOR_ON_AC=performance/g' /etc/tlp.conf
    sudo sed -i 's/#CPU_SCALING_GOVERNOR_ON_BAT=powersave/CPU_SCALING_GOVERNOR_ON_BAT=powersave/g' /etc/tlp.conf
    sudo sed -i 's/#CPU_BOOST_ON_AC=1/CPU_BOOST_ON_AC=1/g' /etc/tlp.conf
    sudo sed -i 's/#PLATFORM_PROFILE_ON_AC=performance/PLATFORM_PROFILE_ON_AC=performance/g' /etc/tlp.conf

    sudo systemctl enable tlp.service
    sudo systemctl mask power-profiles-daemon.service
    sudo systemctl mask systemd-rfkill.service
    sudo systemctl mask systemd-rfkill.socket
    sudo tlp start
fi

# if test -f "./scaffold/shared/audio_switch.sh"; then
#     sudo cp ./scaffold/shared/audio_switch.sh /opt/audio-switch.sh
#     sudo chmod +x /opt/audio-switch.sh
#     echo 'SUBSYSTEM=="drm", ACTION=="change", RUN+="/opt/audio-switch.sh"' | sudo tee /etc/udev/rules.d/99-hdmi-audio-switch.rules
# fi

echo 'ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="249a", ATTRS{idProduct}=="5c2f", ATTR{../power/wakeup}="disabled"' | sudo tee /etc/udev/rules.d/90-disable-mouse.rules

sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=input --action=add
