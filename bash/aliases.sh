# fancy navigation
alias ..='cd ../..'
alias ...='cd ../../..'
alias ....='cd ../../../..'
alias .....='cd ../../../../..'

# grep colors
alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias fgrep='fgrep --color=always'

# ls aliases
alias la='ls -A'
alias l='ls -CF'
alias ll='ls -alXF --color=always --group-directories-first'
alias lll='ll | less'

# some fasd alias
alias v='f -e vim'
alias o='a -e xdg-open'
_fasd_bash_hook_cmd_complete v o

# clear and reload the command history
alias historyReload='history -c; history -r;'

# swearing is sweet:)
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'
alias FUCK='fuck'

alias bdd='haxelib run bdd'
