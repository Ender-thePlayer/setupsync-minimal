# Welcome to SetupSync!

SetupSync is a collection of shell scripts that I use to configure the system, install my used apps (through pacman/AUR, through flatpak, through pip etc), move dotfiles, make my preferred configs to my apps, etc.


# How it works

Run `./install.sh` in the relative folder where it is and go through it's cli UI.

It will ask you for access to **SUPERUSER PRIVILEGES** through `sudo`. After that, it will ask you which option do you want for installation and asks for confirmation, after that it will run automatically.

When it is done, it will ask you if you want to restart!

## Hosts
Laptop - a Thinkpad T480 running Hyprland and archlinux, my daily driver at the moment
PC - coming soon!


## Dependencies

Hyprland, SDDM and sudo (so far).