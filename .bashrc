#!/bin/bash

export EDITOR=nvim
export VISUAL=nvim

alias mv="mv -i"
alias cp="cp -i"
alias ls="ls --color=auto --group-directories-first"
alias ssh="TERM=rxvt-256color ssh"
alias gitprune="git branch --merged master | grep -v '^[ *]*master$' | xargs git branch -d"

tabs -4

CLR1="\[$(tput setaf 108)\]"
CLR2="\[$(tput setaf 6)\]"
RESET="\[$(tput sgr0)\]"
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  export PS1="\[\e]2;terminal\a\]$CLR1\h@\u $CLR2\A $CLR1\W$RESET "
else
  export PS1="\[\e]2;terminal\a\]$CLR1\u $CLR2\A $CLR1\W$RESET "
fi

if [[ -f $HOME/work/.bashrc ]]; then
  # shellcheck source=/dev/null
  source "$HOME/work/.bashrc"
fi
