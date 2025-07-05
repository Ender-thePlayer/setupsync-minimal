#!/usr/bin/env bash

# shellcheck source=/dev/null
source ./scaffold/functions.sh

### LIBREWOLF
# Copies the librewolf configs
if test -d "./common/shared/librewolf"; then
    profile_dir=$(find ~/.var/app/io.gitlab.librewolf-community/.librewolf -maxdepth 1 -type d -name '*.default-default' -print -quit || echo "")

    if [ ! "$profile_dir" ]; then
        timeout 5 flatpak run io.gitlab.librewolf-community --headless --new-instance &
        wait
    fi

    if [ "$profile_dir" ]; then
        rm -rf "${profile_dir:?}"
        mkdir "${profile_dir:?}"
        cp -r ./common/shared/librewolf/* "$profile_dir"
    fi
fi


### DOTFILES
# Copies the rest of the dotfiles
shopt -s dotglob
cp -r ./common/shared/dotfiles/* "$HOME"/


### VSCODIUM EXTENSIONS
# Installs vscodium extensions

xargs -L 1 codium --install-extension < ./common/shared/vscodium-extensions.txt

###SPICETIFY
# Makes spicetify work
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
spicetify -c

bash -c '''
spicetify backup
sed -i "s|^spotify_path\s*=\s*.*|spotify_path=/opt/spotify/|" "$HOME/.config/spicetify/config-xpui.ini"
sed -i "s|^prefs_path\s*=\s*.*|prefs_path=$HOME/.config/spicetify/config-xpui.ini|" "$HOME/.config/spicetify/config-xpui.ini"
spotify & sleep 2 && pkill spotify
spicetify config sidebar_config 0
spicetify config custom_apps lyrics-plus
spicetify config custom_apps marketplace
spicetify backup apply
spicetify apply
'''


### VIM
#It makes possible for me to select and CTRL + SHIFT + C to copy in VIM
echo 'autocmd VimEnter * set mouse=' | sudo tee -a /etc/vimrc > /dev/null


### ENVIRONMENT
echo 'FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"' | sudo tee -a /etc/environment > /dev/null