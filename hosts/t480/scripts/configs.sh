#!/usr/bin/env bash

# shellcheck source=/dev/null
source ./scaffold/functions.sh


### THEMING
# Gets the GTK3 theme and puts it in the right folder
wget "$(curl -s https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest | jq -r '.assets[] | select(.name | endswith(".tar.xz")) | .browser_download_url')"
mkdir ~/.local/share/themes/
tar -xf ./adw-gtk3* -C ~/.local/share/themes/
rm ./adw-gtk3*
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface font-name "Inter 10"
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' 

# It gets the SDDM Flower Theme and installs it
sudo git clone https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/OpenSans/* /usr/share/fonts/
echo -e "[Theme]\nCurrent=sddm-astronaut-theme" | sudo tee /etc/sddm.conf > /dev/null
sudo sed -i 's|ConfigFile=Themes/astronaut.conf|ConfigFile=Themes/purple_leaves.conf|' /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop

# It sets a cursor theme
git clone https://github.com/supermariofps/hatsune-miku-windows-linux-cursors
mkdir -p ~/.local/share/icons/
mv ./hatsune-miku-windows-linux-cursors/miku-cursor-linux ~/.local/share/icons
rm -rf hatsune-miku-windows-linux-cursors


### CONFIGS
# Copies the rest of the dotfiles in .config
shopt -s dotglob
cp -r ./hosts/t480/shared/config/* "$HOME"/.config/


### OPEN KITTY IN NAUTILUS
glib-compile-schemas ~/.local/share/glib-2.0/schemas/
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty


## NAUTILUS AND TEXTEDITOR CONFIGS
dconf load /org/gnome/nautilus/ < ./hosts/t480/shared/nautilus.conf
dconf load /org/gtk/gtk4/settings/file-chooser/ < ./hosts/t480/shared/file-chooser.conf
dconf load /org/gnome/TextEditor/ < ./hosts/t480/shared/texteditor.conf