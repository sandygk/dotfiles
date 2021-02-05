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

#power manager
mate-power-manager &

# fix screen tearing
picom &

# notifications
dunst &

# flameshot
flameshot &

# screen locker
#xset s on & # enable the screensaver
#xset s 6 & # launch screensaver after 10 mins of inactivity
#xss-lock slock & # start slock as a locker when the screensaver is triggered
#slock & # run locker on start

# sync folders
rclone mount remote: ~/sync &

# start daemon to switch gtk theme on the fly
xfsettingsd &

# set theme
set_theme --light

# Start status bar
status --loop &

# window manager
awesome
