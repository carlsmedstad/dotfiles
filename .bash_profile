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

  SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  export SSH_AUTH_SOCK
  gpgconf --launch gpg-agent
fi

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  export XDG_CURRENT_DESKTOP=sway
  [ ! -d "$XDG_CACHE_HOME/sway" ] && mkdir "$XDG_CACHE_HOME/sway"
  exec sway -V >> "$XDG_CACHE_HOME/sway/sway-$(date +'%F-%H-%M-%S').log" 2>&1

  # exec startx
fi
