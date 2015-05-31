export EDITOR=/usr/bin/vim
export GIT_EDITOR=/usr/bin/vim

# share the history among sessions
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# enable colors for hstr
# promising history search app (https://github.com/dvorka/hstr)
export HH_CONFIG=hicolor
