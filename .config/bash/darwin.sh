# shellcheck shell=bash disable=1090,1091

[ "$(uname)" = "Darwin" ] || return


[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

bash_completion_file="/opt/homebrew/etc/profile.d/bash_completion.sh"
[ -f "$bash_completion_file" ] && . "$bash_completion_file"

coreutils_bindir="/opt/homebrew/opt/coreutils/libexec/gnubin"
[ -d "$coreutils_bindir" ] && export PATH="$coreutils_bindir:$PATH"

fzf_key_bindings_file="/opt/homebrew/opt/fzf/shell/key-bindings.bash"
[ -f "$fzf_key_bindings_file" ] && . "$fzf_key_bindings_file"

fzf_completion_file="/opt/homebrew/opt/fzf/shell/completion.bash"
[ -f "$fzf_completion_file" ] && . "$fzf_completion_file"

[ -f "$HOME/.fzf.bash" ] && . "$HOME/.fzf.bash"
