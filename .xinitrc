#!/bin/bash

# source the scripts in /etc/X11/xinit/xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

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

# start daemon to switch gtk theme on the fly
xfsettingsd &

# set theme
set_theme --light

# Start status bar
status --loop &

# set key repeat rate: first delay 280 milisecond, then 40 per sec
xset r rate 280 40 &

# map the Compose key to right alt
setxkbmap -option compose:ralt &

# window manager
#Prepending exec will replace the script process with the window manager process,
#so that X does not exit even if this process forks to the background.
exec awesome
#exec bspwm
