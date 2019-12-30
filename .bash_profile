#!/bin/bash

# set PATH so it includes user's private bin if it exists
PATH="$HOME/bin:$PATH"

# include .bashrc if it exists
. "$HOME/.bashrc"

# define $XDG_CONFIG_HOME
export XDG_CONFIG_HOME="$HOME/.config"

# Extend GTK theme to Qt
export QT_QPA_PLATFORMTHEME=gtk2

# start x
exec startx 
