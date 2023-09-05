#!/bin/sh

export EDITOR=nvim
export VISUAL=nvim

export MANPAGER="nvim +Man!"
export DIFFPROG="nvim -d"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export AZURE_CONFIG_DIR="$XDG_DATA_HOME/azure"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOBIN="$GOPATH/bin"
export GOPATH="$XDG_DATA_HOME/go"
export JFROG_CLI_HOME_DIR="$XDG_DATA_HOME/jfrog"
export KREW_ROOT="$XDG_DATA_HOME/krew"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache.config"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"

export ANSIBLE_STDOUT_CALLBACK=yaml

[ -d "$XDG_STATE_HOME" ] || mkdir -p "$XDG_STATE_HOME"
export HISTFILE="$XDG_STATE_HOME/bash_history"
export LESSHISTFILE="$XDG_STATE_HOME/less_history"
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"

# For phoneinfoga
export GOOGLECSE_CX=f0f0d74a82b79456e
export GOOGLECSE_MAX_RESULTS=10

PATH=$HOME/.local/bin:$GOBIN:$CARGO_HOME/bin:/usr/lib/ccache/bin:$PATH
PATH=$KREW_ROOT/bin:$PATH

if [ "$(uname)" = "Darwin" ]; then
  export BASH_SILENCE_DEPRECATION_WARNING=1

  command -v ruby >> /dev/null && command -v gem >> /dev/null \
    && PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

if command -v luarocks >> /dev/null; then
  LUA_PATH=$(luarocks path --lr-path)";;"
  LUA_CPATH=$(luarocks path --lr-cpath)";;"
  export LUA_PATH
  export LUA_CPATH
fi

export GTK_THEME=Catppuccin-Mocha-Standard-Mauve-dark
