#!/usr/bin/env bash

flatpak=(
"dev.vencord.Vesktop"
"org.gtk.Gtk3theme.adw-gtk3"
"org.gtk.Gtk3theme.adw-gtk3-dark"
"com.obsproject.Studio"
"com.github.tchx84.Flatseal"
"org.tenacityaudio.Tenacity"
"org.torproject.torbrowser-launcher"
"com.notesnook.Notesnook"
"com.belmoussaoui.Authenticator"
"net.lutris.Lutris"
"com.github.maoschanz.drawing"
"org.gnome.World.PikaBackup"
"org.libreoffice.LibreOffice"
"org.gnome.Brasero"
"org.nickvision.tagger"
"com.github.neithern.g4music"
)


### FLATPAK
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
for pkg in "${flatpak[@]}"; do
    flatpak install --user -y flathub "$pkg"
done
flatpak install --user -y https://sober.vinegarhq.org/sober.flatpakref