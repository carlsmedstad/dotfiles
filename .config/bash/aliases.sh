# shellcheck shell=bash

alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -pv"
alias ls="ls --color=auto --group-directories-first"
alias nvim="nvim --startuptime /tmp/nvim-startuptime"
alias open="xdg-open"

alias gitprune="git --no-pager  branch --format='%(refname:short)' | xargs -n1 -I{} git branch -d {} 2> /dev/null"
# shellcheck disable=2154
alias gitfix="git diff --name-only | uniq | xargs \$EDITOR"
alias screenshot='grim -g "$(slurp)"'
alias podrun='podman run --rm --interactive --tty --volume "$(pwd)":/pwd --workdir /pwd'
alias rga="rg --glob='*' --glob='!.git' --glob='!build'"
