#!/bin/bash

export PATH=$HOME/personal/scripts:$HOME/.local/bin:$HOME/.cargo/bin:$PATH
export GOPATH=$HOME/work/go

if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  export PATH=/usr/local/opt/grep/libexec/gnubin:$PATH
  export PATH=/usr/local/opt/gnu-indent/libexec/gnubin:$PATH
  export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
  export PATH=/usr/local/opt/gnu-tar/libexec/gnubin:$PATH
  export PATH=/usr/local/opt/findutils/libexec/gnubin:$PATH

  export BASH_SILENCE_DEPRECATION_WARNING=1

  if [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]; then
    # shellcheck source=/dev/null
    . "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
  fi
fi

export LESSHISTFILE=$HOME/.cache/.less_history
export HISTFILE=$HOME/.cache/.bash_history

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

if [[ -f ~/.bashrc && "$-" == *i* ]]; then
  # shellcheck source=/dev/null
  source ~/.bashrc
fi

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  [ ! -d ~/.cache/sway ] && mkdir ~/.cache/sway
  exec sway -V >> ~/.cache/sway/sway-"$(date +'%F-%H-%M-%S')".log 2>&1
fi
