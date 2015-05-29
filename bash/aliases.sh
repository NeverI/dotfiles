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
# searchable view for big directories
alias lll='ls -alXF --color=never --group-directories-first | less'

alias bdd='haxelib run bdd'

# swearing is sweet:)
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'
alias FUCK='fuck'
