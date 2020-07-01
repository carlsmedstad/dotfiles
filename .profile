#!/bin/sh

export EDITOR=nvim
export VISUAL=nvim

export MANPAGER="nvim +Man!"

PATH=$HOME/personal/scripts:$HOME/.local/bin:$HOME/.cargo/bin:$PATH

if [ "$(uname)" = "Darwin" ]; then
  PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  PATH=/usr/local/opt/grep/libexec/gnubin:$PATH
  PATH=/usr/local/opt/gnu-indent/libexec/gnubin:$PATH
  PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
  PATH=/usr/local/opt/gnu-tar/libexec/gnubin:$PATH
  PATH=/usr/local/opt/findutils/libexec/gnubin:$PATH

  export BASH_SILENCE_DEPRECATION_WARNING=1
fi

export LESSHISTFILE=$HOME/.cache/lesshistfile
export HISTFILE=$HOME/.cache/histfile

export I3BLOCKS_CONTRIB_REPO=$HOME/personal/i3blocks-contrib

if command -v luarocks >> /dev/null; then
  LUA_PATH=$(luarocks path --lr-path)";;"
  LUA_CPATH=$(luarocks path --lr-cpath)";;"
  export LUA_PATH
  export LUA_CPATH
fi

if command -v pyenv >> /dev/null; then
  eval "$(pyenv init -)"
fi

if command -v ruby >> /dev/null && command -v gem >> /dev/null; then
    PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi
