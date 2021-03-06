if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

export EDITOR=nvim
export GIT_EDITOR=nvim

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

export HISTIGNORE='hstr *:history*:&:man *:[ ]*:exit'
export HISTSIZE=1000
export HISTFILESIZE=5000

# immediatly flush the commands to the history, so other session can access to it
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# enable colors for hstr
# promising history search app (https://github.com/dvorka/hstr)
export HSTR_CONFIG=hicolor,keywords,rawhistory

export RANGER_LOAD_DEFAULT_RC=FALSE

# use less as the default pager
export PAGER=less
# colorized man page
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
# usefull less settings
export LESSCHARSET='utf-8'
export LESS='-cwMR -j4 -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f ~/.ssh/agent.env ] ; then
    . ~/.ssh/agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        echo "Stale agent file found. Spawning new agent… "
        eval `ssh-agent | tee ~/.ssh/agent.env`
        ssh-add
    fi
else
    echo "Starting ssh-agent"
    eval `ssh-agent | tee ~/.ssh/agent.env`
    ssh-add
fi
