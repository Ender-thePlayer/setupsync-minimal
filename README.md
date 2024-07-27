# Welcome to SetupSync (MINIMAL)!

SetupSync is a collection of shell scripts that I use to prepare, install my used apps (through distro's repo, through flatpak, through pip etc), remove any bloat (if there is), move the dotfiles, make my preferred configs to my apps, install GNOME extensions etc.

**NOTE:** This minimal implementation of setupsync does **NOT** include the kvm tarball (cuz it's too big)!


# How it works

When the file `install.sh` it is invoked like `./install.sh` in the relative folder where it is, it automatically detects which of the following supported distros you use (ArchLinux, Fedora Linux, Debian GNU/Linux) and it autodetects which GNOME version you have (if you have).

Then it will ask you if you want to run setupsync like usual, but only configuring some drivers (for my Thinkpad T480): for the fingerptint sensor (python-validity), but also tlp and something headphone related).

After you select an option, it will ask you for access to **SUPERUSER PRIVILEGES** through `sudo`. After that, it will run automatically for the most of the time.

*Note, sometime in the middle, spicetify will ask you for confirmation, I cannot automate this for some reason!

When it is done, it will ask you if you want to change the default shell to `fish` and if you want to enroll your fingerprints, then if you want to restart!


## Dependencies

Any recent enough install of `sudo` (and configured) will be enough and Hyprland (obviously)!
