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

function findInWorkbench() {
  esc=$(printf '\033');
  day=${2:-*};
  [[ $day = "today" ]] && day=`date +%Y-%m-%d`;
  fgrep -i $1 ~/.mysql/workbench/sql_history/$day | sed "s/\(.\+\([0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\)\)\?.\+timestamp='\([0-9:~\.]\+\)'>\(.\+\)<\/ENTRY>/${esc}[0;35m\2 \3${esc}[0m \4/" | sed "s/&#x0A;/ /g;s/&apos;/'/g;s/&lt;/</g;s/&gt;/>/g;s/\s\s\+/ /g";
}

function manSymfony() {
  env=${1:-dev}
  commandName=`app/console --env=$env | fzf --preview 'script -efq -c "app/console --env='$env' --help \`echo {} | sed \"s/^ \+\([^ ]\+\) .\+$/\1/\"\`"' | sed 's/^ \+\([^ ]\+\) .\+$/\1/'`
  echo -n "app/console $commandName --env=$env " | xclip -sel clip
  app/console --env="$env" "$commandName" --help
}

function runSymfony() {
  app/console "$@" `app/console | fzf | sed 's/^ \+\([^ ]\+\) .\+$/\1/'`
}
