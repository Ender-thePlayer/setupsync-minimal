#set -Ux ELECTRON_OZONE_PLATFORM_HINT wayland

pfetch

# Initialize Starship for Fish
starship init fish | source

# Add a newline flag before each command execution
function fish_user_key_bindings
    # Ensure no newline is added before the prompt starts
    set -g NEW_LINE_AFTER_PROMPT 0
end

# Add the newline flag after command execution
function fish_postexec --on-event fish_postexec
    # Set the flag to add a newline before the next prompt
    set -g NEW_LINE_AFTER_PROMPT 1
end

set -x user $( ps -o user= -p $fish_pid | awk '{print $1}' )
echo $user is thinking.. '"Kasane Teto on top"'

if status is-interactive
    set -g fish_greeting
    set -x PATH $HOME/.local/bin $PATH
    set -x PATH $HOME/.spicetify $PATH
    set -x MOZ_ENABLE_WAYLAND 1
    set -x WLR_NO_HARDWARE_CURSORS 1
    set -x WLR_RENDERER_ALLOW_SOFTWARE 1
#    set -x QT_QPA_PLATFORM xcb

    set -x PATH $HOME/.venv/bin $PATH

    set -x date "$( math $( date +%Y ) +1 )"

    alias $date 'echo "YEAR OF THE DESKTOP"'
    alias 17 'echo "セブンティーナァァァァァ!"'
    alias vencord 'sh -c "(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh | sh)"'
    alias freq 'watch -n.1 "cat /proc/cpuinfo | grep \"^[c]pu MHz\""'
    alias update_grub 'sudo grub2-mkconfig -o /boot/grub2/grub.cfg'
    alias dnf 'dnf5'
    alias sudo 'sudo '
end


#function starship_transient_rprompt_func
# starship module time
#end
#starship init fish | source
#enable_transience

# pnpm
set -gx PNPM_HOME "/home/ender/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
