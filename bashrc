# If not running interactively, don't do anything
[ -z "$PS1" ] && return

source ~/.config/dotfiles/bash/env.sh
source ~/.config/dotfiles/bash/settings.sh
source ~/.config/dotfiles/bash/aliases.sh
source ~/.config/dotfiles/bash/function.sh

if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
