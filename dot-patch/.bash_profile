if [ -z "${BASHRC_LOADED}" ]; then
    source ~/.bashrc
fi

export PS1="\[\e[1;33m\w\e[m \$(git branch 2>/dev/null | awk '{if (\$2) printf(\"\\033[0;33m(%s)\\033[m\", \$2);}')\n\$ "