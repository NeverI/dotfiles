# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Notify of job termination immediately.
set -o notify
# disallow existing regular files to be overwritten by redirection of output.
set -o noclobber

# append to the history file, don't overwrite it
shopt -s histappend
# allow history editing before execute
shopt -s histreedit
# allow history verification before execute
shopt -s histverify
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# try to preserves whitespaces in multiline commands in history
shopt -s cmdhist
shopt -s lithist
# check command hashes in hashtable so can be faster
shopt -s checkhash
# try to correct minor typos
shopt -s cdspell
shopt -s dirspell
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Make page-up and page-down cycle history that maches
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

# Change the tab key to cycle trough completions, and shift-tab for reverse
bind 'TAB: menu-complete'
bind '"\e[Z": "\e-1\C-i"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion

    complete -A directory  mkdir rmdir
    complete -A directory   -o default cd
    complete -f -o default -X '*.+(zip|ZIP)'  zip
    complete -f -o default -X '!*.+(zip|ZIP)' unzip
    complete -f -o default -X '*.+(gz|GZ)'    gzip
    complete -f -o default -X '!*.+(gz|GZ)'   gunzip
    complete -f -o default -X '!*.+(zip|ZIP|z|Z|gz|GZ|bz2|BZ2)' extract

    [ -f ~/.ssh/config ] && complete -W '$(cat ~/.ssh/config | grep ^Host | cut -d " " -f 2)' ssh
    source ~/.config/dotfiles/bash/plugins/git-completion.bash
fi

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
export LESS='-i -w -M -R -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
