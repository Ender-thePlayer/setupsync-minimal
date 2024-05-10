#!/usr/bin/env bash

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git
sudo pacman -S --needed --noconfirm base-devel
sudo pacman -S --noconfirm reflector
sudo reflector --country Romania --latest 5 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syu --noconfirm

git clone https://aur.archlinux.org/paru.git
cd paru || exit 1
makepkg -si --noconfirm
cd ..
rm -rf ./paru
