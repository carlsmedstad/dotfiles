#!/bin/bash

# shellcheck source=/dev/null
[ -f ~/.profile ] && . ~/.profile
[ -f ~/.bashrc ] && . ~/.bashrc

if [ "$(uname)" = "Darwin" ] && command -v brew >> /dev/null; then
  [ -r "/usr/local/etc/profile.d/bash_completion.sh" ] \
    && . "/usr/local/etc/profile.d/bash_completion.sh"
  [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] \
    && . "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"

  SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  export SSH_AUTH_SOCK
  gpgconf --launch gpg-agent
fi
