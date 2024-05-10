#!/usr/bin/env bash

chmod a+wr "$HOME"/.local/share/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify
chmod a+wr -R "$HOME"/.local/share/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/Apps
wget -O - https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
"$HOME"/.spicetify/spicetify -c
"$HOME"/.spicetify/spicetify backup

sed -i "s|^spotify_path\s*=\s*.*|spotify_path=$HOME/.local/share/flatpak/app/com.spotify.Client/current/active/files/extra/share/spotify|" "$HOME/.config/spicetify/config-xpui.ini"
sed -i "s|^prefs_path\s*=\s*.*|prefs_path=$HOME/.config/spicetify/config-xpui.ini|" "$HOME/.config/spicetify/config-xpui.ini"
"$HOME"/.spicetify/spicetify backup apply

wget -O - https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh
"$HOME"/.spicetify/spicetify config custom_apps lyrics-plus
"$HOME"/.spicetify/spicetify config custom_apps marketplace
"$HOME"/.spicetify/spicetify apply

rm ./install.log

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

pip3 install python-dotenv --break-system-packages
pip3 install spotify_dl --break-system-packages
pip3 install yt-dlp --break-system-packages