#!/usr/bin/env bash

pacman=(
"ntfs-3g"
"uwsm"
"xdg-user-dirs"
"waybar"
"hypridle"
"hyprlock"
"swww"
"rofi-wayland"
"wl-clipboard"
"gammastep"
"brightnessctl"
"pavucontrol"
"pamixer"
"blueberry"
"dunst"
"network-manager-applet"
"nwg-displays"
"noto-fonts-cjk"
"ttf-jetbrains-mono-nerd"
"gnome-keyring"
"gnome-disk-utility"
"papirus-icon-theme"
"gtk4"
"gaupol"
"xdg-desktop-portal-gtk"
"xdg-desktop-portal"
"polkit-gnome"
"gnome-text-editor"
"gnome-font-viewer"
"gvfs-mtp"
"ghex"
"plasma-framework5"
"breeze5"
"breeze-gtk"
"breeze"
"shellcheck"
"fish"
"starship"
"jre21-openjdk"
"uv"
"nodejs"
"pnpm"
"meson"
"vim"
"flatpak"
"yt-dlp"
"cliphist"
"wev"
"fastfetch"
"borg"
"rsync"
"expect"
"less"
"lm_sensors"
"util-linux"
"mkvtoolnix-cli"
"jq"
"loupe"
"kdeconnect"
"fcitx5-config-qt"
"android-tools"
"birdfont"
"vlc"
"mpv"
"krita"
"kdenlive"
"sox"
"qbittorrent"
"steam"
"gamescope"
"mangohud"
"lib32-mangohud"
"powerstat"
"nicotine+"
"qemu-full"
"virt-manager"
"libvirt"
"dnsmasq"
"spice-vdagent"
"vulkan-intel"
"intel-media-driver"
"linux-firmware"
"libva"
"sbctl"
"fwupd"
"exfat-utils"
"batsignal"
"fcitx5-mozc"
"hyprpicker"
"otf-latinmodern-math"
"rofi-emoji"
"7zip"
)

paru=(
"qt5ct-kde"
"qt6ct-kde"
"hyprshot"
"wlogout"
"wttrbar"
"vscodium-bin"
"spotify"
"spicetify-cli"
"spicetify-marketplace-bin"
"mpris-scrobbler"
"downgrade"
"sklauncher-bin"
"ventoy-bin"
"nautilus-open-any-terminal"
"ani-cli"
"pfetch-rs"
"wl-screenrec"
"vesktop-bin"
"adbfs-rootless-git"
"powerstat"
)


### PACMAN AND PARU (AUR)
for pkg in "${pacman[@]}"; do
    sudo pacman -S --needed --noconfirm "$pkg"
done

for pkg in "${paru[@]}"; do
    paru -S --noconfirm "$pkg"
done


### INSTALLS SOME CUSTOM PKGBUILDS
if test -d "./common/shared/customapps"; then
    mkdir ./tmp

    cp ./common/shared/customapps/PKGBUILD ./tmp
    cd ./tmp || exit 1
    makepkg -s --noconfirm
    sudo pacman -U --noconfirm upscaler-hollowaykeanho-*.tar.zst
    cd ../..

    rm -rf ./tmp
fi


### ENABLES SOME SERVICES
sudo udevadm control --reload
sudo systemctl enable --now libvirtd.service
sudo systemctl enable --now bluetooth
sudo virsh net-autostart default
