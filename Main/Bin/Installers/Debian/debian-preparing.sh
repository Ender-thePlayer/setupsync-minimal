#!/usr/bin/env bash

# sudo apt-add-repository -y contrib
# sudo apt-add-repository -y non-free-firmware
# sudo apt-add-repository -y non-free
# sudo apt update -y

echo "deb http://deb.debian.org/debian/ stable main contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/ stable main contrib non-free" | sudo tee -a /etc/apt/sources.list
sudo apt update -y