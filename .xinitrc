#!/usr/bin/env bash

#require to run gnome-terminal
dbus-update-activation-environment --all

# key bindings
sxhkd -t 10 &

# activate numlock
numlockx &

# hide mouse if inactive
unclutter &

# picom
picom &

# automount usb
udiskie &

# start awesome
awesome
