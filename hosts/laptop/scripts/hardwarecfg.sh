#!/usr/bin/env bash
systemd_initrd=true


### EFISTUB
# Makes an efi entry for linux-zen kernel
# Edits /etc/mkinitcpio.conf to make LUKS
# faster to decrypt
if command -v efibootmgr >> /dev/null 2>&1; then
    if $systemd_initrd; then
        sudo sed -i 's/MODULES=(btrfs)/MODULES=()/' /etc/mkinitcpio.conf
        sudo sed -i 's/BINARIES=(\/usr\/bin\/btrfs)/BINARIES=()/' /etc/mkinitcpio.conf
        sudo sed -i 's/HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt filesystems fsck)/HOOKS=(base systemd plymouth autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems fsck)/' /etc/mkinitcpio.conf

        UUID=$( lsblk -dno UUID /dev/nvme0n1p2 || exit 1)
        sudo efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "EFI Arch LTS" --loader /vmlinuz-linux-lts --unicode "rd.luks.name=${UUID}=root root=/dev/mapper/root zswap.enabled=0 rw quiet splash rootfstype=btrfs usbcore.autosuspend=-1 initrd=\\initramfs-linux-lts.img"
        sudo efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "EFI Arch" --loader /vmlinuz-linux-zen --unicode "rd.luks.name=${UUID}=root root=/dev/mapper/root zswap.enabled=0 rw quiet splash rootfstype=btrfs usbcore.autosuspend=-1 initrd=\\initramfs-linux-zen.img"

cat <<EOF | sudo tee /boot/loader/entries/*_linux-zen.conf
title   Arch Linux (linux-zen)
linux   /vmlinuz-linux-zen
initrd  /initramfs-linux-zen.img
options rd.luks.name=${UUID}=root root=/dev/mapper/root zswap.enabled=0 rw rootfstype=btrfs usbcore.autosuspend=-1
EOF

cat <<EOF | sudo tee /boot/loader/entries/*_linux-lts.conf
title   Arch Linux (linux-lts)
linux   /vmlinuz-linux-lts
initrd  /initramfs-linux-lts.img
options rd.luks.name=${UUID}=root root=/dev/mapper/root zswap.enabled=0 rw rootfstype=btrfs usbcore.autosuspend=-1
EOF

    else
        UUID=$( lsblk -dno PARTUUID /dev/nvme0n1p2 || exit 1)
        sudo efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "EFI Arch LTS" --loader /vmlinuz-linux-lts --unicode "cryptdevice=PARTUUID=${UUID}:root root=/dev/mapper/root zswap.enabled=0 rw rootfstype=btrfs initrd=\initramfs-linux-lts.img"
        sudo efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "EFI Arch" --loader /vmlinuz-linux-zen --unicode "cryptdevice=PARTUUID=${UUID}:root root=/dev/mapper/root zswap.enabled=0 rw rootfstype=btrfs initrd=\initramfs-linux-zen.img"
    fi
fi


### PACKAGES
pacman=(
"plymouth"
"intel-undervolt"
"intel-media-driver"
"vulkan-intel"
"linux-firmware"
"libva-mesa-driver"
"libva-utils"
"libva"
"libva-vdpau-driver"
"libva-mesa-driver"
"mesa-vdpau"
"libva-utils"
"fwupd"
"power-profiles-daemon")

for pkg in "${pacman[@]}"; do
    sudo pacman -S --needed --noconfirm "$pkg"
done
sudo systemctl enable --now power-profiles-daemon.service


## POWER MANAGEMENT
# Makes each of my batteries charge to 80% max to prevent battery degradation
cat << 'EOF' | sudo tee /etc/systemd/system/battery-charge-threshold.service
[Unit]
Description=Set the battery charge threshold
After=multi-user.target

[Service]
Type=oneshot
ExecStart=
ExecStart=/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold'
ExecStart=/bin/bash -c 'echo 75 > /sys/class/power_supply/BAT0/charge_control_start_threshold'
ExecStart=/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT1/charge_control_end_threshold'
ExecStart=/bin/bash -c 'echo 75 > /sys/class/power_supply/BAT1/charge_control_start_threshold'

[Install]
WantedBy=multi-user.target
EOF

sudo chmod 644 /etc/systemd/system/battery-charge-threshold.service
sudo systemctl enable --now battery-charge-threshold.service


### THROTTLED
# Fixes random problems with throttling on my T480
sudo pacman -S throttled --noconfirm
if test -f "./hosts/laptop/shared/throttled.conf"; then
    sudo rm /etc/throttled.conf
    sudo cp ./hosts/laptop/shared/throttled.conf /etc/throttled.conf
fi
sudo systemctl enable --now throttled.service 


### THINKFAN
# Changes the fan curves to be more aggressive
paru -S --noconfirm thinkfan
if test -f "./hosts/laptop/shared/thinkfan.conf"; then
    sudo cp ./hosts/laptop/shared/thinkfan.conf /etc/thinkfan.conf
fi
sudo systemctl enable --now thinkfan.service


### USB FUCKERY
sudo tee /etc/udev/rules.d/90-disable-usb-wakeup.rules > /dev/null <<EOF
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="249a", ATTRS{idProduct}=="5c2f", ATTR{power/wakeup}="disabled"
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="320f", ATTRS{idProduct}=="505b", ATTR{power/wakeup}="disabled"
EOF
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=usb --action=add