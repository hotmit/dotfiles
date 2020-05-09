alias ls='ls -h --color=auto'

export BASHRC_LOADED=1
LS_COLORS=$LS_COLORS:'di=1;35:' ; export LS_COLORS

export PS1="\e[1;33m\w\e[m \$(git branch 2>/dev/null | awk '{if (\$2) printf(\"\\033[0;33m(%s)\\033[m\", \$2);}')\n\$ "