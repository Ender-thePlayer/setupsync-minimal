#!/usr/bin/env bash

## Enables all the necessary repos
sudo tee -a /etc/yum.repos.d/vscodium.repo > /dev/null << 'EOF'
[gitlab.com_paulcarroty_vscodium_repo]
name=gitlab.com_paulcarroty_vscodium_repo
baseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
metadata_expire=1h
EOF

sudo dnf4 copr enable -y trixieua/mutter-patched
sudo dnf5 update -y && sudo dnf5 --refresh upgrade -y

sudo dnf5 install -y dconf-editor
sudo dnf5 install -y aegisub
sudo dnf5 install -y java
sudo dnf5 install -y gnome-tweaks
sudo dnf5 install -y lm_sensors
sudo dnf5 install -y ibus-mozc
sudo dnf5 install -y neofetch
sudo dnf5 install -y nodejs
sudo dnf5 install -y playonlinux
sudo dnf5 install -y kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras
sudo dnf5 install -y python3-pip
sudo dnf5 install -y alacarte
sudo dnf5 install -y --allowerasing ffmpeg
sudo dnf5 install -y papirus-icon-theme
sudo dnf5 install -y ffmpeg-libs
sudo dnf5 install -y kde-connect
sudo dnf5 install -y lutris
sudo dnf5 install -y gnome-tweaks
sudo dnf5 install -y vips
sudo dnf5 install -y flatpak-builder
sudo dnf5 install -y gtk4
sudo dnf5 install -y gtk4-devel
sudo dnf5 install -y zsh
sudo dnf5 install -y gnome-console
sudo dnf5 install -y nautilus-python
sudo dnf5 install -y ShellCheck
sudo dnf5 install -y util-linux-user
sudo dnf5 install -y mkvtoolnix
sudo dnf5 install -y qemu
sudo dnf5 install -y virt-manager
sudo dnf5 install -y codium
sudo dnf5 install -y pnpm
sudo dnf5 install -y kdenlive
sudo dnf5 install -y plasma-breeze
sudo dnf5 install -y htop
sudo dnf5 install -y borg


# sudo dnf5 install -y grub-customizer
# sudo dnf5 install -y input-remapper

# sudo systemctl enable --now input-remapper
# sudo systemctl start input-remapper
# systemctl reload --user dbus-broker.service
# sudo chsh -s "$(which zsh)"

## Removes the fallback font that is for japanese
# sudo rm -r /usr/share/fonts/google-droid-sans-fonts
