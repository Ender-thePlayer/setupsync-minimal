#!/usr/bin/env bash

### FLATHUB
# Adds the flathub repo to flatpak if it isn't already
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


### FLATPAK INSTALL
flatpak install --user -y flathub dev.vencord.Vesktop
flatpak install --user -y flathub org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
flatpak install --user -y flathub com.obsproject.Studio
flatpak install --user -y flathub org.zdoom.GZDoom
flatpak install --user -y flathub com.github.tchx84.Flatseal
flatpak install --user -y flathub org.tenacityaudio.Tenacity
flatpak install --user -y flathub com.github.wwmm.easyeffects
flatpak install --user -y flathub com.github.micahflee.torbrowser-launcher
flatpak install --user -y flathub com.notesnook.Notesnook
flatpak install --user -y flathub com.belmoussaoui.Authenticator
flatpak install --user -y flathub net.lutris.Lutris
flatpak install --user -y flathub com.github.maoschanz.drawing
flatpak install --user -y flathub org.gnome.World.PikaBackup
flatpak install --user -y flathub org.libreoffice.LibreOffice
flatpak install --user -y flathub org.gnome.Brasero
flatpak install --user -y flathub net.pcsx2.PCSX2
flatpak install --user -y flathub net.nokyan.Resources
flatpak install --user -y flathub org.nickvision.tagger
flatpak install --user -y flathub com.github.neithern.g4music