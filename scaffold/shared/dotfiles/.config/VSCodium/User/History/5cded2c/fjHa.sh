#!/usr/bin/env bash

### POWER MANAGEMENT
# Installs tlp for performance, battery life and makes each of my batteries
# to charge to 80% max to prevent battery degradation
sudo pacman -S tlp --noconfirm
sudo pacman -S tlp-rdw --noconfirm
sudo pacman -S smartmontools --noconfirm
sudo sed -i 's/#DEVICES_TO_DISABLE_ON_STARTUP="bluetooth nfc wifi wwan"/DEVICES_TO_DISABLE_ON_STARTUP="bluetooth"/g' /etc/tlp.conf
sudo sed -i 's/#CPU_SCALING_GOVERNOR_ON_AC=powersave/CPU_SCALING_GOVERNOR_ON_AC=performance/g' /etc/tlp.conf
sudo sed -i 's/#CPU_SCALING_GOVERNOR_ON_BAT=powersave/CPU_SCALING_GOVERNOR_ON_BAT=powersave/g' /etc/tlp.conf
sudo sed -i 's/#START_CHARGE_THRESH_BAT0=75/START_CHARGE_THRESH_BAT0=75/g' /etc/tlp.conf
sudo sed -i 's/#STOP_CHARGE_THRESH_BAT0=80/STOP_CHARGE_THRESH_BAT0=80/g' /etc/tlp.conf
sudo sed -i 's/#START_CHARGE_THRESH_BAT1=75/START_CHARGE_THRESH_BAT1=75/g' /etc/tlp.conf
sudo sed -i 's/#STOP_CHARGE_THRESH_BAT1=80/STOP_CHARGE_THRESH_BAT1=80/g' /etc/tlp.conf
sudo systemctl enable tlp.service
sudo systemctl mask power-profiles-daemon.service
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
sudo systemctl enable --now bluetooth
sudo tlp start


### THROTTLED
# Fixes random problems with throttling on my T480
sudo pacman -S throttled --noconfirm
sudo rm /etc/throttled.conf
sudo cp ./scaffold/shared/throttled.conf /etc/throttled.conf
sudo systemctl enable throttled.service 


### THINKFAN
# Changes the fan curves to be more aggressive
paru -S --noconfirm thinkfan
sudo cp ./scaffold/shared/thinkfan.conf /etc/thinkfan.conf
sudo systemctl enable thinkfan.service    


### MICROPHONE
# It makes when I plug a microphone or headphones with microphone
# to ask if it's a headset or headphones so can I use the microphone
# sudo touch /etc/modprobe.d/local.conf
# sudo chmod 666 /etc/modprobe.d/local.conf
# echo "options snd-hda-intel model=sony-nomic" | sudo tee -a /etc/modprobe.d/local.conf >/dev/null
# sudo chmod 644 /etc/modprobe.d/local.conf
