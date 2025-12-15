export BASHRC_LOADED=1

alias ls='ls -h --color=auto'
alias l='ls -la'
alias ll='ls -alF'
alias lt='ls --human-readable --size -1 -S --classify'
alias ct='find . -type f | wc -l'

alias dcc='docker compose'
alias dcb='docker compose build'
alias dcd='docker compose down'
alias dcdvo='docker compose down --volumes --remove-orphans'
alias dce='docker compose exec'
alias dcr='docker compose run --rm'
alias dcre='docker compose run --no-deps --rm --entrypoint=""'
alias dcu='docker compose up --menu=false'
alias dcub='docker compose up --build --menu=false'
alias dct='docker compose restart'
alias dct='docker compose down && docker compose up -d'
alias dcsp='docker compose stop'
alias dcst='docker compose start'

alias df='df -h'
alias free='free -h'

alias an='ansible'
alias and='ansible-doc'
alias anp='ansible-playbook'
alias ang='ansible-galaxy'

alias v='nvim'

export LS_COLORS="${LS_COLORS}:di=1;35"

git_branch() {
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [ -n "${branch}" ]; then
        if [ -n "$(git diff --shortstat)" ]; then
            printf "(☕  ${branch})"
        else
            printf "(${branch})"
        fi
    fi
}
export PS1='\[\e[32m\]\w\[\e[m\]\[\e[0;33m\]$(git_branch)\[\e[m\]'$'\n\[\e[33m\]# \[\e[m\]'
