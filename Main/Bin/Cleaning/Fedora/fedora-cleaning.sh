#!/usr/bin/env bash

sudo dnf5 remove -y cheese
sudo dnf5 remove -y gnome-clocks
sudo dnf5 remove -y gnome-contacts
sudo dnf5 remove -y simple-scan
sudo dnf5 remove -y gnome-maps
sudo dnf5 remove -y rhythmbox
sudo dnf5 -y remove fonts-droid-fallback

sudo rm -r /usr/share/fonts/google-droid-sans-fonts
rm install.log