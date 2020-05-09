#!/usr/bin/env fish

# add bin to PATH
set -gx PATH $PATH ~/bin

# abbreviations
for f in ~/.config/fish/abbreviations/*
    source $f
end

# set env variables
set -gx EDITOR nvim
set -gx TERMINAL st

# set vi key bindings
#fish_vi_key_bindings

# cursor
set -gx fish_cursor_insert line
set -gx fish_cursor_default block
set -gx fish_cursor_visual block

# less colors
set -gx LESS_TERMCAP_mb (printf "\033[01;32m")
set -gx LESS_TERMCAP_md (printf "\033[01;32m")
set -gx LESS_TERMCAP_me (printf "\033[0m")
set -gx LESS_TERMCAP_se (printf "\033[0m")
set -gx LESS_TERMCAP_so (printf "\033[01;44;33m")
set -gx LESS_TERMCAP_ue (printf "\033[0m")
set -gx LESS_TERMCAP_us (printf "\033[01;31m")

# fzf
set -gx FZF_DEFAULT_OPTS '--height=50% --reverse --info=inline'

# start x
if status is-login
    exec startx -- -keeptty
end
