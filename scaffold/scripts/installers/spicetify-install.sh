#!/usr/bin/env bash

### SPICETIFY INSTALL
# It chmods the spotify folder of the flatpak install
# to allow spicetify to successfully install itself
chmod a+wr "$HOME"/.local/share/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify
chmod a+wr -R "$HOME"/.local/share/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/Apps

mkdir -p ./tmp
wget -O - https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | tee ./tmp/install.sh
chmod +x ./tmp/install.sh

cat << 'EOF' > ./tmp/install_spicetify.exp
#!/usr/bin/expect

spawn ./tmp/install.sh
expect "Do you want to install spicetify Marketplace? (Y/n)"
send "Y\r"
interact
EOF

chmod +x ./tmp/install_spicetify.exp
./tmp/install_spicetify.exp

"$HOME"/.spicetify/spicetify -c
"$HOME"/.spicetify/spicetify backup

sed -i "s|^spotify_path\s*=\s*.*|spotify_path=$HOME/.local/share/flatpak/app/com.spotify.Client/current/active/files/extra/share/spotify|" "$HOME/.config/spicetify/config-xpui.ini"
sed -i "s|^prefs_path\s*=\s*.*|prefs_path=$HOME/.config/spicetify/config-xpui.ini|" "$HOME/.config/spicetify/config-xpui.ini"
"$HOME"/.spicetify/spicetify backup apply

wget -O - https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh
"$HOME"/.spicetify/spicetify config custom_apps lyrics-plus
"$HOME"/.spicetify/spicetify config custom_apps marketplace
"$HOME"/.spicetify/spicetify apply

rm ./tmp
rm ./install.log