#!/usr/bin/env fish

abbr -g wm 'sudo wifi-menu'
abbr -g nm 'nmtui'

# conect to wifi using NetworkManager
abbr -g nb 'nmcli connection up id BLUESSO'
abbr -g ni 'nmcli connection up id Internet'

# conect to wifi using netctl
#abbr -g ni 'netctl start work-internet'
#abbr -g nh 'netctl start home'
