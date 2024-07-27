#!/usr/bin/env bash

sudo systemctl enable --now bluetooth

### FINGERPRINT
# Makes the 06cb:009a Synaptics, Inc. Metallica MIS Touch Fingerprint Reader
# work on my system

paru -S glib2-devel --noconfirm
paru -S python-validity --noconfirm

sudo validity-sensors-firmware
sudo systemctl stop python3-validity;sleep 10
sudo python3 /usr/share/python-validity/playground/factory-reset.py

echo -e "[Unit]\nDescription=Restart services to fix fingerprint integration\nAfter=suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target\n\n[Service]\nType=oneshot\nExecStart=systemctl restart open-fprintd.service python3-validity.service\n\n[Install]\nWantedBy=suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target" | sudo tee /etc/systemd/system/python3-validity-wakeup.service > /dev/null
sudo systemctl start python3-validity.service
sudo systemctl enable open-fprintd-resume.service open-fprintd-suspend.service open-fprintd.service python3-validity.service
sudo systemctl enable python3-validity-wakeup.service 

sudo sed -i '/^auth/ {/^auth.*sufficient.*$/! {s/^auth.*/auth\t\tsufficient\tpam_fprintd.so\n&/}}' /etc/pam.d/sudo  
sudo cp /usr/lib/pam.d/polkit-1 /etc/pam.d/polkit-1
sudo sed -i '/^auth\s\+include\s\+system-auth/i auth       sufficient   pam_fprintd.so' /etc/pam.d/polkit-1



### POWER MANAGEMENT
# Installs tlp for performance, battery life and makes each of my batteries
# to charge to 80% max to prevent battery degradation

sudo pacman -S tlp --noconfirm
sudo pacman -S tlp-rdw --noconfirm
sudo pacman -S smartmontools --noconfirm
sudo sed -i 's/#DEVICES_TO_DISABLE_ON_STARTUP="bluetooth nfc wifi wwan"/DEVICES_TO_DISABLE_ON_STARTUP="bluetooth"/g' /etc/tlp.conf
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



### UNDERVOLTING
# Undervolts (I think, I still don't know if this actually does something)
# my cpu to make it cooler and for the battery last longer

sudo pacman -S throttled --noconfirm
sudo rm /etc/throttled.conf
sudo cp ./scripts/share/throttled.conf /etc/throttled.conf
sudo intel-undervolt apply
sudo systemctl enable throttled.service 



### MICROPHONE
# It makes when I plug a microphone or headphones with microphone
# to ask if it's a headset or headphones so can I use the microphone

sudo touch /etc/modprobe.d/local.conf
sudo chmod 666 /etc/modprobe.d/local.conf
echo "options snd-hda-intel model=sony-nomic" | sudo tee -a /etc/modprobe.d/local.conf >/dev/null
sudo chmod 644 /etc/modprobe.d/local.conf
