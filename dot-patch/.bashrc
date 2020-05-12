export BASHRC_LOADED=1

alias ls='ls -h --color=auto'
alias l='ls -la'
export LS_COLORS="${LS_COLORS}:di=1;35"

git_branch() {
    local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [ -n "${branch}" ]; then
        if [ -n "$(git diff --shortstat)" ]; then
            printf "(☕${branch})"
        else
            printf "(${branch})"
        fi
    fi
}
export PS1='\[\e[32m\]\w\[\e[m\]\[\e[0;33m\]$(git_branch)\[\e[m\]'$'\n\[\e[33m\]# \[\e[m\]'