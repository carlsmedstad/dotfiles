# shellcheck disable=1091,2154
# Return here for non-interactive shells
test ! -t 0 && return

tabs -4

unset HISTFILESIZE
export HISTSIZE=100000
export PROMPT_COMMAND="history -a"
shopt -s histappend

[ -f /usr/share/fzf/key-bindings.bash ] && . /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && . /usr/share/fzf/completion.bash
[ -f /usr/share/clang/bash-autocomplete.sh ] && . /usr/share/clang/bash-autocomplete.sh

if [ -d "$XDG_CONFIG_HOME/bash/" ]; then
  for file in "$XDG_CONFIG_HOME/bash/"*; do
    # shellcheck source=/dev/null
    . "$file"
  done
fi

command -v direnv >> /dev/null && eval "$(direnv hook bash)"

GPG_TTY=$(tty)
export GPG_TTY

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  export SSH_AUTH_SOCK
fi
