#!/usr/bin/env bash
set -euo pipefail

### IMPORTS
Preinstall=./scaffold/scripts/preinstall.sh
HardwareConfig=./scaffold/scripts/hardwarecfg.sh
PackageManagerInstall=./scaffold/scripts/installers/pkgman-install.sh
PackageManagerCleaning=./scaffold/scripts/cleaning.sh
FlatpakInstall=./scaffold/scripts/installers/flatpak-install.sh
PIPInstall=./scaffold/scripts/installers/pip-install.sh
Configs=./scaffold/scripts/configs.sh
RestoreFromFiles=./scaffold/scripts/file_restore.sh
# DotFiles=./scaffold/scripts/configurers/dotfiles.sh

# shellcheck source=/dev/null
source ./scaffold/functions.sh

### VARIABLES
normal_run=false
documents_only=false
configs_only=false
apps_only=false



### EXECS
welcome_message
list_message; choice=1
read -r -p "Enter your choice (1-5): " user_choice

if [ -n "$user_choice" ]; then
    choice="$user_choice"
fi

case $choice in
    1)
        info_message "Running SetupSync normally..."
        normal_run=true
        ;;
    2)
        info_message "Running SetupSync while only restoring user files..."
        documents_only=true
        ;;
    3)
        info_message "Running SetupSync while only restoring configs..."
        configs_only=true
        ;;
    4)
        info_message "Running SetupSync while only installing apps..."
        apps_only=true
        ;;
    5)
        info_message "Installation aborted."
        exit 1
        ;;
    *)
        echo "Invalid choice. Please enter a number from 1 to 5."
        exit 1
        ;;
esac

read -r -p '    >>> Type "CONFIRM" to confirm your choice: ' confirmchoice
case $confirmchoice in
    [Cc][Oo][Nn][Ff][Ii][Rr][Mm])
        ;;
    *)
        error_message "Invalid option. Installation aborted."
        ;;
esac
refresh_sudo &

if $normal_run;
then
    clear
    info_message "Preparing for the install..."
    sleep 2;$Preinstall;sleep 5;clear
    info_message "Configuring hardware..."
    sleep 2;$HardwareConfig;sleep 5;clear
    info_message "Installing apps through distro's package manager..."
    sleep 2;$PackageManagerInstall;sleep 5;clear
    info_message "Installing apps through flatpak..."
    sleep 2;$FlatpakInstall;sleep 5;clear
    info_message "Installing apps through pip..."
    sleep 2;$PIPInstall;sleep 5;clear
    info_message "Restoring user configs..."
    sleep 2;$Configs;sleep 5;clear
    info_message "Restoring user files..."
    sleep 2;$RestoreFromFiles;sleep 5;clear
    info_message "Cleaning things up..."
    sleep 2;$PackageManagerCleaning;sleep 5;clear

elif $documents_only;
then
    clear
    info_message "Restoring user files..."
    sleep 2;$RestoreFromFiles;sleep 5;clear

elif $configs_only;
then
    clear
    info_message "Restoring user configs..."
    sleep 2;$Configs;sleep 5;clear

elif $apps_only;
then
    clear
    info_message "Preparing for the install..."
    sleep 2;$Preinstall;sleep 5;clear
    info_message "Installing apps through distro's package manager..."
    sleep 2;$PackageManagerInstall;sleep 5;clear
    info_message "Installing apps through flatpak..."
    sleep 2;$FlatpakInstall;sleep 5;clear
    info_message "Installing apps through pip..."
    sleep 2;$PIPInstall;sleep 5;clear
fi



### AFTERINSTALL
# Changes the shell to fish and adds the user to libvirt group
# after that it asks if you want to reboot

user=$( whoami )
sudo chsh -s "$(which fish)" "$user"
sudo usermod -a -G libvirt "$user"    

error_code=$?
if [ $error_code -eq 0 ]; then
    run_successfully "SetupSync finished successfully!"
    read -r -p "Do you want to restart your computer? [y/N]: " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
    echo "";info_message " Rebooting in... ";
    for i in 3 2 1; do
        if [ "$i" -eq 1 ]; then
            echo -ne "$i..."
        else
            echo -n "$i... "
        fi
        sleep 1
    done; sleep 2
    sudo reboot -n

else
    fatal_error "An unrecoverable error has occurred!" $error_code 
fi