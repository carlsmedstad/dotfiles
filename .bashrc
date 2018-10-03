#!/bin/bash
# bashrc

# prompt
CLR1="\[$(tput setaf 108)\]"
CLR2="\[$(tput setaf 6)\]"
RESET="\[$(tput sgr0)\]"
export PS1="\[\e]2;terminal\a\]$CLR1\u $CLR2\A $CLR1\W$RESET "

# editor
export EDITOR=nvim
export VISUAL=nvim

# aliases
alias mv="mv -i"
alias cp="cp -i"
alias ls="ls --hide=__pycache__ --color=auto --group-directories-first"
alias grep="grep --colour=auto -nI --exclude=\\.tags --exclude-dir={\\.mypy_cache,\\.cache,\\.pytest_cache,\\.git}"
alias vim="nvim"
alias connect="sudo dhcpcd enp0s20f0u2"
alias neofetch="neofetch --ascii_colors 31 31 --colors 31 31 31 31"
alias cpwd="pwd | xsel -ib"
alias tree="tree -C"
alias less="less -R"

# TeleRadio
alias trupdate="$HOME/dev/tools/gitTools/handleRepoListDef.py $HOME/dev/CFG.repoListDef"
alias trhome="cd ~/dev/home/carl"
alias trdir="cd ~/dev/src/SW/SW0026-PC_Software"

export CDPATH=$HOME/dev/src/SW/SW0026-PC_Software

# tabsize
tabs -4
