#!/bin/bash
# shellcheck disable=1091

# shellcheck disable=2015
[ "$TERM" = alacritty ] && infocmp alacritty &> /dev/null \
  || export TERM="xterm-256color"

# Return here for non-interactive shells
test ! -t 0 && return

alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -pv"
alias ls="ls --color=auto --group-directories-first"
alias nvim="nvim --startuptime /tmp/nvim-startuptime"

alias open="xdg-open"
alias nnn="nnn -e"

alias gitprune="git --no-pager  branch --format='%(refname:short)' | xargs -n1 -I{} git branch -d {} 2> /dev/null"
alias gitfix="git diff --name-only | uniq | xargs \$EDITOR"

alias rga="rg --glob='*' --glob='!.git' --glob='!build'"

alias screenshot='grim -g "$(slurp)"'

alias podrun='podman run --rm --interactive --tty --volume "$(pwd)":/pwd --workdir /pwd'
alias lspods='kubectl get pods -o wide --sort-by="{.spec.nodeName}" --all-namespaces'

alias ibmlogin='ibmcloud login -r eu-gb --sso'

tabs -4

unset HISTFILESIZE
export HISTSIZE=10000
export PROMPT_COMMAND="history -a"
shopt -s histappend

GPG_TTY=$(tty)
export GPG_TTY

CLR1="\[$(tput setaf 108)\]"
CLR2="\[$(tput setaf 6)\]"
RESET="\[$(tput sgr0)\]"
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  PS1="\[\e]2;terminal\a\]$CLR1\u@\h $CLR2\A $CLR1\W $CLR2\$$RESET "
else
  PS1="\[\e]2;terminal\a\]$CLR1\u $CLR2\A $CLR1\W $CLR2\$$RESET "
fi

[ -f /usr/share/fzf/key-bindings.bash ] && . /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && . /usr/share/fzf/completion.bash
[ -f /usr/local/opt/fzf/shell/key-bindings.bash ] && . /usr/local/opt/fzf/shell/key-bindings.bash
[ -f /usr/local/opt/fzf/shell/completion.bash ] && . /usr/local/opt/fzf/shell/completion.bash

# shellcheck source=/dev/null
[ -f "$HOME/.bashrc_extra" ] && . "$HOME/.bashrc_extra"
