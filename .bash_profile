#!/bin/bash
# bash_profile

# Environment variables
export PATH=$PATH:$HOME/workspace/bash
export PATH=$PATH:$HOME/workspace/chalmers/mve165/ampl/ampl_linux-intel64
export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre

if [[ -f ~/.bashrc ]]; then
  source ~/.bashrc
fi

# if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
#   setxkbmap -layout se -variant nodeadkeys
#   setxkbmap -option caps:escape &
#   WLC_REPEAT_DELAY=200
#   WLC_REPEAT_RATE=50
#   exec sway
# fi

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
