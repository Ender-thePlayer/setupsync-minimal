if status is-interactive
    set -g fish_greeting
    set -x PATH $HOME/.local/bin $PATH
    set -x PATH $HOME/.spicetify $PATH
    set -x MOZ_ENABLE_WAYLAND 1
    set -x WLR_NO_HARDWARE_CURSORS 1
    set -x WLR_RENDERER_ALLOW_SOFTWARE 1
    set -x QT_QPA_PLATFORM xcb

    function sb
    	sudo sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI
    	sudo sbctl sign -s /boot/EFI/systemd/systemd-bootx64.efi
    	sudo sbctl sign -s /boot/vmlinuz-linux
    	sudo sbctl sign -s /boot/vmlinuz-linux-lts
    	sudo sbctl sign -s /boot/vmlinuz-linux-zen
    end

    function frepair
        sudo systemctl restart python3-validity.service
        sudo systemctl restart python3-validity-wakeup.service
    end

    function spicetifyfix
        chmod a+wr $HOME/.local/share/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify
        chmod a+wr -R $HOME/.local/share/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/Apps
        spicetify update
        $HOME/.spicetify/spicetify backup
    end

    alias 2024 'echo "YEAR OF THE DESKTOP"'
    alias 17 'echo "セブンティーナァァァァァ!"'
    alias vencord 'sh -c "(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh | sh)"'
    alias freq 'watch -n.1 "cat /proc/cpuinfo | grep \"^[c]pu MHz\""'
    alias update_grub 'sudo grub2-mkconfig -o /boot/grub2/grub.cfg'
    alias dnf 'dnf5'
    alias sudo 'sudo '

end
