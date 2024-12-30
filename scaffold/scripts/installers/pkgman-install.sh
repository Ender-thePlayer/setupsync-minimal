#!/usr/bin/env bash

pacman=(
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
"jre17-openjdk"
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
)

paru=(
"qt5ct-kde"
"qt6ct-kde"
"hyprshot"
"wlogout"
"wttrbar"
"librewolf-bin"
"vscodium-bin"
# "youtube-music-bin"
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
)


### PACMAN AND PARU (AUR)
for pkg in "${pacman[@]}"; do
    sudo pacman -S --noconfirm "$pkg"
done

for pkg in "${paru[@]}"; do
    paru -S --noconfirm "$pkg"
done


### INSTALLS SOME CUSTOM PKGBUILDS
if test -d "./scaffold/shared/customapps"; then
    mkdir ./tmp

    cp -r ./scaffold/shared/customapps/romode ./tmp
    cd ./tmp/romode || exit 1
    makepkg -s --noconfirm
    sudo pacman -U --noconfirm romode3-*.tar.zst
    cd ../..

    cp -r ./scaffold/shared/customapps/synthv ./tmp
    cd ./tmp/synthv || exit 1
    makepkg -s --noconfirm
    sudo pacman -U --noconfirm synthv-studio-crack-*.tar.zst
    cd ../..

    cp -r ./scaffold/shared/customapps/tuyu-cli ./tmp
    cd ./tmp/tuyu-cli || exit 1
    makepkg -s --noconfirm
    sudo pacman -U --noconfirm tuyu-cli-*.tar.zst
    cd ../..

    cp ./scaffold/shared/customapps/PKGBUILD ./tmp
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