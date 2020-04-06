#!/bin/bash

# key bindings
sxhkd -t 10 &

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

# screen locker
xset s on &
xset s 600 &
xss-lock locker &
locker &

# sync folders
rclone mount remote:notes ~/notes &

# window manager 
awesome
