#!/usr/bin/env bash

## FINGERPRINT
sudo dnf4 copr enable -y taaem/python-validity
sudo dnf5 install -y open-fprintd fprintd-clients fprintd-clients-pam python3-validity

sudo validity-sensors-firmware
sudo python3 /usr/share/python-validity/playground/factory-reset.py

sudo touch /usr/share/python-validity/backoff
sudo touch /usr/share/python-validity/calib-data.bin
cd /usr/share/python-validity && ls -la
sudo chmod 755 6_07f_lenovo_mis_qm.xpfwext

echo -e "[Unit]\nDescription=Restart services to fix fingerprint integration\nAfter=suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target\n\n[Service]\nType=oneshot\nExecStart=systemctl restart open-fprintd.service python3-validity.service\n\n[Install]\nWantedBy=suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target" | sudo tee /etc/systemd/system/python3-validity-wakeup.service > /dev/null
sudo systemctl start python3-validity.service
sudo systemctl enable open-fprintd-resume.service open-fprintd-suspend.service open-fprintd.service python3-validity.service
sudo systemctl enable python3-validity-wakeup.service 
sudo authselect enable-feature with-fingerprint
sudo authselect apply-changes
sudo -u gdm gsettings list-recursively org.gnome.login-screen



## POWER MANAGEMENT
sudo dnf5 install -y tlp
sudo dnf5 install -y tlp-rdw
sudo dnf5 install -y smartmontools
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
echo "options snd-hda-intel model=sony-nomic" | sudo tee -a /etc/modprobe.d/local.conf >/dev/null
sudo chmod 644 /etc/modprobe.d/local.conf