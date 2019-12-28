#!/bin/bash

# key bindings
sxhkd -t 10 &

# activate numlock
numlockx &

# hide mouse if inactive
unclutter &

# automount usb
udiskie &

# screen locker
xset s on &
xset s 600 &
xss-lock locker &

# start awesome
awesome
