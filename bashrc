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

# Allow local customizations in the ~/.bashrc_local file
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
