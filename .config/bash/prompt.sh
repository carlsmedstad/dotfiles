# shellcheck shell=bash

CLR1="\[$(tput setaf 16)\]"
CLR2="\[$(tput setaf 17)\]"
RESET="\[$(tput sgr0)\]"
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  PS1="$CLR1\u@\h $CLR2\A \$? $CLR1\W $CLR2\$$RESET "
else
  PS1="$CLR1\u $CLR2\A \$? $CLR1\W $CLR2\$$RESET "
fi
