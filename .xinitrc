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
xset s on & # enable the screensaver
xset s 600 & # launch screensaver after 10 mins of inactivity
xss-lock slock & # start slock as a locker when the screensaver is triggered 
slock & # run locker on start

# sync folders
rclone mount remote:notes ~/notes &

# window manager 
awesome
