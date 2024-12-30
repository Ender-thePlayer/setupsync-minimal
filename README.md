# Welcome to SetupSync (MINIMAL)!

SetupSync is a collection of shell scripts that I use to prepare, install my used apps (through pacman/AUR, through flatpak, through pip etc), configure system stuff, move the dotfiles, make my preferred configs to my apps, etc.


# How it works

Run `./install.sh` in the relative folder where it is.

It will ask you for access to **SUPERUSER PRIVILEGES** through `sudo`. After that, it will ask you which option do you want for installation and asks for confirmation, after that it will run automatically.

When it is done, it will ask you if you want to restart!


## Dependencies

Hyprland, SDDM and sudo.