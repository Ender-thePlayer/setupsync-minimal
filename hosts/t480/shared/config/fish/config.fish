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

set -x user_v ( ps -o user= -p $fish_pid | awk '{print $1}' )
set -x rand_v (shuf -i 1-100 -n 1)
set -x val_v (math $rand_v % 2)

if test $val_v -eq 0
    echo $user_v is singing.. '"kimi no hitomi no naka no garasu ni wa"'
else
    echo $user_v is singing.. '"君の瞳の中のガラスには"'
end

if status is-interactive
    set -g fish_greeting
    set -x PATH $HOME/.local/bin $PATH
    #set -x WLR_NO_HARDWARE_CURSORS 1

    set -x PATH $HOME/.venv/bin $PATH
    set -x date "$( math $( date +%Y ) +1 )"

    alias $date 'echo "YEAR OF THE DESKTOP"'
    alias 17 'echo "セブンティーナァァァァァ!"'
    alias freq 'watch -n.1 "cat /proc/cpuinfo | grep \"^[c]pu MHz\""'
    alias rm 'rm -I'
end


#function starship_transient_rprompt_func
# starship module time
#end
#starship init fish | source
#enable_transience

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
