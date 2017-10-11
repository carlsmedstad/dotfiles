#!/bin/bash
# bash_profile

export PATH=$PATH:$HOME/workspace/bashscripts
export TRABDEVELROOT=$HOME/dev

if [[ -f ~/.bashrc ]]; then
  source ~/.bashrc
fi

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
