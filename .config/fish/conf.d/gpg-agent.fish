set -x GPG_TTY (tty)
set -x SSH_AGENT_PID ""
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
