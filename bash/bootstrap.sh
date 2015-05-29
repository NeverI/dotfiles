# Enabble grunt.js autocompletion
eval "$(grunt --completion=bash)"

# Only load Liquid Prompt in interactive shells, not from a script or from scp
[[ $- = *i* ]] && source ~/.config/dotfiles/bash/plugins/liquidprompt/liquidprompt

# load z autojump
source ~/.config/dotfiles/bash/plugins/z/z.sh
