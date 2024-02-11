export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=alacritty

export MANPAGER="nvim +Man!"
export DIFFPROG="nvim -d"

export PATH="$HOME/.local/bin:$PATH"

# Set XDG Base Directory specification environment variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Configure applications to use XDG Base Directory specification
export AZURE_CONFIG_DIR="$XDG_DATA_HOME/azure"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export JFROG_CLI_HOME_DIR="$XDG_DATA_HOME/jfrog"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

[ -d "$XDG_STATE_HOME" ] || mkdir -p "$XDG_STATE_HOME"
export HISTFILE="$XDG_STATE_HOME/bash_history"
export LESSHISTFILE="$XDG_STATE_HOME/less_history"
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"

# Miscellaneaus configuration
export ANSIBLE_STDOUT_CALLBACK=yaml
export AUR_SUPER_REPO="$HOME/repos/github.com/carlsmedstad/aurpkgs"
export GTK_THEME=Catppuccin-Mocha-Standard-Mauve-dark
