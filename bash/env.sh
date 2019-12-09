export EDITOR=/usr/bin/nvim
export GIT_EDITOR=/usr/bin/nvim

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

HISTIGNORE='hh *:history*:&:man *:[ ]*:exit'
HISTSIZE=1000
HISTFILESIZE=2000

# immediatly flush the commands to the history, so other session can access to it
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# enable colors for hstr
# promising history search app (https://github.com/dvorka/hstr)
export HH_CONFIG=hicolor,keywords,rawhistory
