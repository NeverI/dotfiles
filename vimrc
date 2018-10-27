" i don't need vi :)
set nocompatible

" separate plugin definitions
let $PLUGINFILE=expand("~/.config/dotfiles/vim/pluginrc.vim")
if filereadable($PLUGINFILE)
    source $PLUGINFILE
endif

let $CONFIGFILE=expand("~/.config/dotfiles/vim/config.vim")
if filereadable($CONFIGFILE)
    source $CONFIGFILE
endif
