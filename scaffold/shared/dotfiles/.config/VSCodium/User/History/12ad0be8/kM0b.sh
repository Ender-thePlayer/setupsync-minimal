#!/usr/bin/env bash

### PACMAN INSRALLERS
sudo pacman -S --noconfirm kitty
sudo pacman -S --noconfirm xdg-user-dirs
sudo pacman -S --noconfirm waybar
sudo pacman -S --noconfirm hypridle
sudo pacman -S --noconfirm hyprlock
sudo pacman -S --noconfirm hyprpaper
sudo pacman -S --noconfirm rofi-wayland
sudo pacman -S --noconfirm wl-clipboard

sudo pacman -S --noconfirm gammastep
sudo pacman -S --noconfirm brightnessctl
sudo pacman -S --noconfirm pavucontrol
sudo pacman -S --noconfirm pamixer
sudo pacman -S --noconfirm blueberry
sudo pacman -S --noconfirm dunst
sudo pacman -S --noconfirm network-manager-applet
sudo pacman -S --noconfirm nwg-displays

sudo pacman -S --noconfirm noto-fonts-cjk
sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd
paru -S --noconfirm otf-latinmodern-math

sudo pacman -S --noconfirm gnome-keyring
sudo pacman -S --noconfirm gnome-tweaks 
sudo pacman -S --noconfirm papirus-icon-theme
sudo pacman -S --noconfirm gnome-disk-utility
sudo pacman -S --noconfirm gtk4
sudo pacman -S --noconfirm nautilus
sudo pacman -S --noconfirm gaupol
sudo pacman -S --noconfirm xdg-desktop-portal-gtk
sudo pacman -S --noconfirm xdg-desktop-portal
sudo pacman -S --noconfirm polkit-gnome
sudo pacman -S --noconfirm gnome-text-editor
sudo pacman -S --noconfirm gnome-font-viewer
sudo pacman -S --noconfirm gvfs-mtp
sudo pacman -S --noconfirm ghex
sudo udevadm control --reload

sudo pacman -S --noconfirm plasma-framework5
sudo pacman -S --noconfirm breeze5
sudo pacman -S --noconfirm breeze-gtk
sudo pacman -S --noconfirm kvantum-qt5
sudo pacman -S --noconfirm breeze

sudo pacman -S --noconfirm shellcheck
sudo pacman -S --noconfirm fish
sudo pacman -S --noconfirm starship

sudo pacman -S --noconfirm jre17-openjdk
sudo pacman -S --noconfirm python-pip
sudo pacman -S --noconfirm nodejs
sudo pacman -S --noconfirm pnpm
sudo pacman -S --noconfirm meson
sudo pacman -S --noconfirm vim
sudo pacman -S --noconfirm flatpak

sudo pacman -S --noconfirm cliphist
sudo pacman -S --noconfirm wev
sudo pacman -S --noconfirm fastfetch
sudo pacman -S --noconfirm borg
sudo pacman -S --noconfirm rsync
sudo pacman -S --noconfirm expect
sudo pacman -S --noconfirm less

sudo pacman -S --noconfirm dconf-editor 
sudo pacman -S --noconfirm lm_sensors
sudo pacman -S --noconfirm util-linux
sudo pacman -S --noconfirm mkvtoolnix-cli
sudo pacman -S --noconfirm jq
sudo pacman -S --noconfirm loupe
sudo pacman -S --noconfirm kdeconnect
sudo pacman -S --noconfirm fcitx5-config-qt
sudo pacman -S --noconfirm android-tools
sudo pacman -S --noconfirm birdfont
sudo pacman -S --noconfirm vlc
sudo pacman -S --noconfirm mpv
sudo pacman -S --noconfirm krita
sudo pacman -S --noconfirm kdenlive
sudo pacman -S --noconfirm sox
sudo pacman -S --noconfirm qbittorrent
sudo pacman -S --noconfirm steam
sudo pacman -S --noconfirm powerstat
sudo pacman -S --noconfirm nicotine+

sudo pacman -S --noconfirm qemu
sudo pacman -S --noconfirm qemu-full
sudo pacman -S --noconfirm virt-manager
sudo pacman -S --noconfirm libvirt
sudo pacman -S --noconfirm dnsmasq
sudo pacman -S --noconfirm spice-vdagent

sudo pacman -S --noconfirm borg
sudo pacman -S --noconfirm rsync

sudo pacman -S --noconfirm vulkan-intel
sudo pacman -S --noconfirm intel-media-driver
sudo pacman -S --noconfirm linux-firmware
sudo pacman -S --noconfirm libva
sudo pacman -S --noconfirm sbctl
sudo pacman -S --noconfirm fwupd
sudo pacman -S --noconfirm exfat-utils


### PARU INSTALLERS
paru -S --noconfirm qt5ct-kde     
paru -S --noconfirm qt6ct-kde
paru -S --noconfirm batsignal
paru -S --noconfirm fcitx5-mozc
paru -S --noconfirm hyprpicker
paru -S --noconfirm hyprshot
paru -S --noconfirm wlogout
paru -S --noconfirm wttrbar

paru -S --noconfirm librewolf-bin
paru -S --noconfirm vscodium-bin
paru -S --noconfirm youtube-music-bin
paru -S --noconfirm spotify
paru -S --noconfirm spicetify-cli
paru -S --noconfirm spicetify-marketplace-bin
paru -S --noconfirm mpris-scrobbler

paru -S --noconfirm downgrade
paru -S --noconfirm sklauncher-bin
paru -S --noconfirm ventoy-bin
paru -S --noconfirm nautilus-open-any-terminal
paru -S --noconfirm protontricks
paru -S --noconfirm ani-cli
paru -S --noconfirm pfetch-rs
paru -S --noconfirm wl-screenrec

# paru -S --noconfirm pod2man
# sudo pacman -S --noconfirm lutris
# sudo pacman -S --noconfirm bitwarden
# sudo pacman -S --noconfirm flatpak-builder



### INSTALLS 2 CUSTOM PKGBUILDS
mkdir ./tmp
cp -r ./scaffold/shared/customapps/romode ./tmp
cd ./tmp/romode || exit 1
makepkg -si --noconfirm
cd ../..
rm -rf ./tmp

mkdir ./tmp
cp -r ./scaffold/shared/customapps/synthv ./tmp
cd ./tmp/synthv || exit 1
makepkg -si --noconfirm
cd ../..
rm -rf ./tmp

mkdir ./tmp
cp -r ./scaffold/shared/customapps/tuyu-cli ./tmp
cd ./tmp/tuyu-cli || exit 1
makepkg -si --noconfirm
cd ../..
rm -rf ./tmp

### ENABLES SOME SERVICES
sudo systemctl enable --now libvirtd.service
sudo systemctl enable --now bluetooth

# sed -i "s|^prefs_path\s*=\s*.*|prefs_path=$HOME/.config/spicetify/config-xpui.ini|" "$HOME/.config/spicetify/config-xpui.ini"
# sudo chmod a+wr /opt/spotify
# sudo chmod a+wr /opt/spotify/Apps -R

# spicetify backup apply
# spicetify config custom_apps lyrics-plus
# spicetify config custom_apps marketplace
# spicetify apply
