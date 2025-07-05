#!/usr/bin/env bash
set -euo pipefail

### IMPORTS
Preinstall=./common/scripts/preinstall.sh
HardwareConfigLaptop=./hosts/t480/scripts/hardwarecfg.sh
HardwareConfigPC=./hosts/h310m-k/scripts/hardwarecfg.sh
PackageManagerInstallLaptop=./hosts/t480/scripts/installers/pkgman-install.sh
PackageManagerInstallPC=./hosts/h310m-k/scripts/installers/pkgman-install.sh
PackageManagerCleaning=./common/scripts/cleaning.sh
FlatpakInstall=./common/scripts/installers/flatpak-install.sh
PIPInstall=./common/scripts/installers/pip-install.sh
ConfigsLaptop=./hosts/t480/scripts/configs.sh
ConfigsPC=./hosts/h310m-k/scripts/configs.sh
ConfigsGlobal=./common/scripts/configs.sh
RestoreFromFiles=./common/scripts/file_restore.sh

# shellcheck source=/dev/null
source ./scaffold/functions.sh

### VARIABLES
normal_run=false
documents_only=false
configs_only=false
apps_only=false
laptop=false
pc=false


### MENUS
# God have mercy for the poor soul trying to understand this

sudo -v
refresh_sudo &
REFRESH_SUDO_PID=$!
trap 'kill $REFRESH_SUDO_PID 2>/dev/null' EXIT

device_options=("PC (Default)" "Laptop" "Exit")
device_selection=0
while true; do
    clear
    welcome_message
    echo "Select device type:"
    for i in "${!device_options[@]}"; do
        if [ "$i" -eq "$device_selection" ]; then
            echo -e "\033[1;32m> ${device_options[$i]}\033[0m"
        else
            echo " ${device_options[$i]}"
        fi
    done
    IFS= read -rsn1 input
    case $input in
        $'\e')
            read -rsn1 -t 1 input
            if [[ "$input" == "[" ]]; then
                read -rsn1 -t 1 input
                case "$input" in
                    "A")
                        if [ "$device_selection" -gt 0 ]; then
                            ((device_selection--))
                        else
                            device_selection=$((${#device_options[@]} - 1))
                        fi
                        ;;
                    "B")
                        total_device_options=${#device_options[@]}
                        if [ "$device_selection" -lt "$((total_device_options - 1))" ]; then
                            device_selection=$((device_selection + 1))
                        else
                            device_selection=0
                        fi
                        ;;
                esac
            fi
            ;;
        "")
            if [ "$device_selection" -ge 0 ] && [ "$device_selection" -lt "${#device_options[@]}" ]; then
                case "$device_selection" in
                    0)
                        info_message "PC selected"
                        pc=true
                        ;;
                    1)
                        info_message "Laptop selected"
                        laptop=true
                        ;;
                    2)
                	error_message "Installation aborted."
                        exit 0
                        ;;
                esac
                break
            else
                error_message "Invalid selection. Exiting..."
                exit 1
            fi
            ;;
        *)
            continue
            ;;
    esac
done

options=("Run normally (Default)" "Restore only user files" "Restore only configs" "Install only apps" "Exit")
selection=0
while true; do
    clear
    welcome_message
    echo "Select an option:"
    for i in "${!options[@]}"; do
        if [ "$i" -eq "$selection" ]; then
            echo -e "\033[1;32m> ${options[$i]}\033[0m"
        else
            echo " ${options[$i]}"
        fi
    done
    IFS= read -rsn1 input
    case $input in
        $'\e')
            read -rsn1 -t 1 input
            if [[ "$input" == "[" ]]; then
                read -rsn1 -t 1 input
                case "$input" in
                    "A")
                        if [ "$selection" -gt 0 ]; then
                            ((selection--))
                        else
                            selection=$((${#options[@]} - 1))
                        fi
                        ;;
                    "B")
                        total_options=${#options[@]}
                        if [ "$selection" -lt "$((total_options - 1))" ]; then
                            selection=$((selection + 1))
                        else
                            selection=0
                        fi
                        ;;
                esac
            fi
            ;;
        "")
            if [ "$selection" -ge 0 ] && [ "$selection" -lt "${#options[@]}" ]; then
                case "$selection" in
                    0)
                        info_message "Running SetupSync normally..."
                        normal_run=true
                        ;;
                    1)
                        info_message "Running SetupSync while only restoring user files..."
                        documents_only=true
                        ;;
                    2)
                        info_message "Running SetupSync while only restoring configs..."
                        configs_only=true
                        ;;
                    3)
                        info_message "Running SetupSync while only installing apps..."
                        apps_only=true
                        ;;
                    4)
                        error_message "Installation aborted."
                        exit 0
                        ;;
                esac
                break
            else
                error_message "Invalid selection. Exiting..."
                exit 1
            fi
            ;;
        *)
            continue
            ;;
    esac
done

if [ "$selection" -ne 4 ]; then
    read -r -p '    >>> Type "CONFIRM" to confirm your choice: ' confirmchoice
    case $confirmchoice in
        [Cc][Oo][Nn][Ff][Ii][Rr][Mm])
            ;;
        *)
            error_message "Invalid option. Installation aborted."
            exit 1
            ;;
    esac
fi


### INSTALL
# The main part of the app, it installs things, configures other things etc depending on the selected mode
# what else did you expect?

if $normal_run; then
    clear
    info_message "Preparing for the install..."
    sleep 2; $Preinstall; sleep 5; clear
    
    info_message "Configuring hardware..."
    sleep 2
    if $laptop; then
        $HardwareConfigLaptop
    elif $pc; then
        $HardwareConfigPC
    fi
    sleep 5; clear
    
    info_message "Installing apps through distro's package manager..."
    sleep 2
    if $laptop; then
        $PackageManagerInstallLaptop
    elif $pc; then
        $PackageManagerInstallPC
    fi
    sleep 5; clear
    
    info_message "Installing apps through flatpak..."
    sleep 2; $FlatpakInstall; sleep 5; clear
    
    info_message "Installing apps through pip..."
    sleep 2; $PIPInstall; sleep 5; clear
    
    info_message "Restoring user configs..."
    sleep 2
    if $laptop; then
        $ConfigsLaptop
    elif $pc; then
        $ConfigsPC
    fi
    $ConfigsGlobal
    sleep 5; clear
    
    info_message "Restoring user files..."
    sleep 2; $RestoreFromFiles; sleep 5; clear
    
    info_message "Cleaning things up..."
    sleep 2; $PackageManagerCleaning; sleep 5; clear

elif $documents_only; then
    clear
    info_message "Restoring user files..."
    sleep 2; $RestoreFromFiles; sleep 5; clear

elif $configs_only; then
    clear
    info_message "Restoring user configs..."
    sleep 2
    if $laptop; then
        $ConfigsLaptop
    elif $pc; then
        $ConfigsPC
    fi
    $ConfigsGlobal
    sleep 5; clear

elif $apps_only; then
    clear
    info_message "Preparing for the install..."
    sleep 2; $Preinstall; sleep 5; clear

    info_message "Installing apps through distro's package manager..."
    sleep 2
    if $laptop; then
        $PackageManagerInstallLaptop
    elif $pc; then
        $PackageManagerInstallPC
    fi
    sleep 5; clear
    
    info_message "Installing apps through flatpak..."
    sleep 2; $FlatpakInstall; sleep 5; clear
    
    info_message "Installing apps through pip..."
    sleep 2; $PIPInstall; sleep 5; clear
fi


### AFTERINSTALL
# Changes the shell to fish and adds the user to libvirt group
# after that it asks if you want to reboot

user=$( whoami )
sudo chsh -s "$(which fish)" "$user"
sudo usermod -a -G libvirt "$user"
sudo chsh -s "$(which fish)" "$user"

error_code=$?
if [ $error_code -eq 0 ]; then
    run_successfully "SetupSync finished successfully!"
    read -r -p "Do you want to restart your computer? [y/N]: " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
    echo ""; info_message " Rebooting in... ";
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
