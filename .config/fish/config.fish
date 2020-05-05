#!/usr/bin/env fish

# set vi key bindings
fish_vi_key_bindings

# set env variables
set -gx EDITOR nvim
set -gx TERMINAL st

# add bin to PATH
set -gx PATH $PATH ~/bin

# abbreviations
for f in ~/.config/fish/abbreviations/*
    source $f
end

# start x
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR"   1
        exec startx -- -keeptty
    end
end
