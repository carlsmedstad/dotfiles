set -x GPG_TTY (tty)
set -e SSH_AGENT_PID
if test "$gnupg_SSH_AUTH_SOCK_by" != $fish_pid
    set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end
