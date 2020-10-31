#!/bin/bash

alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -pv"
alias ls="ls --color=auto --group-directories-first"
alias ssh="TERM=rxvt-256color ssh"
alias gitprune="git branch --merged master | grep -v '^[ *]*master$' | xargs git branch -d"
alias gitfix="git diff --name-only | uniq | xargs \$EDITOR"
alias xalacritty="env WINIT_UNIX_BACKEND=x11 alacritty"

tabs -4

unset HISTFILESIZE
export HISTSIZE=10000
export PROMPT_COMMAND="history -a"
shopt -s histappend

CLR1="\[$(tput setaf 108)\]"
CLR2="\[$(tput setaf 6)\]"
RESET="\[$(tput sgr0)\]"
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  PS1="\[\e]2;terminal\a\]$CLR1\h@\u $CLR2\A $CLR1\W$RESET "
else
  PS1="\[\e]2;terminal\a\]$CLR1\u $CLR2\A $CLR1\W$RESET "
fi

if [[ -f $HOME/workspace/jeppesen-gitlab/carlsmedstad/dotfiles/bashrc ]]; then
  # shellcheck source=/dev/null
  . "$HOME/workspace/jeppesen-gitlab/carlsmedstad/dotfiles/bashrc"
fi
