#!/bin/bash

# key bindings
sxhkd -t 10 &

# activate numlock
numlockx &

# hide mouse if inactive
unclutter &

# automount usb
udiskie &

# picom
picom &

# screen locker
xset s on &
xset s 600 &
xss-lock locker &
locker &

# window manager 
awesome