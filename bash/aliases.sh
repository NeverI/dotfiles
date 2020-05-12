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

# clear and reload the command history
alias historyReload='history -c; history -r;'

# reload the .Xresource, usefull for urxtv terminal
alias xresourceReload='xrdb ~/.Xresources'

# tmux pane split and window creation clear the transparency...
alias resetbgcolor='printf "$BACKGROUND_COLOR"'

# swearing is sweet:)
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'
alias FUCK='fuck'

alias bdd='haxelib run bdd'

# clipboard
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"
