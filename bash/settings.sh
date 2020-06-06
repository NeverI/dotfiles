# reverse-i-search changed to hstr
bind '"\C-r": "\e^ihh \n"'

setxkbmap -option caps:backspace
setxkbmap -option ctrl:menu_rctrl

# Notify of job termination immediately.
set -o notify
# disallow existing regular files to be overwritten by redirection of output.
set -o noclobber

# append to the history file, don't overwrite it
shopt -s histappend
# allow history editing before execute
shopt -s histreedit
# allow history verification before execute (helpful for !, !!, !?)
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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion

    complete -o default rm
    complete -A directory  mkdir rmdir
    complete -A directory  -o default cd
    complete -f -o default -X '*.+(zip|ZIP)'  zip
    complete -f -o default -X '!*.+(zip|ZIP)' unzip
    complete -f -o default -X '*.+(gz|GZ)'    gzip
    complete -f -o default -X '!*.+(gz|GZ)'   gunzip
    complete -f -o default -X '!*.+(zip|ZIP|z|Z|gz|GZ|bz2|BZ2)' extract

    source ~/.config/dotfiles/bash/plugins/pip-completion.bash
    source ~/.config/dotfiles/bash/plugins/ssh-completion.bash
    source ~/.config/dotfiles/bash/plugins/git-completion.bash
fi

if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash
  _fzf_setup_completion path coffee node
fi

# Only load Liquid Prompt in interactive shells, not from a script or from scp
[[ $- = *i* ]] && source ~/.config/dotfiles/bash/plugins/liquidprompt/liquidprompt
