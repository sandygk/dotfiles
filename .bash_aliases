# refresh bash
alias rb='source ~/.bashrc'

# refresh sxhkd
alias rs="pkill -USR1 -x sxhkd"

# change directory
alias gu='cd ..'
alias gh='cd ~'
alias gp='cd ~/Desktop/projects'
alias gP='cd ~/Desktop/projects/portal'
alias gg='cd ~/Desktop/projects/graphiti'
alias gl='cd ~/Desktop/projects/lumos'
alias gn='cd ~/Desktop/notes'
alias gt='cd ~/Desktop/temp'
alias gT='cd ~/Desktop/to-do'
alias gd='cd ~/Desktop'
alias gD='cd ~/Downloads'
alias gb='cd ~/bin'

# edit files
alias eb='$EDITOR ~/.bashrc'
alias eba='$EDITOR ~/.bash_aliases'
alias ebp='$EDITOR ~/.bash_profile'
alias ex='$EDITOR ~/.xinitrc'
alias et='$EDITOR ~/Desktop/to-do/today'
alias etp='$EDITOR ~/Desktop/to-do/portal'
alias etw='$EDITOR ~/Desktop/to-do/woof'
alias etl='$EDITOR ~/Desktop/to-do/lumos'
alias ev='$EDITOR ~/.config/nvim/init.vim'
alias er='$EDITOR ~/.config/ranger/rc.conf'
alias es='$EDITOR ~/.config/sxhkd/sxhkdrc'
alias ea='$EDITOR ~/.config/awesome/rc.lua'
alias eat='$EDITOR ~/.config/awesome/themes/custom/theme.lua'

# ls
alias ls='ls --color=auto --group-directories-first'
alias la='ls -A'

# package management
. package_management_aliases

# applications
alias e='$EDITOR'
alias r='ranger'

#misc
alias q=exit
alias cl=clear
alias please='sudo !!'
alias fuck='sudo !!'
