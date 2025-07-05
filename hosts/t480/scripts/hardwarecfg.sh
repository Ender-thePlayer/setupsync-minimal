#!/usr/bin/env bash


### EFISTUB
# Makes an efi entry for linux-zen kernel
if command -v efibootmgr >> /dev/null; then
    UUID=$( lsblk -dno UUID /dev/nvme0n1p2 || exit 1)
    sudo efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "EFI Arch" --loader /vmlinuz-linux-zen --unicode "rd.luks.name=${UUID}=root root=/dev/mapper/root initrd=\\initramfs-linux-zen.img"
fi


### POWER MANAGEMENT
# Installs tlp for performance, battery life and makes each of my batteries
# to charge to 80% max to prevent battery degradation
if command -v tlp >> /dev/null; then
    sudo pacman -S tlp --noconfirm
    sudo pacman -S tlp-rdw --noconfirm
    sudo pacman -S smartmontools --noconfirm
    sudo sed -i 's/#DEVICES_TO_DISABLE_ON_STARTUP="bluetooth nfc wifi wwan"/DEVICES_TO_DISABLE_ON_STARTUP="bluetooth"/g' /etc/tlp.conf
    sudo sed -i 's/#CPU_SCALING_GOVERNOR_ON_AC=powersave/CPU_SCALING_GOVERNOR_ON_AC=performance/g' /etc/tlp.conf
    sudo sed -i 's/#CPU_SCALING_GOVERNOR_ON_BAT=powersave/CPU_SCALING_GOVERNOR_ON_BAT=powersave/g' /etc/tlp.conf
    sudo sed -i 's/#START_CHARGE_THRESH_BAT0=75/START_CHARGE_THRESH_BAT0=75/g' /etc/tlp.conf
    sudo sed -i 's/#STOP_CHARGE_THRESH_BAT0=80/STOP_CHARGE_THRESH_BAT0=80/g' /etc/tlp.conf
    sudo sed -i 's/#START_CHARGE_THRESH_BAT1=75/START_CHARGE_THRESH_BAT1=75/g' /etc/tlp.conf
    sudo sed -i 's/#STOP_CHARGE_THRESH_BAT1=80/STOP_CHARGE_THRESH_BAT1=80/g' /etc/tlp.conf
    sudo systemctl enable tlp.service
    sudo systemctl mask power-profiles-daemon.service
    sudo systemctl mask systemd-rfkill.service
    sudo systemctl mask systemd-rfkill.socket
    sudo tlp start
fi


### THROTTLED
# Fixes random problems with throttling on my T480
sudo pacman -S throttled --noconfirm
if test -f "./hosts/t480/shared/throttled.conf"; then
    sudo rm /etc/throttled.conf
    sudo cp ./hosts/t480/shared/throttled.conf /etc/throttled.conf
fi
sudo systemctl enable throttled.service 


### THINKFAN
# Changes the fan curves to be more aggressive
paru -S --noconfirm thinkfan
if test -f "./hosts/t480/shared/thinkfan.conf"; then
    sudo cp ./hosts/t480/shared/thinkfan.conf /etc/thinkfan.conf
fi
sudo systemctl enable thinkfan.service


### TLP, AUDIO AND MOUSE STUFF
if test -f "./hosts/t480/shared/tlp-toggle.sh" && test -f "./hosts/t480/shared/tlp-toggle-helper.sh"; then
    sudo cp ./hosts/t480/shared/tlp-toggle.sh /opt/tlp-toggle.sh
    sudo cp ./hosts/t480/shared/tlp-toggle-helper.sh /opt/tlp-toggle-helper.sh
    sudo chmod +x /opt/tlp-toggle.sh
    sudo chmod +x /opt/tlp-toggle-helper.sh
    echo "$(whoami) ALL=(ALL) NOPASSWD: /opt/tlp-toggle-helper.sh" | sudo tee -a /etc/sudoers.d/tlp-toggle
fi

if test -f "./scaffold/shared/audio_switch.sh"; then
    sudo cp ./scaffold/shared/audio_switch.sh /opt/audio-switch.sh
    sudo chmod +x /opt/audio-switch.sh
    echo 'SUBSYSTEM=="drm", ACTION=="change", RUN+="/opt/audio-switch.sh"' | sudo tee /etc/udev/rules.d/99-hdmi-audio-switch.rules
fi

echo 'ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="249a", ATTRS{idProduct}=="5c2f", ATTR{../power/wakeup}="disabled"' | sudo tee /etc/udev/rules.d/90-disable-mouse.rules

sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=input --action=add
