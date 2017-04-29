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

# aliases
alias mv="mv -i"
alias ls="ls --color=auto"
alias grep="grep --colour=auto"
alias vim="nvim"
alias connect="sudo dhcpcd enp0s20f0u2"
alias neofetch="neofetch --ascii_colors 31 31 --colors 31 31 31 31"

# tabsize
tabs -4
