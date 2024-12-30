#!/usr/bin/env bash

# shellcheck source=/dev/null
source ./scaffold/functions.sh


### THEMING
# Gets the GTK3 theme and puts it in the right folder
wget "$( curl -s https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest | grep browser_download_url | cut -d '"' -f 4 )"
mkdir ~/.local/share/themes/
tar -xf ./adw-gtk3* -C ~/.local/share/themes/
rm ./adw-gtk3*
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface font-name "Inter 10"
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' 

# It gets the SDDM Flower Theme and installs it
sudo git clone https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
echo -e "[Theme]\nCurrent=sddm-astronaut-theme" | sudo tee /etc/sddm.conf > /dev/null

# It sets a cursor theme
git clone https://github.com/supermariofps/hatsune-miku-windows-linux-cursors
mkdir -p ~/.local/share/icons/
mv ./hatsune-miku-windows-linux-cursors/miku-cursor-linux ~/.local/share/icons
rm -rf hatsune-miku-windows-linux-cursors


### KVM
# It configures the only KVM that I have
#!/usr/bin/env bash
if test -d "./scaffold/shared/kvms"; then
    if [ "$(sha256sum ./scaffold/shared/kvms/kvm.tar.zst)" = "8a44cf71045445a3aad772d5b5162a7db3c6f7efcbf67f4dd929f671a231fa59  ./scaffold/shared/kvms/kvm.tar.zst" ];
    then
        if ! test -f ./tmp; then
            mkdir ./tmp
        fi

        tar -xvaf ./scaffold/shared/kvms/kvm.tar.zst -C ./tmp
        sudo mv ./tmp/kvm/archlinux.qcow2 /var/lib/libvirt/images/

        sudo virsh define "./tmp/kvm/archlinux.xml"
        sudo virsh net-start default
        sudo virsh net-autostart default
        rm -r ./tmp
    else
        warning "Unable to setup kvms! SHA256 mismatch!"
    fi
fi


### LIBREWOLF
# Copies the librewolf configs
if test -d "./scaffold/shared/librewolf"; then
    profile_dir=$(find ~/.librewolf/ -maxdepth 1 -type d -name '*.default-default' -print -quit || echo "")

    if [ ! "$profile_dir" ]; then
        librewolf & sleep 2 && pkill librewolf
        profile_dir=$(find ~/.librewolf/ -maxdepth 1 -type d -name '*.default-default' -print -quit)
    fi

    if [ "$profile_dir" ]; then
        rm -rf "${profile_dir:?}"
        mkdir "${profile_dir:?}"
        cp -r ./scaffold/shared/librewolf/* "$profile_dir"
    fi
fi


### DOTFILES
# Copies the rest of the dotfiles
shopt -s dotglob
cp -r ./scaffold/shared/dotfiles/* "$HOME"/


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


### OPEN KITTY IN NAUTILUS
glib-compile-schemas ~/.local/share/glib-2.0/schemas/
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty


### VIM
#It makes possible for me to select and CTRL + SHIFT + C to copy in VIM
echo 'autocmd VimEnter * set mouse=' | sudo tee -a /etc/vimrc > /dev/null


### ENVIRONMENT
echo 'FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"' | sudo tee -a /etc/environment > /dev/null
