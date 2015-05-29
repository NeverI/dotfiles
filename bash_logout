# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# Allow local customizations in the ~/.bash_logout_local file
if [ -f ~/.bashrc_logout_local ]; then
    source ~/.bashrc_logout_local
fi
