#!/bin/bash
# bashrc

# prompt
CLR1="\[$(tput setaf 108)\]"
CLR2="\[$(tput setaf 6)\]"
RESET="\[$(tput sgr0)\]"
export PS1="\[\e]2;terminal\a\]$CLR1\u $CLR2\W$RESET "

# add my scripts to path
export PATH=$PATH:$HOME/workspace/bash

# editor
export EDITOR=nvim
export VISUAL=nvim

# bash history
export HISTFILE=$HOME/.local/share/bash_history
export PROMPT_COMMAND='history -a'

# aliases
alias mv="mv -i"
alias ls="ls --color=auto"
alias grep="grep --colour=auto"
alias vim="nvim"

# tabsize
tabs -4
