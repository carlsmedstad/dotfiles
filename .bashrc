#!/bin/bash
# bashrc


# prompt
CLR1="\[$(tput setaf 108)\]"
CLR2="\[$(tput setaf 6)\]"
RESET="\[$(tput sgr0)\]"
export PS1="\[\e]2;terminal\a\]$CLR1\u $CLR2\A $CLR1\W$RESET "


# editor
has_nvim=$([[ ! -z $(command -v nvim) ]])
if $has_nvim; then
  export EDITOR=nvim
  export VISUAL=nvim
else
  export EDITOR=vim
  export VISUAL=vim
fi


# aliases
alias mv="mv -i"
alias cp="cp -i"
alias ls="ls --hide=__pycache__ --color=auto --group-directories-first"
alias grep="grep --colour=auto -nI --exclude={\\.tags,luacov*} --exclude-dir={\\.mypy_cache,\\.cache,\\.pytest_cache,\\.git}"
alias diff="diff --color"
alias connect="sudo dhcpcd enp0s20f0u2"
alias neofetch="neofetch --ascii_colors 31 31 --colors 31 31 31 31"
alias cpwd="pwd | xsel -ib"
alias tree="tree -C"
alias less="less -R"


# work
export TEXTTEST_HOME=$HOME/repos/sulu2_tt


# tabsize
tabs -4
