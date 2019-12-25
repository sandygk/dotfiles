#!/usr/bin/env bash

# key bindings
sxhkd -t 10 &

# activate numlock
numlockx &

# hide mouse if inactive
unclutter &

# automount usb
udiskie &

# screen locker
xss-lock locker &
locker &

# picom
picom &

# start awesome
awesome
