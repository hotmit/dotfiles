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

function add_config
{
    local file=$1
    local key=$2
    local config=$3

    if [ -f "${file}" ]; then
        print_msg "Found ${file}"
        if ! grep -q "${key}" "${file}"; then
            print_msg "   append config"
            printf "\n${config}" >> "${file}"
        else
            print_msg "   do nothing"
        fi
    else
        print_msg "Created ${file}"
        printf "${config}" > "${file}"
    fi
}


add_config "${HOME}/.vimrc" "ctermfg=" "hi Comment ctermfg=DarkGreen"
add_config "${HOME}/.bashrc" "LS_COLORS=" 'LS_COLORS=$LS_COLORS:'"'"'di=0;35:'"'"' ; export LS_COLORS'
add_config "${HOME}/.bash_profile" "git branch 2" 'export PS1="\[\e[1;33m\w\e[m \$(git branch 2>/dev/null | awk '"'"'{if (\$2) printf(\"\\033[0;33m(%s)\\033[m\", \$2);}'"'"')\n\$ "'

