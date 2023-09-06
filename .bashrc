#!/bin/bash
# shellcheck disable=1091

# Return here for non-interactive shells
test ! -t 0 && return

alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -pv"
alias ls="ls --color=auto --group-directories-first"
[ "$(uname)" = "Darwin" ] && alias ls="ls --color=auto"

alias nvim="nvim --startuptime /tmp/nvim-startuptime"

alias open="xdg-open"
alias nnn="nnn -e"

alias gitprune="git --no-pager  branch --format='%(refname:short)' | xargs -n1 -I{} git branch -d {} 2> /dev/null"
alias gitfix="git diff --name-only | uniq | xargs \$EDITOR"

alias rga="rg --glob='*' --glob='!.git' --glob='!build'"

alias screenshot='grim -g "$(slurp)"'

alias podrun='podman run --rm --interactive --tty --volume "$(pwd)":/pwd --workdir /pwd'

alias gitaux='git --git-dir=.gitaux --work-tree=$(pwd)'

tabs -4

unset HISTFILESIZE
export HISTSIZE=10000
export PROMPT_COMMAND="history -a"
shopt -s histappend

CLR1="\[$(tput setaf 16)\]"
CLR2="\[$(tput setaf 17)\]"
RESET="\[$(tput sgr0)\]"
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  PS1="$CLR1\u@\h $CLR2\A \$? $CLR1\W $CLR2\$$RESET "
else
  PS1="$CLR1\u $CLR2\A \$? $CLR1\W $CLR2\$$RESET "
fi

[ -f /usr/share/fzf/key-bindings.bash ] && . /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && . /usr/share/fzf/completion.bash
[ -f /usr/local/opt/fzf/shell/key-bindings.bash ] && . /usr/local/opt/fzf/shell/key-bindings.bash
[ -f /usr/local/opt/fzf/shell/completion.bash ] && . /usr/local/opt/fzf/shell/completion.bash
[ -f /usr/share/clang/bash-autocomplete.sh ] && . /usr/share/clang/bash-autocomplete.sh

if [ -d "$XDG_CONFIG_HOME/bashrc.d/" ]; then
  for f in "$XDG_CONFIG_HOME/bashrc.d/"*; do
    # shellcheck source=/dev/null
    . "$f"
  done
fi

command -v direnv >> /dev/null && eval "$(direnv hook bash)"

[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

if [ "$(uname)" = "Darwin" ] && command -v brew >> /dev/null; then
  [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] \
    && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
  # shellcheck source=/dev/null
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

GPG_TTY=$(tty)
export GPG_TTY

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  export SSH_AUTH_SOCK
fi
