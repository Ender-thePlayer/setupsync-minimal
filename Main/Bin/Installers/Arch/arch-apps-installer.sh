#!/usr/bin/env bash

sudo pacman -S --noconfirm jq
sudo pacman -S --noconfirm dconf-editor 
sudo pacman -S --noconfirm jre17-openjdk
sudo pacman -S --noconfirm gnome-tweaks 
sudo pacman -S --noconfirm nodejs
sudo pacman -S --noconfirm lm_sensors 
sudo pacman -S --noconfirm python-pip
sudo pacman -S --noconfirm alacarte
sudo pacman -S --noconfirm alacarte
sudo pacman -S --noconfirm papirus-icon-theme
sudo pacman -S --noconfirm openssh
sudo pacman -S --noconfirm lutris
sudo pacman -S --noconfirm flatpak-builder
sudo pacman -S --noconfirm gtk4
sudo pacman -S --noconfirm python-nautilus
sudo pacman -S --noconfirm shellcheck
sudo pacman -S --noconfirm util-linux
sudo pacman -S --noconfirm mkvtoolnix-cli
sudo pacman -S --noconfirm qemu
sudo pacman -S --noconfirm qemu-full
sudo pacman -S --noconfirm virt-manager
sudo pacman -S --noconfirm pnpm
sudo pacman -S --noconfirm breeze
sudo pacman -S --noconfirm borg
sudo pacman -S --noconfirm loupe
sudo pacman -S --noconfirm breeze-gtk
sudo pacman -S --noconfirm kvantum-qt5
sudo pacman -S --noconfirm plasma-framework5
sudo pacman -S --noconfirm rsync
sudo pacman -S --noconfirm meson
sudo pacman -S --noconfirm fwupd
sudo pacman -S --noconfirm sshfs
sudo pacman -S --noconfirm vulkan-intel
sudo pacman -S --noconfirm intel-media-driver
sudo pacman -S --noconfirm linux-firmware
sudo pacman -S --noconfirm libva
sudo pacman -S --noconfirm breeze-gtk
sudo pacman -S --noconfirm libvirt
sudo pacman -S --noconfirm dnsmasq
sudo pacman -S --noconfirm vim-minimal
sudo pacman -S --noconfirm fish
sudo pacman -S --noconfirm meson
sudo pacman -S --noconfirm sbctl
# sudo pacman -S --noconfirm kdenlive

sudo systemctl start libvirtd.service
sudo systemctl enable libvirtd.service

paru -S vscodium-bin --noconfirm
paru -S mutter-dynamic-buffering --noconfirm
paru -S ibus-mozc --noconfirm
paru -S downgrade --noconfirm
paru -S sklauncher-bin --noconfirm
paru -S ventoy-bin --noconfirm
paru -S bunnyfetch --noconfirm