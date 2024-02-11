# shellcheck shell=bash disable=2155

export GPG_TTY="$(tty)"
unset SSH_AGENT_PID
[ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ] \
  && export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
