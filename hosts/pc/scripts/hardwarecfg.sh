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


#FSTAB FUCKERY FOR THE 1TB HDD
echo -e "# 1tb\nUUID=344ce62e-a0af-4bfa-935c-5676e34f7f45  /run/media/eepyender/344ce62e-a0af-4bfa-935c-5676e34f7f45  ext4  defaults,nofail  0  2" | sudo tee -a /etc/fstab > /dev/null


### PACKAGES
pacman=(
"plymouth"
"intel-undervolt"
"radeontop"
"vulkan-radeon"
"linux-firmware"
"lib32-vulkan-radeon"
"libva-mesa-driver"
"libva-utils"
"libva"
"libva-vdpau-driver"
"libva-mesa-driver"
"mesa-vdpau"
"libva-utils"
"fwupd")

sudo pacman -Rns power-profiles-daemon --noconfirm
for pkg in "${pacman[@]}"; do
    sudo pacman -S --needed --noconfirm "$pkg"
done


### PLYMOUTH THEMING
# It installs a theme I made for plymouth
if test -d "./hosts/pc/shared/plymouth-theme-isat-ascii"; then
    sudo cp -r ./hosts/pc/shared/plymouth-theme-isat-ascii /usr/share/plymouth/themes/isat-ascii-art
    sudo plymouth-set-default-theme isat-ascii-art
fi


### POWER MANAGEMENT
# It undervolts the CPU by -100mV
if test -f "./hosts/pc/shared/intel-undervolt.conf"; then
    sudo cp ./hosts/pc/shared/intel-undervolt.conf /etc/intel-undervolt.conf
    sudo mkinitcpio -P
    sudo intel-undervolt apply
    sudo systemctl enable --now intel-undervolt.service
fi


### USB FUCKERY
sudo tee /etc/udev/rules.d/90-disable-usb-wakeup.rules > /dev/null <<EOF
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="249a", ATTRS{idProduct}=="5c2f", ATTR{power/wakeup}="disabled"
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="320f", ATTRS{idProduct}=="505b", ATTR{power/wakeup}="disabled"
EOF
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=usb --action=add