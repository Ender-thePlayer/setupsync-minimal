export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:$HOME/.spicetify

export MOZ_ENABLE_WAYLAND=1
export WLR_NO_HARDWARE_CURSORS=1
export WLR_RENDERER_ALLOW_SOFTWARE=1
export QT_QPA_PLATFORM=xcb


function sb {
	sudo sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI
	sudo sbctl sign -s /boot/EFI/systemd/systemd-bootx64.efi
	sudo sbctl sign -s /boot/vmlinuz-linux
	sudo sbctl sign -s /boot/vmlinuz-linux-lts
	sudo sbctl sign -s /boot/vmlinuz-linux-zen
}

function frepair { 
	sudo systemctl restart python3-validity.service
	sudo systemctl restart python3-validity-wakeup.service
}

function func_spicetifyfix {
	chmod a+wr "$HOME"/.local/share/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify
	chmod a+wr -R "$HOME"/.local/share/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/Apps
	spicetify update
	"$HOME"/.spicetify/spicetify backup
}

alias 2024='echo "YEAR OF THE DESKTOP"'
alias 17='echo "セブンティーナァァァァァ!"'
alias vencord='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'
alias freq='watch -n.1 "cat /proc/cpuinfo | grep \"^[c]pu MHz\""'
alias update_grub="grub2-mkconfig -o /boot/grub2/grub.cfg"
alias spicetifyfix=func_spicetifyfix
alias dnf="dnf5"
alias sudo="sudo "


#if [ -d "$HOME/adb/platform-tools" ] ; then
#	export PATH="$HOME/adb/platform-tools:$PATH"
#fi


ZSH_THEME="powerlevel9k/powerlevel9k"
plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh
export PATH=$PATH:/home/ender/.spicetify