#!/bin/bash

# key bindings
sxhkd -t 10 &
auto_restart_sxhkd &

# activate numlock
numlockx &

# hide mouse if inactive
unclutter &

# automount usb
udiskie &

# fix screen tearing
picom &

# notifications
dunst &

# flameshot
flameshot &

# start daemon to switch gtk theme on the fly and set theme
xfsettingsd && set_theme --ligh &

# Start status bar
status --loop &

# set key repeat rate: first delay 280 milisecond, then 40 per sec
xset r rate 280 40 &

# map the Compose key to right alt
setxkbmap -option compose:ralt &

# mount drives
mount-drive &

# window manager
awesome
