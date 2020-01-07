# If not running interactively, don't do anything
[ -z "$PS1" ] && return

source ~/.config/dotfiles/bash/env.sh
source ~/.config/dotfiles/bash/bootstrap.sh
source ~/.config/dotfiles/bash/settings.sh
source ~/.config/dotfiles/bash/aliases.sh
source ~/.config/dotfiles/bash/function.sh


# colors
if [ "$TERM" == "xterm" -o "$TERM" == "rxvt-unicode" ]; then
    export TERM=xterm-256color
fi

export BACKGROUND="dark"
export THEME="base16-eighties"
# change the background to transparent
export BACKGROUND_COLOR="\033]11;rgba:2d00/2d00/2d00/e5e5\033\\"

# Allow local customizations in the ~/.bashrc_local file
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi

BASE16_SHELL="$HOME/.config/dotfiles/bash/plugins/base16-shell/$THEME.$BACKGROUND.sh"
source $BASE16_SHELL

printf $BACKGROUND_COLOR
