#!/usr/bin/env bash

# shellcheck source=/dev/null
source ./scaffold/functions.sh

### FLOORP
# Copies the floorp configs
if test -d "./common/shared/floorp"; then
    profile_dir=$(find ~/.var/app/one.ablaze.floorp/.floorp -maxdepth 1 -type d -name '*.default-default' -print -quit || echo "")

    if [ ! "$profile_dir" ]; then
        timeout 5 flatpak run one.ablaze.floorp --headless --new-instance &
        wait
    fi

    if [ "$profile_dir" ]; then
        rm -rf "${profile_dir:?}"
        mkdir "${profile_dir:?}"
        cp -r ./common/shared/floorp/* "$profile_dir"
    fi
fi


### VSCODIUM EXTENSIONS
# Installs vscodium extensions

xargs -L 1 codium --install-extension < ./common/shared/vscodium-extensions.txt


### DOTFILES
# Copies the rest of the dotfiles
shopt -s dotglob
cp -r ./common/shared/dotfiles/* "$HOME"/


### VIM
#It makes possible for me to select and CTRL + SHIFT + C to copy in VIM
echo 'autocmd VimEnter * set mouse=' | sudo tee -a /etc/vimrc > /dev/null


### ENVIRONMENT
echo 'FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"' | sudo tee -a /etc/environment > /dev/null