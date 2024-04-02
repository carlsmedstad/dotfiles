if test (uname) != "Darwin"
  return
end

if test -f /opt/homebrew/bin/brew
  eval (/opt/homebrew/bin/brew shellenv)
end

set coreutils_bindir "/opt/homebrew/opt/coreutils/libexec/gnubin"
if test -d "$coreutils_bindir"
  set -gx PATH $HOME/.local/bin $coreutils_bindir $PATH
end
