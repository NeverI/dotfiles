if [[ :$PATH: != *:"/sbin":* ]] ; then
  PATH="$PATH:/sbin/"
fi

if [[ :$PATH: != *:"/usr/sbin":* ]] ; then
  PATH="$PATH:/usr/sbin/"
fi

if [[ :$PATH: != *:"/usr/local/sbin":* ]] ; then
  PATH="$PATH:/usr/local/sbin"
fi

# set PATH so it includes dotfiles bin's if it exists
if [ -d ~/.config/dotfiles/bin ] && [[ :$PATH: != *:"$HOME/.config/dotfiles/bin":* ]] ; then
    PATH="$HOME/.config/dotfiles/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] && [[ :$PATH: != *:"$HOME/bin":* ]] ; then
    PATH="$HOME/bin:$PATH"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
   # include .bashrc if it exists
    if [ -f ~/.bashrc ]; then
	    source ~/.bashrc
   fi
fi

# Allow local customization in the ~/.profile_local file
if [ -f ~/.profile_local ] ; then
    source ~/.profile_local
fi
