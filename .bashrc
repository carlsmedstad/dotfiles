#!/bin/bash

[ "$TERM" = alacritty ] && ! infocmp alacritty &> /dev/null \
  && export TERM="xterm-256color"

# Return here for non-interactive shells
test ! -t 0 && return

alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -pv"
alias ls="ls --color=auto --group-directories-first"

alias open="xdg-open"
alias nnn="nnn -e"

alias gitprune="git branch --merged master | grep -v '^[ *]*master$' | xargs git branch -d"
alias gitfix="git diff --name-only | uniq | xargs \$EDITOR"

alias rga="rg --glob='*' --glob='!.git'"

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
  PS1="\[\e]2;terminal\a\]$CLR1\u@\h $CLR2\A $CLR1\W$RESET "
else
  PS1="\[\e]2;terminal\a\]$CLR1\u $CLR2\A $CLR1\W$RESET "
fi

# shellcheck source=/dev/null
[ -f "$HOME/.bashrc_extra" ] && . "$HOME/.bashrc_extra"
