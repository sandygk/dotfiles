#!/usr/bin/env fish

# add bin to PATH
set -x PATH $PATH ~/bin

# abbreviations and aliases
for f in ~/.config/fish/abbreviations/*
  source $f
end

# set env variables
set -x EDITOR nvim
set -x TERM alacritty

# less colors
set -x LESS_TERMCAP_mb (printf "\033[01;32m")
set -x LESS_TERMCAP_md (printf "\033[01;32m")
set -x LESS_TERMCAP_me (printf "\033[0m")
set -x LESS_TERMCAP_se (printf "\033[0m")
set -x LESS_TERMCAP_so (printf "\033[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\033[0m")
set -x LESS_TERMCAP_us (printf "\033[01;31m")

# fzf
set -x FZF_DEFAULT_OPTS '--reverse --info=inline'

# start x
if status is-login
    exec startx -- -keeptty
end
