#!/bin/sh

# Print coloured Text
#   cprintln($colour, $text)
#       $colour: 0;30-black, 0;34-blue, 0;32-green, 0;36-cyan, 0;31-red, 0;35-purple, 0;33-brown, 0;37-light gray
#               1;30-dark gray, 1;34-light blue, 1;32-light green, 1;36-light cyan, 1;31-light red, 1;35-light purple, 1;33-yellow, 1;37-white
cprintln(){
    colour=$1
    text=$2
    no_newline=$3

    printf "\e[%sm%s\e[m" "${colour}" "${text}"

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
    file_name=$1
    comment_tag=$2
    local_path="${HOME}/${file_name}"
    remote_path="${GIT_ROOT_URL}/dot-patch/${file_name}"
    header="${comment_tag}\\[dotfile"
    footer="${comment_tag}dotfile\\]"

    print_msg "Patching ${file_name}"
    if [ ! -f "${local_path}" ]; then
        touch "${local_path}"
    fi

    # remove old snippets
    sed -i "/${header}/,/${footer}/d" "${local_path}"
    # remove ending spaces
    sed -i -z -E "s/\n+$//g" "${local_path}"
        # -i  inline edit file
        # -z  null data, essentially read the whole file as one line
        # -E  extended regex to use + quantifier

    # remove the escape character
    header=$(echo "${header}" | sed "s/\\//")
    footer=$(echo "${footer}" | sed "s/\\//")

    printf "\n\n%s\n" "${header}" >> "${local_path}"
    wget -q -O - "${remote_path}" >> "${local_path}"
    printf "\n%s" "${footer}" >> "${local_path}"

    if [ "${file_name}" = ".bashrc" ]; then
        if [ -f "/proc/1/cgroup" ] && grep -q /docker "/proc/1/cgroup"; then
            replacement='PS1="\\e[1;35m❋ \\u\\e[m '
            sed -i "s/PS1=\"/${replacement}/" "${local_path}"
        fi
    fi

    # remove leading spaces
    sed -i -z -E "s/^\n+//g" "${local_path}"
}


dot_patches=".bash_profile .bashrc .profile .vimrc"
for dp in ${dot_patches}; do
    if [ "${dp}" = ".vimrc" ]; then
        dot_patch "${dp}" '"""'
    else
        dot_patch "${dp}" "###"
    fi
done

dot_replace=".gitconfig"
for dr in ${dot_replace}; do
    print_msg "Replacing ${dr}"
    wget -q -O "${HOME}/${dr}" "${GIT_ROOT_URL}/dot-replace/${dr}"
done
