#!/bin/bash

export PATH=$HOME/personal/scripts:$HOME/.local/bin:$HOME/.cargo/bin:$PATH
export GOPATH=$HOME/work/go

export LESSHISTFILE=$HOME/.cache/.less_history
export HISTFILE=$HOME/.cache/.bash_history

if command -v luarocks >> /dev/null; then
  LUA_PATH=$(luarocks path --lr-path)";;"
  LUA_CPATH=$(luarocks path --lr-cpath)";;"
  export LUA_PATH
  export LUA_CPATH
fi

eval "$(pyenv init -)"

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

if [[ -f ~/.bashrc && "$-" == *i* ]]; then
  # shellcheck source=/dev/null
  source ~/.bashrc
fi

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec sway -V >> ~/.local/share/sway/sway-"$(date +'%F-%H-%M-%S')".log 2>&1
fi
