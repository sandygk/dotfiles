#!/bin/bash

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

# define $XDG_CONFIG_HOME
export XDG_CONFIG_HOME="$HOME/.config"

# Extend GTK theme to Qt
export QT_QPA_PLATFORMTHEME=gtk2

# start x
exec startx 
