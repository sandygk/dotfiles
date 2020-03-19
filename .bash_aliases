# enable aliases for sudo
alias sudo='sudo '

# refresh bash
alias rb='source ~/.bashrc'
# refresh sxhkd
alias rs='pkill -USR1 -x sxhkd'
# refresh all
alias ra='rb;rs'

# conect to wifi using NetworkManager
# alias cb='nmcli connection up id BLUESSO'
# alias ci='nmcli connection up id Internet'

# conect to wifi using netctl
alias ci='netctl start work-internet'
alias ch='netctl start home'

# change directory
alias gu='cd ..'
alias gh='cd ~'
alias gB='cd - &> /dev/null'
alias gp='cd ~/Desktop/projects'
alias gP='cd ~/Desktop/projects/portal'
alias gg='cd ~/Desktop/projects/graphiti'
alias gl='cd ~/Desktop/projects/lumos'
alias gn='cd ~/Desktop/notes'
alias gt='cd ~/Desktop/temp'
alias gT='cd ~/Desktop/todo'
alias gD='cd ~/Desktop'
alias gd='cd ~/Downloads'
alias gb='cd ~/bin'

# edit files
alias eb='$EDITOR ~/.bashrc'
alias eba='$EDITOR ~/.bash_aliases'
alias ebp='$EDITOR ~/.bash_profile'
alias ex='$EDITOR ~/.xinitrc'
alias et='$EDITOR ~/Desktop/todo/work'
alias eth='$EDITOR ~/Desktop/todo/home'
alias etl='$EDITOR ~/Desktop/todo/linux'
alias ev='$EDITOR ~/.config/nvim/init.vim'
alias er='$EDITOR ~/.config/ranger/rc.conf'
alias es='$EDITOR ~/.config/sxhkd/sxhkdrc'
alias ea='$EDITOR ~/.config/awesome/rc.lua'
alias eat='$EDITOR ~/.config/awesome/theme/theme.lua'
alias eo='$EDITOR ~/bin/open'
alias ee='$EDITOR ~/Desktop/notes/evaluation'
alias ec='$EDITOR ~/Desktop/notes/chores'
alias eT='$EDITOR ~/Desktop/temp/temp'
alias ed='$EDITOR ~/.config/dunst/dunstrc'

# ls
alias ls='ls --color=auto --group-directories-first'
alias la='ls -A'
alias ll='ls -l'

# package management
. package_management_aliases

# applications
alias g='cd'
alias e='$EDITOR'
alias o=open

#misc
alias rm='rm -i'
alias q=exit
alias cl=clear
alias please='sudo "$BASH" -c "$(history -p !!)"'
