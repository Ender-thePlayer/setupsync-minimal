#!/usr/bin/env bash

## Installs node.js
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update -y
sudo apt install -y nodejs

## Installs VSCodium
sudo wget https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
-O /usr/share/keyrings/vscodium-archive-keyring.asc

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.asc ] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

sudo apt update -y

sudo apt install -y codium
sudo apt install -y neofetch
sudo apt install -y git p7zip-full python3-pip python3-wxgtk4.0 grub2-common grub-pc-bin parted dosfstools ntfs-3g
sudo apt install -y chrome-gnome-shell
sudo apt install -y dconf-editor
sudo apt install -y openjfx
sudo apt install -y default-jdk
sudo apt install -y gnome-tweaks
sudo apt install -y lm-sensors
sudo apt install -y curl
sudo apt install -y playonlinux
sudo apt install -y lutris
sudo apt install -y zsh
sudo apt install -y papirus-icon-theme
sudo apt install -y alacarte
sudo apt install -y kdeconnect
sudo apt install -y flatpak
sudo apt install -y mkvtoolnix
sudo apt install -y util-linux
sudo apt install -y rsync
sudo apt install -y ibus-mozc
sudo apt install -y fonts-dejavu
sudo apt install -y vim

# sudo apt install -y kde-spectacle
# sudo apt install -y kgx
# sudo apt install -y snapd
# sudo apt install -y grub-customizer
# sudo apt install -y input-remapper