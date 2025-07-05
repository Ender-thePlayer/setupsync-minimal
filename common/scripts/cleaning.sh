#!/usr/bin/env bash

### CLEANING
sudo pacman -R --noconfirm wofi
sudo pacman -Qdtq | sudo pacman -Rns --noconfirm -
