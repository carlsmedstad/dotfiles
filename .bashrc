#!/bin/bash
# shellcheck disable=1091

# Return here for non-interactive shells
test ! -t 0 && return

alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -pv"
alias ls="ls --color=auto --group-directories-first"
alias nvim="nvim --startuptime /tmp/nvim-startuptime"

alias open="xdg-open"
alias nnn="nnn -e"

alias gitprune="git --no-pager  branch --format='%(refname:short)' | xargs -n1 -I{} git branch -d {} 2> /dev/null"
alias gitfix="git diff --name-only | uniq | xargs \$EDITOR"

alias rga="rg --glob='*' --glob='!.git' --glob='!build'"

alias screenshot='grim -g "$(slurp)"'

alias podrun='podman run --rm --interactive --tty --volume "$(pwd)":/pwd --workdir /pwd'

tabs -4

unset HISTFILESIZE
export HISTSIZE=10000
export PROMPT_COMMAND="history -a"
shopt -s histappend

GPG_TTY=$(tty)
export GPG_TTY

if [ "$(uname)" = "Linux" ]; then
  export SSH_AGENT_PID=""
  export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
fi

CLR1="\[$(tput setaf 108)\]"
CLR2="\[$(tput setaf 6)\]"
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
