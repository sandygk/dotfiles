#!/usr/bin/env fish

# x
abbr -g exc '$EDITOR ~/.xinitrc'

# kakoune
abbr -g ekc '$EDITOR ~/.config/kak/kakrc'

# fish
abbr -g efc  '$EDITOR ~/.config/fish/config.fish'
abbr -g efp  '$EDITOR ~/.config/fish/functions/fish_prompt.fish'
abbr -g efmp  '$EDITOR ~/.config/fish/functions/fish_mode_prompt.fish'
abbr -g efaf '$EDITOR ~/.config/fish/abbreviations/files.fish'
abbr -g efad '$EDITOR ~/.config/fish/abbreviations/directories.fish'
abbr -g efa  'edit_file_in_dir ~/.config/fish/abbreviations'
abbr -g eff 'edit_file_in_dir ~/.config/fish/functions'

# bash
abbr -g ebc '$EDITOR ~/.bashrc'
abbr -g eba '$EDITOR ~/.bash_aliases'
abbr -g ebp '$EDITOR ~/.bash_profile'
abbr -g ebs 'edit_file_in_dir ~/bin'

# configs
abbr -g erc '$EDITOR ~/.config/ranger/rc.conf'
abbr -g esc '$EDITOR ~/.config/sxhkd/sxhkdrc'
abbr -g eac '$EDITOR ~/.config/awesome/rc.lua'
abbr -g eat '$EDITOR ~/.config/awesome/theme/theme.lua'
abbr -g edc '$EDITOR ~/.config/dunst/dunstrc'

# vim
abbr -g evi '$EDITOR ~/.config/nvim/init.vim'
abbr -g evr '$EDITOR ~/.config/nvim/regular.vim'
abbr -g evc '$EDITOR ~/.config/nvim/coc.vim'
abbr -g evp '$EDITOR ~/.config/nvim/plugins.vim'

# scripts
abbr -g eb 'edit_file_in_dir ~/bin'

# notes
abbr -g ewt '$EDITOR ~/todos/work'
abbr -g ept '$EDITOR ~/todos/personal'
abbr -g ebl '$EDITOR ~/todos/backlog'
abbr -g esa '$EDITOR ~/notes/ge/std-agenda'
abbr -g ed1 '$EDITOR ~/notes/ge/dave-1-on-1'
abbr -g ed '$EDITOR ~/notes/ge/demo'
abbr -g er '$EDITOR ~/notes/ge/retro'
