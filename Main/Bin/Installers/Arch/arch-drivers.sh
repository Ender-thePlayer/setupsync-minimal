#!/usr/bin/env bash

paru -S python-validity --noconfirm

sudo validity-sensors-firmware
sudo systemctl stop python3-validity;sleep 10
sudo python3 /usr/share/python-validity/playground/factory-reset.py

echo -e "[Unit]\nDescription=Restart services to fix fingerprint integration\nAfter=suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target\n\n[Service]\nType=oneshot\nExecStart=systemctl restart open-fprintd.service python3-validity.service\n\n[Install]\nWantedBy=suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target" | sudo tee /etc/systemd/system/python3-validity-wakeup.service > /dev/null
sudo systemctl start python3-validity.service
sudo systemctl enable open-fprintd-resume.service open-fprintd-suspend.service open-fprintd.service python3-validity.service
sudo systemctl enable python3-validity-wakeup.service 

sudo sed -i '/^auth/ {/^auth.*sufficient.*$/! {s/^auth.*/auth\t\tsufficient\tpam_fprintd.so\n&/}}' /etc/pam.d/sudo  



## POWER MANAGEMENT
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
sudo tlp start



## UNDERVOLTING
sudo pacman -S intel-undervolt --noconfirm

# shellcheck disable=SC2002
cat ./Main/Lib/Config/intel-undervolt.conf | sudo tee /etc/intel-undervolt.conf > /dev/null
sudo intel-undervolt apply
sudo systemctl enable intel-undervolt.service



## MICROPHONE
sudo touch /etc/modprobe.d/local.conf
sudo chmod 666 /etc/modprobe.d/local.conf
echo "options snd-hda-intel model=sony-nomic" | sudo tee -a /etc/modprobe.d/local.conf >/dev/null
sudo chmod 644 /etc/modprobe.d/local.conf