# Welcome to SetupSync!

SetupSync is a collection of shell scripts that I use to prepare, install my used apps (through distro's repo, through flatpak, through pip etc), remove any bloat (if there is), move the dotfiles, make my preferred configs to my apps, install GNOME extensions etc.

**NOTE:** This minimal implementation of setupsync does **NOT** include the kvm tarball (cuz it's too big) and does **NOT** include the dotfiles for firefox (too personal)!


# How it works

When the file `main.sh` it is invoked like `./main.sh` in the relative folder where it is, it automatically detects which of the following supported distros you use (ArchLinux, Fedora Linux, Debian GNU/Linux) and it autodetects which GNOME version you have (if you have).

Then it will ask you if you want to run setupsync like usual, but only configuring some drivers (for Thinkpad T480, mostly the fingerprint but also tlp and something headphone related).

After you select an option, it will ask you for access to **SUPERUSER PRIVILEGES** through `sudo`. After that, it will run automatically for the most of the time.

*Note, sometime in the middle, where spicetify will ask you for confirmation, I cannot automate this for some reason!

When it is done, it will ask you if you want to change the default shell to `fish` and if you want to enroll the fingerprint, then if you want to restart!


## Dependencies

Any recent enough install of `sudo` and `systemd` will be enough!
