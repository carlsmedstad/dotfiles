set -x GPG_TTY (tty)
set -x SSH_AGENT_PID ""
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

if status is-interactive
    gpg-connect-agent /bye >/dev/null 2>&1
    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
end
