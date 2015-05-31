export EDITOR=/usr/bin/vim
export GIT_EDITOR=/usr/bin/vim

# share the history among sessions
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
