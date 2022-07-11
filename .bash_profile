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

command -v terraform >> /dev/null && complete -C /usr/bin/terraform terraform

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
  fi
  if [[ ! "$SSH_AUTH_SOCK" ]]; then
    # shellcheck source=/dev/null
    source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
  fi
fi
