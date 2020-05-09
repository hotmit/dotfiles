export BASHRC_LOADED=1

alias ls='ls -h --color=auto'
alias l='ls -la'
export LS_COLORS="${LS_COLORS}:di=1;35"
export PS1="\e[1;33m\w\e[m \e[0;33m$(__git_ps1 '(%s)')\e[m\n\$ "