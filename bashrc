# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Environment
source ~/.config/dotfiles/bash/env.sh

# Bootstrap
source ~/.config/dotfiles/bash/bootstrap.sh

# Settings
source ~/.config/dotfiles/bash/settings.sh

# Aliases
source ~/.config/dotfiles/bash/aliases.sh

# colors
if [ "$TERM" == "xterm" -o "$TERM" == "rxvt-unicode" ]; then
    export TERM=xterm-256color
fi
export BACKGROUND="dark"
export THEME="base16-harmonic16"

# Allow local customizations in the ~/.bashrc_local file
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi

BASE16_SHELL="$HOME/.config/dotfiles/bash/plugins/base16-shell/$THEME.$BACKGROUND.sh"
source $BASE16_SHELL
