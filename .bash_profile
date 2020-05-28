#!/bin/bash

if [ -f ~/.profile ]; then
  # shellcheck source=/dev/null
  . ~/.profile
fi

if [ -f ~/.bashrc ]; then
  # shellcheck source=/dev/null
  . ~/.bashrc
fi

if [ "$(uname)" = "Darwin" ] && command -v brew >> /dev/null; then
  if [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]; then
    # shellcheck source=/dev/null
    . "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
  fi
fi

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  [ ! -d ~/.cache/sway ] && mkdir ~/.cache/sway
  exec sway -V >> ~/.cache/sway/sway-"$(date +'%F-%H-%M-%S')".log 2>&1
fi
