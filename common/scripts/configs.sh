#!/usr/bin/env bash
# shellcheck source=/dev/null
source ./scaffold/functions.sh


### LIBREWOLF
# Copies the librewolf configs
if test -d "./common/shared/librewolf"; then
    profile_dir=$(find ~/.var/app/io.gitlab.librewolf-community/config/librewolf/librewolf -maxdepth 1 -type d -name '*.default-default' -print -quit || echo "")

    if [ ! "$profile_dir" ]; then
        timeout 5 flatpak run io.gitlab.librewolf-community --headless --new-instance &
        wait
    fi

    sleep 2
    profile_dir=$(find ~/.var/app/io.gitlab.librewolf-community/config/librewolf/librewolf -maxdepth 1 -type d -name '*.default-default' -print -quit || echo "")

    if [ "$profile_dir" ]; then
        rm -rf "${profile_dir:?}"
        mkdir "${profile_dir:?}"
        cp -r ./common/shared/librewolf/* "$profile_dir"
    fi
fi


### THEMING
# Gets the GTK3 theme and puts it in the right folder
wget "$(curl -s https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest | jq -r '.assets[] | select(.name | endswith(".tar.xz")) | .browser_download_url')"
mkdir ~/.local/share/themes/
tar -xf ./adw-gtk3* -C ~/.local/share/themes/
rm ./adw-gtk3*
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface font-name "Inter 10"
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' 

# It sets a cursor theme
git clone https://github.com/supermariofps/hatsune-miku-windows-linux-cursors
mkdir -p ~/.local/share/icons/
mv ./hatsune-miku-windows-linux-cursors/miku-cursor-linux ~/.local/share/icons/MikuCursor
rm ~/.local/share/icons/MikuCursor/cursor.theme
rm -rf hatsune-miku-windows-linux-cursors
nwg-look -a

# It sets Discord Rich Presence extension for Krita 
git clone https://github.com/Firstbober/krita-rpc.git
mkdir -p ~/.local/share/krita/pykrita/
mv ./krita-rpc/* ~/.local/share/krita/pykrita/
rm -rf krita-rpc


### OPEN KITTY IN NAUTILUS
glib-compile-schemas ~/.local/share/glib-2.0/schemas/
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty
xdg-user-dirs-update


## NAUTILUS AND TEXTEDITOR CONFIGS
dconf load /org/gnome/nautilus/ < ./common/shared/nautilus.conf
dconf load /org/gtk/gtk4/settings/file-chooser/ < ./common/shared/file-chooser.conf
dconf load /org/gnome/TextEditor/ < ./common/shared/texteditor.conf


### VSCODIUM EXTENSIONS
# Installs vscodium extensions
xargs -L 1 codium --install-extension < ./common/shared/vscodium-extensions.txt


### DOTFILES
# Copies the rest of the dotfiles
shopt -s dotglob
cp -r ./common/shared/dotfiles/* "$HOME"/

if [ "$1" = "--pc-config" ]; then
    cp -r ./hosts/pc/shared/config/* "$HOME"/.config/
elif [ "$1" = "--laptop-config" ]; then
    cp -r ./hosts/laptop/shared/config/* "$HOME"/.config/
fi

### VIM
#It makes possible for me to select and CTRL + SHIFT + C to copy in VIM
echo 'autocmd VimEnter * set mouse=' | sudo tee -a /etc/vimrc > /dev/null


### ENVIRONMENT
echo 'FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"' | sudo tee -a /etc/environment > /dev/null
