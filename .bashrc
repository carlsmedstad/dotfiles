#!/bin/bash
# bashrc


# paths
export PATH=$HOME/.luarocks/bin:$HOME/.local/bin:$PATH
export TERM=rxvt-256color


# prompt
CLR1="\[$(tput setaf 108)\]"
CLR2="\[$(tput setaf 6)\]"
RESET="\[$(tput sgr0)\]"
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  export PS1="\[\e]2;terminal\a\]$CLR1\h@\u $CLR2\A $CLR1\W$RESET "
else
  export PS1="\[\e]2;terminal\a\]$CLR1\u $CLR2\A $CLR1\W$RESET "
fi


# editor
if [[ ! -z $(command -v nvim) ]]; then
  export EDITOR=nvim
  export VISUAL=nvim
  alias vim=nvim
else
  export EDITOR=vim
  export VISUAL=vim
  alias nvim=vim
fi


# tabsize
tabs -4


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
alias ssh="TERM=rxvt-256color ssh"


# workrc
if [[ -f $HOME/.workrc ]]; then
  source $HOME/.workrc
fi


# lua
if command -v luarocks >> /dev/null; then
  export LUA_PATH=$(luarocks path --lr-path)";;"
  export LUA_CPATH=$(luarocks path --lr-cpath)";;"
fi
