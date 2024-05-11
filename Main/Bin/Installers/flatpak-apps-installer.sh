#!/usr/bin/env bash

##  Adds the flathub repo to flatpak if it isn't already
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

## 'Cause birdfont isn't in the flathub repo, I need to do this.
wget https://birdfont.org/download/birdfont-6.2.1-x86-free.flatpak
sudo flatpak install -y ./*.flatpak
find  ./ -name '*.flatpak' -exec rm -r {} \;

flatpak install --user --from https://nightly.gnome.org/repo/appstream/org.gnome.Ptyxis.Devel.flatpakref

flatpak install --user -y flathub org.deluge_torrent.deluge
flatpak install --user -y flathub org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
flatpak install --user -y flathub com.spotify.Client
flatpak install --user -y flathub com.obsproject.Studio
flatpak install --user -y flathub org.kde.krita
flatpak install --user -y flathub org.zdoom.GZDoom
flatpak install --user -y flathub com.mattjakeman.ExtensionManager
flatpak install --user -y flathub com.github.tchx84.Flatseal
flatpak install --user -y flathub org.audacityteam.Audacity
flatpak install --user -y flathub org.videolan.VLC
flatpak install --user -y flathub com.github.wwmm.easyeffects
flatpak install --user -y flathub org.chromium.Chromium
flatpak install --user -y flathub com.github.micahflee.torbrowser-launcher
flatpak install --user -y flathub com.notesnook.Notesnook
flatpak install --user -y flathub com.belmoussaoui.Authenticator
flatpak install --user -y flathub dev.vencord.Vesktop
flatpak install --user -y flathub com.github.finefindus.eyedropper
flatpak install --user -y flathub com.valvesoftware.Steam
flatpak install --user -y flathub net.lutris.Lutris
flatpak install --user -y com.github.maoschanz.drawing
flatpak install --user -y org.gnome.World.PikaBackup
flatpak install --user -y flathub org.kde.kdenlive

if [ "$( distro )" = "arch" ]; then
    flatpak install --user -y flathub org.libreoffice.LibreOffice
fi


## Flatpak version of kdenlive looks broken on GNOME on wayland
# sudo flatpak mask org.kde.WaylandDecoration.QAdwaitaDecorations//5.15-22.08
# sudo flatpak remove org.kde.WaylandDecoration.QAdwaitaDecorations//5.15-22.08
# flatpak override --user --env=QT_QPA_PLATFORM=xcb org.kde.kdenlive

## Fixes RPC for the Discord flatpak
# mkdir -p ~/.config/user-tmpfiles.d
# echo 'L %t/discord-ipc-0 - - - - app/com.discordapp.Discord/discord-ipc-0' > ~/.config/user-tmpfiles.d/discord-rpc.conf
# systemctl --user enable --now systemd-tmpfiles-setup.service

## Not is use at the moment
# flatpak install --user -y flathub com.discordapp.Discord
# flatpak install --user -y flathub fr.handbrake.ghb
# flatpak install --user -y flathub io.lmms.LMMS
# flatpak install --user -y flathub net.pcsx2.PCSX2
# flatpak install --user -y flathub com.github.phase1geo.minder
# flatpak install --user -y flathub nl.hjdskes.gcolor3
# flatpak install --user -y flathub io.github.peazip.PeaZip
# flatpak install --user -y flathub io.github.philipk.boilr
# flatpak install --user -y flathub com.raggesilver.BlackBox
