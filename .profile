#!/bin/sh

export EDITOR=nvim
export VISUAL=nvim

export MANPAGER="nvim +Man!"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export AZURE_CONFIG_DIR=$XDG_DATA_HOME/azure
export CARGO_HOME=$XDG_DATA_HOME/cargo
export HELM_HOME=$XDG_DATA_HOME/helm
export JFROG_CLI_HOME_DIR=$XDG_DATA_HOME/jfrog
export MINIKUBE_HOME=$XDG_DATA_HOME/minikube
export PYENV_ROOT=$XDG_DATA_HOME/pyenv
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export GOPATH=$XDG_DATA_HOME/go
export GOBIN=$GOPATH/bin

export LUAROCKS_CONFIG=$XDG_CONFIG_HOME/luarocks/config.lua
export CCACHE_CONFIGPATH=$XDG_CONFIG_HOME/ccache.config

export CCACHE_DIR=$XDG_CACHE_HOME/ccache
export LESSHISTFILE=$XDG_CACHE_HOME/lesshistfile
export HISTFILE=$XDG_CACHE_HOME/histfile
export SQLITE_HISTORY=$XDG_CACHE_HOME/sqlite_history

PATH=$GOBIN:$HOME/workspace/github/bin:$HOME/.local/bin:$PATH
PATH=$CARGO_HOME/bin:/usr/lib/ccache/bin:$PATH

if [ "$(uname)" = "Darwin" ]; then
  PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  PATH=/usr/local/opt/grep/libexec/gnubin:$PATH
  PATH=/usr/local/opt/gnu-indent/libexec/gnubin:$PATH
  PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
  PATH=/usr/local/opt/gnu-tar/libexec/gnubin:$PATH
  PATH=/usr/local/opt/findutils/libexec/gnubin:$PATH

  export BASH_SILENCE_DEPRECATION_WARNING=1

  if command -v ruby >> /dev/null && command -v gem >> /dev/null; then
      PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
  fi
fi

if command -v luarocks >> /dev/null; then
  LUA_PATH=$(luarocks path --lr-path)";;"
  LUA_CPATH=$(luarocks path --lr-cpath)";;"
  export LUA_PATH
  export LUA_CPATH
fi

if command -v pyenv >> /dev/null; then
  eval "$(pyenv init -)"
fi

export MINIKUBE_CONTAINER_RUNTIME=crio
export MINIKUBE_DRIVER=kvm2
