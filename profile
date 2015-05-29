# set PATH so it includes dotfiles bin's if it exists
if [ -d ~/.config/dotfiles/bin ] ; then
    PATH="$HOME/.config/dotfiles/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
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
