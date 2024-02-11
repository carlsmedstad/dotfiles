# shellcheck disable=1091,2154

# Return here for non-interactive shells
test ! -t 0 && return

# Source configuration files
if [ -d "$XDG_CONFIG_HOME/bash/" ]; then
  for file in "$XDG_CONFIG_HOME/bash/"*; do
    # shellcheck source=/dev/null
    . "$file"
  done
fi

tabs -4

unset HISTFILESIZE
export HISTSIZE=100000
export PROMPT_COMMAND="history -a"
shopt -s histappend

[ -f /usr/share/fzf/key-bindings.bash ] && . /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && . /usr/share/fzf/completion.bash
[ -f /usr/share/clang/bash-autocomplete.sh ] && . /usr/share/clang/bash-autocomplete.sh

command -v direnv >> /dev/null && eval "$(direnv hook bash)"
