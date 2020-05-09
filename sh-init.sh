#!/bin/sh
# Print coloured Text
#   cprintln($colour, $text)
#       $colour: 0;30-black, 0;34-blue, 0;32-green, 0;36-cyan, 0;31-red, 0;35-purple, 0;33-brown, 0;37-light gray
#               1;30-dark gray, 1;34-light blue, 1;32-light green, 1;36-light cyan, 1;31-light red, 1;35-light purple, 1;33-yellow, 1;37-white
cprintln(){
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
cprint(){
    cprintln "$1" "$2" 1
}

# Print green text on screen
#   print_msg($text)
print_msg(){
    cprintln "1;32" "$1"
}

# Print red text on screen
#   print_error($text)
print_error(){
    cprintln "0;31" "$1"
}


GIT_ROOT_URL=https://raw.githubusercontent.com/hotmit/dotfiles/master

# Append/Replace the custom snippet of the dot file
#   dot_patch($dot_file_name)
#     eg dot_patch '.bash_profile'
dot_patch(){
    local file_name=$1
    local local_path="${HOME}/${file_name}"
    local remote_path="${GIT_ROOT_URL}/dot-patch/${file_name}"

    print_msg "Patching ${file_name} ..."
    if [ ! -f "${local_path}" ]; then
        touch "${local_path}"
    fi

    sed -i "/###\[dotfile/,/###dotfile\]/d" "${local_path}"
        # -i - edit in place

    printf "\n###[dotfile\n"    >> "${local_path}"
    wget -q -O - "${remote_path}"  >> "${local_path}"
    printf "\n###dotfile]"   >> "${local_path}"

    if [ "${file_name}" == ".bash_profile" ]; then
        if [ -f "/proc/1/cgroup" ] && grep -q /docker "/proc/1/cgroup"; then
            sed -i "s/PS1=\"/PS1=\"\e[1;35m\xe2\x9d\x8b\u/" "${local_path}"
        fi
    fi
}

dot_patches=".bash_profile .bashrc .vimrc"
for dp in ${dot_patches}; do
    dot_patch "${dp}"
done

dot_replace=".gitconfig"
for dr in ${dot_replace}; do
    print_msg "Replacing ${dr} ..."
    wget -q -O "${HOME}/${dr}" "${GIT_ROOT_URL}/dot-replace/${dr}"
done