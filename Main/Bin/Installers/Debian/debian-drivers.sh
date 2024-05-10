#!/usr/bin/env bash

sudo wget 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2937db010da51096cd4277ff8d4c774ba6d18f90' -O /etc/apt/trusted.gpg.d/uunicorn.asc
echo -e 'deb [signed-by=/etc/apt/trusted.gpg.d/uunicorn.asc] https://ppa.launchpadcontent.net/uunicorn/open-fprintd/ubuntu kinetic main\n#deb-src [signed-by=/etc/apt/trusted.gpg.d/uunicorn.asc] https://ppa.launchpadcontent.net/uunicorn/open-fprintd/ubuntu kinetic main' | sudo tee /etc/apt/sources.list.d/uunicorn-open-fprintd.list
sudo apt -y update && sudo apt install -y open-fprintd fprintd-clients python3-validity

sudo validity-sensors-firmware
sudo systemctl stop python3-validity;sleep 10
sudo python3 /usr/share/python-validity/playground/factory-reset.py

sudo touch /usr/share/python-validity/backoff
sudo touch /usr/share/python-validity/calib-data.bin
cd /usr/share/python-validity && ls -la
sudo chmod 755 6_07f_lenovo_mis_qm.xpfwext

echo -e "[Unit]\nDescription=Restart services to fix fingerprint integration\nAfter=suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target\n\n[Service]\nType=oneshot\nExecStart=systemctl restart open-fprintd.service python3-validity.service\n\n[Install]\nWantedBy=suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target" | sudo tee /etc/systemd/system/python3-validity-wakeup.service > /dev/null
sudo systemctl start python3-validity.service
sudo systemctl enable open-fprintd-resume.service open-fprintd-suspend.service open-fprintd.service python3-validity.service
sudo systemctl enable python3-validity-wakeup.service 
sudo pam-auth-update



## POWER MANAGEMENT
sudo apt install -y tlp
sudo apt install -y smartmontools
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



## MICROPHONE
sudo touch /etc/modprobe.d/local.conf
sudo chmod 666 /etc/modprobe.d/local.conf
echo "options snd-hda-intel model=sony-nomic" | sudo tee -a /etc/modprobe.d/local.conf > /dev/null
sudo chmod 644 /etc/modprobe.d/local.conf