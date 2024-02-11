# shellcheck disable=1091

if [ "$(uname)" = "Darwin" ]; then
  [ -f /opt/homebrew/bin/brew ] \
    && eval "$(/opt/homebrew/bin/brew shellenv)"
  [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ] \
    && . /opt/homebrew/etc/profile.d/bash_completion.sh
  [ -f "$HOME/.fzf.bash" ] \
    && . "$HOME/.fzf.bash"
  [ -f /usr/local/opt/fzf/shell/key-bindings.bash ] \
    && . /usr/local/opt/fzf/shell/key-bindings.bash
  [ -f /usr/local/opt/fzf/shell/completion.bash ] \
    && . /usr/local/opt/fzf/shell/completion.bash
fi
