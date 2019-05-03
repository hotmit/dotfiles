#!/bin/sh
# Print coloured Text
#   cprintln($colour, $text)
#       $colour: 0;30-black, 0;34-blue, 0;32-green, 0;36-cyan, 0;31-red, 0;35-purple, 0;33-brown, 0;37-light gray
#               1;30-dark gray, 1;34-light blue, 1;32-light green, 1;36-light cyan, 1;31-light red, 1;35-light purple, 1;33-yellow, 1;37-white
function cprintln()
{
    local colour=$1
    local text=$2
    local no_newline=$3

    printf "\e[${colour}m${text}\e[m"

    if [ -z "${no_newline}" ]; then
        printf "\n"
    fi
}

# Print coloured Text without the line feed
#   cprintln($colour, $text)
#       $colour: 0;30-black, 0;34-blue, 0;32-green, 0;36-cyan, 0;31-red, 0;35-purple, 0;33-brown, 0;37-light gray
#               1;30-dark gray, 1;34-light blue, 1;32-light green, 1;36-light cyan, 1;31-light red, 1;35-light purple, 1;33-yellow, 1;37-white
function cprint()
{
    cprintln "$1" "$2" 1
}

# Print green text on screen
#   print_msg($text)
function print_msg()
{
    cprintln "1;32" "$1"
}

# Print red text on screen
#   print_error($text)
function print_error()
{
    cprintln "0;31" "$1"
}

function has_key
{
    local file=$1
    local key=$2

    if [ -f "${file}" ]; then
        if ! grep -q "${key}" "${file}"; then
            return 1
        fi
    fi
    return 0
}

if ! has_key "${HOME}/.vimrc" "DarkGreen"; then
    wget -O - https://raw.githubusercontent.com/hotmit/dotfiles/master/.vimrc >> "${HOME}/.vimrc"
fi

if ! has_key "${HOME}/.bash_profile" "BASHRC_LOADED"; then
    wget -O - https://raw.githubusercontent.com/hotmit/dotfiles/master/.bash_profile >> "${HOME}/.bash_profile"
fi

if ! has_key "${HOME}/.bashrc" "git branch 2"; then
    wget -O - https://raw.githubusercontent.com/hotmit/dotfiles/master/.bashrc >> "${HOME}/.bashrc"
fi

wget -O "${HOME}/.gitconfig" https://raw.githubusercontent.com/hotmit/dotfiles/master/.gitconfig