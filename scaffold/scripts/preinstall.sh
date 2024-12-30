#!/usr/bin/env bash

### PACMAN CONFIGS
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git reflector
sudo pacman -S --needed --noconfirm base-devel
sudo reflector --country Romania --latest 5 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syu --noconfirm


### PARU INSTALL
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin || exit 1
makepkg -s --noconfirm
sudo pacman -U --noconfirm paru-bin-*.tar.zst
cd ..
rm -rf ./paru-bin