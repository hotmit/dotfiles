# dotfiles


# Init Bash
```
bash <(curl -s https://raw.githubusercontent.com/hotmit/dotfiles/master/bash-init.sh)
  OR
curl -s https://raw.githubusercontent.com/hotmit/dotfiles/master/bash-init.sh | bash
  OR
wget -O - https://raw.githubusercontent.com/hotmit/dotfiles/master/bash-init.sh | bash
```


# Git Prompt
```bash
export PS1="\[\e[1;33m\w\e[m \$(git branch 2>/dev/null | awk '{if (\$2) printf(\"\\033[0;33m(%s)\\033[m\", \$2);}')\n\$ "
```
