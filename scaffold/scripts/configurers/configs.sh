#!/usr/bin/env bash

###NOTE: There was config for a QEMU KVM and librewolf but I decided not to include them here!

# shellcheck source=/dev/null
source ./scaffold/functions.sh

### THEMING
# Gets the GTK3 theme and puts it in the right folder
wget "$( curl -s https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest | grep browser_download_url | cut -d '"' -f 4 )"
mkdir ~/.local/share/themes/
tar -xf ./adw-gtk3* -C ~/.local/share/themes/
rm ./adw-gtk3*
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

### FIX FOR ONESHOT
mkdir -p ln -s ~/.steam/steam/steamapps/compatdata/420530/pfx/drive_c/users/steamuser/Documents 
ln -s ~/.steam/steam/steamapps/compatdata/420530/pfx/drive_c/users/steamuser/Documents ~/Documents/ProtonDocuments


### SDDM
# It gets the SDDM Flower Theme and installs it
sudo git clone https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
echo -e "[Theme]\nCurrent=sddm-astronaut-theme" | sudo tee /etc/sddm.conf > /dev/null



### SETS THE DEFAULT APPS FOR FILE TYPES
xdg-mime default org.gnome.Loupe.desktop image/jpeg image/jpg image/png image/bmp image/webp
xdg-mime default org.gnome.TextEditor.desktop text/plain inode/directory
xdg-mime default org.gnome.Nautilus.desktop inode/directory application/x-gnome-saved-search
xdg-settings set default-web-browser librewolf.desktop
xdg-user-dirs-update



### OPEN KITTY IN NAUTILUS
glib-compile-schemas ~/.local/share/glib-2.0/schemas/
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty



### VIM
# It makes possible for me to select and CTRL + SHIFT + C to copy in VIM
echo 'autocmd VimEnter * set mouse=' | sudo tee -a /etc/vimrc



### MAKES LINUX ZEN TO BE THE DEFAULT SELECTED IN SYSTEMD-BOOT
echo 'default *_linux-zen.conf' | sudo tee -a /boot/loader/loader.conf > /dev/null 
