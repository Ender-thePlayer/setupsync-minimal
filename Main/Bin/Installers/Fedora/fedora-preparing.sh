#!/usr/bin/env bash

## Hopefully it makes dnf a 'lil faster
echo -e "max_parallel_downloads=20\nfastestmirror=True\ndefaultyes=True\nkeepcache=True" | sudo tee -a /etc/dnf/dnf.conf > /dev/null

sudo dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm
sudo dnf install -y \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
    
sudo dnf upgrade -y --refresh
sudo dnf install -y dnf5
sudo dnf install -y dnf5-plugins