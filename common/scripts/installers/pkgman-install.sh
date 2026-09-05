#!/usr/bin/env bash


### PACMAN AND AUR
pacman=(
#Compositor
"hypridle"
"hyprlock"
"awww"
"hyprpicker"
"xdg-desktop-portal"
"xdg-desktop-portal-hyprland"
"xdg-desktop-portal-gtk"
"rofi"
"rofi-emoji"
"wl-clipboard"
"wev"
"cliphist"
"brightnessctl"
"gammastep"
"nwg-displays"
"nwg-look"
"polkit-gnome"
"hyprshot"

#Theming
"breeze5"
"breeze"
"papirus-icon-theme"
"gtk4"
"noto-fonts-cjk"
"ttf-jetbrains-mono-nerd"
"otf-latinmodern-math"

#Dev
"fish"
"starship"
"vim"
"less"
"expect"
"shellcheck"
"cmake"
"meson"
"nodejs"
"pnpm"
"uv"
"jdk21-openjdk"
"python-pyqt5"
"python-pyqt6"
"python-mutagen"
"python-cryptography"
"python-pycryptodome"
"python-pyfuse3"
"python-requests"
"python-psutil"
"python-pypresence"
"gst-plugins-base"
"gst-plugins-good"
"gst-plugins-bad"
"gst-plugins-ugly"
"gst-libav"

#Sysutils
"util-linux"
"lm_sensors"
"strace"
"fastfetch"
"pfetch-rs"
"xdg-user-dirs"
"7zip"
"jq"
"bc"
"ntfs-3g"
"exfatprogs"
"gvfs-mtp"
"gnome-disk-utility"
"borg"
"rsync"
"android-tools"
"bluez"
"bluez-utils"
"kdeconnect"
"gnome-keyring"
"seahorse"
"sbctl"
"fcitx5-mozc"
"fcitx5-configtool"
"playerctl"
"wtype"
"zenity"

#Apps
"vlc"
"vlc-plugins-all"
"mpv"
"aegisub"
"krita"
"kdenlive"
"loupe"
"steam"
"wine"
"gamescope"
"mangohud"
"lib32-mangohud"
"gnome-text-editor"
"flatpak"
"qbittorrent"
"nicotine+"
"wf-recorder"
"mullvad-vpn"
)

aur=(
#Compositor
"wayle-bin"

#Theming
"qt5ct-kde"
"qt6ct-kde"

#Apps
"vscodium-bin"
"vesktop-bin"
"ani-cli"

#Sysutils
"downgrade"
"mpris-scrobbler"
"nautilus-open-any-terminal"
"opentabletdriver"
)

for pkg in "${pacman[@]}"; do
    sudo pacman -S --needed --noconfirm "$pkg"
done

for pkg in "${aur[@]}"; do
    paru -S --noconfirm "$pkg"
done


### INSTALLS SOME CUSTOM PKGBUILDS
if test -d "./common/shared/customapps"; then
    mkdir ./tmp

    cp ./common/shared/customapps/prismlauncher-cracked-git/PKGBUILD ./tmp
    cd ./tmp || exit 1
    makepkg -s --noconfirm
    sudo pacman -U --noconfirm prismlauncher-cracked-git-*.tar.zst
    cd ..

    cp ./common/shared/customapps/upscaler-hollowaykeanho/PKGBUILD ./tmp
    cd ./tmp || exit 1
    makepkg -s --noconfirm
    sudo pacman -U --noconfirm upscaler-hollowaykeanho-*.tar.zst
    cd ..

    rm -rf ./tmp
fi


### ENABLES SOME SERVICES
sudo udevadm control --reload
sudo systemctl enable --now bluetooth
systemctl --user enable --now opentabletdriver.service
systemctl --user enable --now hypridle.service
sudo systemctl enable --now mullvad-early-boot-blocking.service
sudo systemctl enable --now mullvad-daemon.service
