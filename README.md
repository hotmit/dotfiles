# dotfiles

## Requirements
* Only wget (smaller than curl)
* Only use sh (more compatible)


# Init
```
wget -q -O - https://raw.githubusercontent.com/hotmit/dotfiles/master/sh-init.sh | sh
```


# Git Prompt
```bash
export PS1="\e[1;33m\w\e[m \e[0;33m$(__git_ps1 '(%s)')\e[m\n\$ "

__git_ps1($format_str)      # usage: __git_ps1 '+(%s)' => '+(master)'

# older than git v1.9.3
export PS1="\e[1;33m\w\e[m \$(git branch 2>/dev/null | awk '{if (\$2) printf(\"\\033[0;33m(%s)\\033[m\", \$2);}')\n\$ "
```

# Color
[Color](http://bashrcgenerator.com/)


# Unicode Icons
[Find Unicode Icons](http://shapecatcher.com/index.html)
[Unicode Table](https://unicode-table.com/en/)
```
$ printf ☠ | hexdump
0000000 98e2 00a0
0000003

# the bit is swaped cuz of endian (98e2 00a0 => e298, a000)
$ printf '\xE2\x98\xA0'
☠

☸ = 98e2 00b8 = \xE2\x98\xB8
icon=$(printf "\xE2\x9D\x8B")
export PS1="\e[1;35m${icon}\u\e[m \e[1;32m\w\e[m\e[0;33m$(__git_ps1 '(%s)')\e[m\n\$ "

⌛⏰❌
```

# Requirement
```
wget - get content
sed - replace old content
grep - search if content exist
```