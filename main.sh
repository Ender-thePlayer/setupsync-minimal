#!/usr/bin/env bash

#############################
ArchPreparing=./Main/Bin/Installers/Arch/arch-preparing.sh
ArchAppInstaller=./Main/Bin/Installers/Arch/arch-apps-installer.sh
ArchDriverInstaller=./Main/Bin/Installers/Arch/arch-drivers.sh
ArchCleaning=./Main/Bin/Cleaning/Arch/arch-cleaning.sh

DebianPreparing=./Main/Bin/Installers/Debian/debian-preparing.sh
DebianAppInstaller=./Main/Bin/Installers/Debian/debian-apps-installer.sh
DebianDriverInstaller=./Main/Bin/Installers/Debian/debian-drivers.sh
DebianCleaning=./Main/Bin/Cleaning/Debian/debian-cleaning.sh

FedoraPreparing=./Main/Bin/Installers/Fedora/fedora-preparing.sh
FedoraAppInstaller=./Main/Bin/Installers/Fedora/fedora-apps-installer.sh
FedoraDriverInstaller=./Main/Bin/Installers/Fedora/fedora-drivers.sh
FedoraCleaning=./Main/Bin/Cleaning/Fedora/fedora-cleaning.sh

FlatpakInstaller=./Main/Bin/Installers/flatpak-apps-installer.sh
MiscInstaller=./Main/Bin/Installers/misc-apps-installer.sh

RestoreFromFiles=./Main/Bin/RestoreFromFiles/file_restore.sh
Config=./Main/Bin/Config/config.sh
DotFiles=./Main/Bin/Config/dotfiles.sh

#############################
debian_support=false
fedora_support=false
arch_support=false
with_drivers=false
drivers_only=false
files_only=false
configs_only=false
dotfiles_only=false
something_else=false
#############################

# shellcheck source=/dev/null
source functions.sh
welcome_message

if [ "$( distro )" = "fedora" ]; then
    fedora_support=true
    vardistro="Fedora"
elif [ "$( distro )" = "debian" ]; then
    debian_support=true
    vardistro="Debian"
elif [ "$( distro )" = "arch" ]; then
    arch_support=true
    vardistro="Arch Linux"
else
    error_message "Not using ArchLinux, Fedora or Debian!"
fi

list_message; choice=1
read -r -p "Enter your choice (1-5): " user_choice

if [ -n "$user_choice" ]; then
    choice="$user_choice"
fi

case $choice in
    1)
        info_message "Running SetupSync with Driver Install..."
        with_drivers=true
        ;;
    2)
        info_message "Running SetupSync without Driver Install..."
        with_drivers=false
        ;;
    3)
        info_message "Running SetupSync with ONLY Driver Install..."
        drivers_only=true
        ;;
    4)
        info_message "Something else..."
        something_else=true
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

if $something_else; then
    advanced_settings
    read -r -p "Enter your choice (1-4): " advchoice
    case $advchoice in
        1)
            info_message "Running SetupSync while only restoring user files..."
            files_only=true
            ;;
        2)
            info_message "Running SetupSync while only restoring GNOME extensions..."
            configs_only=true
            ;;
        3)
            info_message "Running SetupSync while only restoring DotFiles..."
            dotfiles_only=true
            ;;
        4)
            info_message "Installation aborted."
            exit
            ;;
        *)
            echo "Invalid choice. Please enter a number from 1 to 3."
            exit 1
            ;;
    esac

else
    if [ "$drivers_only" = true ]; then
        vardrivers='ONLY INSTALLING DRIVERS'

    elif [ "$with_drivers" = true ]; then
        vardrivers='INSTALLING DRIVERS'
    
    else
        vardrivers='NOT INSTALLING DRIVERS'
    fi
fi

echo "  >>> $vardistro support and $vardrivers."
read -r -p 'Type "CONFIRM" to confirm your choice: ' confirmchoice
case $confirmchoice in
    [Cc][Oo][Nn][Ff][Ii][Rr][Mm])
        run_message "Running SetupSync with $vardistro support while $vardrivers."
        ;;
    *)
        echo "Invalid option. Installation aborted."
        exit 1
        ;;
esac

refresh_sudo &

if $arch_support && $with_drivers;
then
    clear
    info_message "Preparing..."
    $ArchPreparing;clear
    sleep 5;info_message "Installing drivers..."
    $ArchDriverInstaller;clear
    sleep 5;info_message "Installing apps through distro's package manager..."
    $ArchAppInstaller;clear
    sleep 5;info_message "Installing apps through flatpak..."
    $FlatpakInstaller;clear
    sleep 5;info_message "Installing misc apps..."
    $MiscInstaller;clear
    sleep 5;info_message "Making some configs..."
    $Config;clear
    sleep 5;info_message "Moving the DotFiles..."
    $DotFiles;clear
    sleep 5;info_message "Moving the files..."
    $RestoreFromFiles;clear
    sleep 5;info_message "Cleaning things up..."
    $ArchCleaning;clear

elif $arch_support && $drivers_only;
then
    clear
    info_message "Preparing..."
    $ArchPreparing;clear
    sleep 5;info_message "Installing drivers..."
    $ArchDriverInstaller;clear

elif $fedora_support && $with_drivers;
then
    clear
    info_message "Preparing..."
    $FedoraPreparing;clear
    sleep 5;info_message "Installing drivers..."
    $FedoraDriverInstaller;clear
    sleep 5;info_message "Installing apps through distro's package manager..."
    $FedoraAppInstaller;clear
    sleep 5;info_message "Installing apps through flatpak..."
    $FlatpakInstaller;clear
    sleep 5;info_message "Installing misc apps..."
    $MiscInstaller;clear
    sleep 5;info_message "Making some configs..."
    $Config;clear
    sleep 5;info_message "Moving the DotFiles..."
    $DotFiles;clear
    sleep 5;info_message "Moving the files..."
    $RestoreFromFiles;clear
    sleep 5;info_message "Cleaning things up..."
    $FedoraCleaning;clear

elif $fedora_support && $drivers_only;
then
    clear
    info_message "Preparing..."
    $FedoraPreparing;clear
    sleep 5;info_message "Installing drivers..."
    $FedoraDriverInstaller;clear

elif $debian_support && $with_drivers;
then
    clear
    info_message "Preparing..."
    $DebianPreparing;clear
    sleep 5;info_message "Installing drivers..."
    $DebianDriverInstaller;clear
    sleep 5;info_message "Installing apps through distro's package manager..."
    $DebianAppInstaller;clear
    sleep 5;info_message "Installing apps through flatpak..."
    $FlatpakInstaller;clear
    sleep 5;info_message "Installing misc apps..."
    $MiscInstaller;clear
    sleep 5;info_message "Making some configs..."
    $Config;clear
    sleep 5;info_message "Moving the DotFiles..."
    $DotFiles;clear
    sleep 5;info_message "Moving the files..."
    $RestoreFromFiles;clear
    sleep 5;info_message "Cleaning things up..."
    $DebianCleaning;clear

elif $debian_support && $drivers_only;
then
    clear
    info_message "Preparing..."
    $DebianPreparing;clear
    sleep 5;info_message "Installing drivers..."
    $DebianDriverInstaller;clear

elif $arch_support;
then
    clear
    info_message "Preparing..."
    $ArchPreparing;clear
    sleep 5;info_message "Installing apps through distro's package manager..."
    $ArchAppInstaller;clear
    sleep 5;info_message "Installing apps through flatpak..."
    $FlatpakInstaller;clear
    sleep 5;info_message "Installing misc apps..."
    $MiscInstaller;clear
    sleep 5;info_message "Making some configs..."
    $Config;clear
    sleep 5;info_message "Moving the DotFiles..."
    $DotFiles;clear
    sleep 5;info_message "Moving the files..."
    $RestoreFromFiles;clear
    sleep 5;info_message "Cleaning things up..."
    $ArchCleaning;clear

elif $fedora_support;
then
    clear
    info_message "Preparing..."
    $FedoraPreparing;clear
    sleep 5;info_message "Installing apps through distro's package manager..."
    $FedoraAppInstaller;clear
    sleep 5;info_message "Installing apps through flatpak..."
    $FlatpakInstaller;clear
    sleep 5;info_message "Installing misc apps..."
    $MiscInstaller;clear
    sleep 5;info_message "Making some configs..."
    $Config;clear
    sleep 5;info_message "Moving the DotFiles..."
    $DotFiles;clear
    sleep 5;info_message "Moving the files..."
    $RestoreFromFiles;clear
    sleep 5;info_message "Cleaning things up..."
    $FedoraCleaning;clear

elif $debian_support;
then
    clear
    info_message "Preparing..."
    $DebianPreparing;clear
    sleep 5;info_message "Installing apps through distro's package manager..."
    $DebianAppInstaller;clear
    sleep 5;info_message "Installing apps through flatpak..."
    $FlatpakInstaller;clear
    sleep 5;info_message "Installing misc apps..."
    $MiscInstaller;clear
    sleep 5;info_message "Making some configs..."
    $Config;clear
    sleep 5;info_message "Moving the DotFiles..."
    $DotFiles;clear
    sleep 5;info_message "Moving the files..."
    $RestoreFromFiles;clear
    sleep 5;info_message "Cleaning things up..."
    $DebianCleaning;clear
fi

if $files_only;
then
    clear
    sleep 5;info_message "Moving the files..."
    $RestoreFromFiles;clear

elif $configs_only;
then
    clear
    sleep 5;info_message "Making some configs..."
    $Config;clear

elif $dotfiles_only;
then
    clear
    sleep 5; info_message "Moving the DotFiles..."
    $DotFiles;clear
fi


while true; do
    read -r -p "Do you want to enroll your fingerprint now? [y/N]: " answer
    case $answer in
        [Yy]|[Yy][Ee][Ss])
            info_message "Enrolling fingerprint..."
            fprintd-enroll;sleep 5;clear
            break;;
        [Nn]|[Nn][Oo])
            info_message "Skipping...";sleep 5;clear
            break;;
        *)
            ;;
    esac
done

while true; do
    read -r -p "Do you want to set zsh as the default shell now? [y/N]: " answer
    case $answer in
        [Yy]|[Yy][Ee][Ss])
            info_message "Setting the new default shell..."
            chsh -s "$(which zsh)";sleep 5;clear
            break;;
        [Nn]|[Nn][Oo])
            info_message "Skipping...";sleep 5;clear
            break;;
        *)
            ;;
    esac
done

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
    sudo shutdown -r now

else
    fatal_error "An unrecoverable error has occurred!" $error_code
fi