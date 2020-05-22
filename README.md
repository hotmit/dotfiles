# dotfiles

## Shell Bootstrap Script
```sh
wget -q -O - https://raw.githubusercontent.com/hotmit/dotfiles/master/sh-init.sh | sh

# git.io shortener (alias of the above)
sudo yum install wget -y
wget -q -O - https://git.io/JfCjW | sh
```

## Requirements
* Only wget (smaller than curl)
* Only use sh (more compatible)

## Git Prompt
* [New line bug](https://stackoverflow.com/questions/21517281/ps1-command-substitution-fails-when-containing-newlines-on-msys-bash)
```sh
Bug where bash can't have \n after $() function,
    Solution: use single quote:
        export PS1='\[\e[32m\]\w\[\e[m\]\[\e[0;33m\]$(git_branch)\[\e[m\]'$'\n\[\e[33m\]# \[\e[m\]'
        $'\n' will convert to new line
```

## Color
* [Color](http://bashrcgenerator.com/)

## Unicode Icons
* [Find Unicode Icons](http://shapecatcher.com/index.html)
* [Unicode Table](https://unicode-table.com/en/)
```sh
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

## Util Requirements
```sh
wget - get content
sed - replace old content
grep - search if content exist
```
