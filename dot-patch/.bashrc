export BASHRC_LOADED=1

alias ls='ls -h --color=auto'
alias l='ls -la'

alias dcb='docker-compose build'
alias dcd='docker-compose down'
alias dcdvo='docker-compose down --volumes --remove-orphans'
alias dce='docker-compose exec'
alias dcr='docker-compose run'
alias dcu='docker-compose up'
alias dcub='docker-compose up --build'

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