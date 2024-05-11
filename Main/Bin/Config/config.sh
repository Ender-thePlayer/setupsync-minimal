#!/usr/bin/env bash

# shellcheck source=/dev/null
source functions.sh

### THEMING
# Gets the GTK3 theme and puts it in the right folder
wget "$( curl -s https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest | grep browser_download_url | cut -d '"' -f 4 )"
mkdir ~/.local/share/themes/
tar -xf ./adw-gtk3* -C ~/.local/share/themes/
rm ./adw-gtk3*
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'



### EXTENSIONS
# This searches the extensions via the uuid,
# downloads them as a zip file and unzips
# them into the extensions dir
uuid=(
    "AlphabeticalAppGrid@stuarthayhurst" \
    "appindicatorsupport@rgcjonas.gmail.com" \
    "blur-my-shell@aunetx" \
    "clipboard-indicator@tudmotu.com" \
    "dash-to-dock@micxgx.gmail.com" \
    "freon@UshakovVasilii_Github.yahoo.com" \
    "gsconnect@andyholmes.github.io"\
    "just-perfection-desktop@just-perfection" \
    "lockkeys@vaina.lt"
)

gsettings set org.gnome.shell disable-extension-version-validation true

shell_version=$(gnome-shell --version | cut -d' ' -f3)

for uuid_item in "${uuid[@]}"; do
    info_json=$(curl -sS "https://extensions.gnome.org/extension-info/?uuid=$uuid_item&shell_version=$shell_version")
    download_url=$(echo "$info_json" | jq -Rnr '[inputs] | join("\\n") | fromjson | .download_url')
    curl -sL "https://extensions.gnome.org$download_url" -o "$uuid_item.zip"
    mkdir -p "$HOME/.local/share/gnome-shell/extensions/$uuid_item"
    unzip "$uuid_item.zip" -d "$HOME/.local/share/gnome-shell/extensions/$uuid_item"
    rm "$uuid_item.zip"
done

dconf load /org/gnome/shell/extensions/ < ./Main/Lib/Config/extensions46.dconf



### SHORTCUTS
# This loads the default shortcuts for openning
# the terminal and taking screenshots.
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ./Main/Lib/Config/terminal-shortcut.dconf
dconf load /org/gnome/shell/keybindings/ < ./Main/Lib/Config/screenshot-shortcut.dconf



### KVM
# It configures the 3 KVMs that I have
if ! test -f ./Main/Share/Config/tmp; then
    mkdir ./Main/Share/Config/tmp
fi

tar -xvaf ./Main/Share/Config/kvms/KVMs.tar.zst -C ./Main/Share/Config/tmp
sudo cp ./Main/Share/Config/tmp/kvms/archlinux.qcow2 /var/lib/libvirt/images/
sudo cp "./Main/Share/Config/tmp/kvms/debian12-1.qcow2" /var/lib/libvirt/images/
sudo cp "./Main/Share/Config/tmp/kvms/fedora.qcow2" /var/lib/libvirt/images/

sudo virsh define "./Main/Share/Config/kvms/debian.xml"
sudo virsh define "./Main/Share/Config/kvms/fedora.xml"
sudo virsh define "./Main/Share/Config/kvms/arch.xml"

rm -r ./Main/Share/Config/tmp
sudo virsh net-start default
sudo virsh net-autostart default



### ENVIRONMENT
# It modifies some env variables for arch
if [ "$( distro )" = "arch" ]; then
    echo -e 'MOZC_IBUS_CANDIDATE_WINDOW=ibus' | sudo tee -a /etc/environment
    echo -e 'QT_STYLE_OVERRIDE=breeze' | sudo tee -a /etc/environment
    echo -e 'EDITOR=gnome-text-editor' | sudo tee -a /etc/environment
    xdg-mime default org.gnome.TextEditor.desktop text/plain inode/directory  
fi



### FONTS
#　It sets the default font for japanese on arch btw and debian
if [ "$( distro )" = "arch" ] || [ "$( distro )" = "debian" ]; then
    sudo sed -i '/<family>serif<\/family>/,/<\/prefer>/ s/<\/prefer>/\t\t<family>Noto Sans CJK JP<\/family>\n&/' /etc/fonts/conf.d/65-nonlatin.conf
    sudo sed -i '/<family>monospace<\/family>/,/<\/prefer>/ s/<\/prefer>/\t\t<family>Noto Sans CJK JP<\/family>\n&/'  /etc/fonts/conf.d/65-nonlatin.conf
    fc-cache -f -r
fi



### VIM
#　It makes possible for me to select and CTRL + SHIFT + C to copy in VIM
if [ "$( distro )" = "arch" ]; then
    echo 'autocmd VimEnter * set mouse=' | sudo tee -a /etc/vimrc
fi



### BOOTING
# It maybe fixes the TrackPoint® on linux
# sudo sed -i 's/ quiet/ quiet psmouse.synaptics_intertouch=1/' /etc/default/grub
# sudo grub2-mkconfig -o /boot/grub2/grub.cfg