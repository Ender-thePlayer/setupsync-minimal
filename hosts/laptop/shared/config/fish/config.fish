
#pfetch
#starship init fish | source

#set -x user $( ps -o user= -p $fish_pid | awk '{print $1}' )
#echo $user is thinking.. '"Kasane Teto on top"'

if status is-interactive
    pfetch
    starship init fish | source
    
    set -x user $( ps -o user= -p $fish_pid | awk '{print $1}' )
    echo $user is thinking.. '"Kasane Teto on top"'
    
    set -g fish_greeting
    set -x PATH $HOME/.local/bin $PATH

    set -x PATH $PATH $HOME/.venv/bin
    set -x date "$( math $( date +%Y ) +1 )"
    set -x VISUAL vim

    alias rm 'rm -I'
    alias gte 'gnome-text-editor'
end

set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
