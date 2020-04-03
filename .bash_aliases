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

alias gb='cd ~/bin'
alias gd='cd ~/downloads'
alias gn='cd ~/notes'
alias gr='cd ~/repos'
alias gt='cd ~/temp'
alias gT='cd ~/todo'

alias gp='cd ~/repos/portal'
alias gg='cd ~/repos/graphiti'
alias gl='cd ~/repos/lumos'

# edit files
alias eb=' $EDITOR ~/.bashrc'
alias eba='$EDITOR ~/.bash_aliases'
alias ebp='$EDITOR ~/.bash_profile'
alias ex=' $EDITOR ~/.xinitrc'

alias ev=' $EDITOR ~/.config/nvim/init.vim'
alias er=' $EDITOR ~/.config/ranger/rc.conf'
alias es=' $EDITOR ~/.config/sxhkd/sxhkdrc'
alias ea=' $EDITOR ~/.config/awesome/rc.lua'
alias eat='$EDITOR ~/.config/awesome/theme/theme.lua'
alias ed=' $EDITOR ~/.config/dunst/dunstrc'

alias eo=' $EDITOR ~/bin/open'

alias et=' $EDITOR ~/todo/work'
alias eth='$EDITOR ~/todo/home'
alias etl='$EDITOR ~/todo/linux'

alias ee=' $EDITOR ~/notes/evaluation'
alias ec=' $EDITOR ~/notes/chores'

# ls
alias ls='ls --color=auto --group-directories-first'
alias la='ls -A'
alias ll='ls -l'

# spell
alias sp="fzf < /usr/share/dict/words | xclip -selection clipboard"

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
kill-port() {
  fuser -k $1/tcp
}
alias prettier='prettier --write "**/*.ts"'
alias apollo='npm run apollo:generate'
