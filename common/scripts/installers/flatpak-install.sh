#!/usr/bin/env bash


### FLATPAK
flatpak=(
"org.gtk.Gtk3theme.adw-gtk3"
"org.gtk.Gtk3theme.adw-gtk3-dark"
"com.obsproject.Studio"
"org.tenacityaudio.Tenacity"
"com.notesnook.Notesnook"
"net.lutris.Lutris"
"com.github.maoschanz.drawing"
"org.gnome.World.PikaBackup"
"org.nickvision.tagger"
"com.github.neithern.g4music"
"org.localsend.localsend_app"
"io.gitlab.librewolf-community"
"com.vysp3r.ProtonPlus"
)

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
for pkg in "${flatpak[@]}"; do
    flatpak install --user -y flathub "$pkg"
done