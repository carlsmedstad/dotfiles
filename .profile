#!/bin/sh

export EDITOR=nvim
export VISUAL=nvim

export MANPAGER="nvim +Man!"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export AZURE_CONFIG_DIR=$XDG_DATA_HOME/azure
export CARGO_HOME=$XDG_DATA_HOME/cargo
export GOBIN=$GOPATH/bin
export GOPATH=$XDG_DATA_HOME/go
export IBMCLOUD_HOME=$XDG_DATA_HOME/ibmcloud
export JFROG_CLI_HOME_DIR=$XDG_DATA_HOME/jfrog
export KREW_ROOT=$XDG_DATA_HOME/krew
export MINIKUBE_HOME=$XDG_DATA_HOME/minikube
export RUSTUP_HOME=$XDG_DATA_HOME/rustup

export CCACHE_CONFIGPATH=$XDG_CONFIG_HOME/ccache.config
export CCACHE_DIR=$XDG_CACHE_HOME/ccache

[ -d "$XDG_STATE_HOME" ] || mkdir -p "$XDG_STATE_HOME"
export HISTFILE=$XDG_STATE_HOME/bash_history
export LESSHISTFILE=$XDG_STATE_HOME/less_history
export SQLITE_HISTORY=$XDG_STATE_HOME/sqlite_history

PATH=$HOME/.local/bin:$GOBIN:$CARGO_HOME/bin:/usr/lib/ccache/bin:$PATH
PATH=$KREW_ROOT/bin:$PATH

if [ "$(uname)" = "Darwin" ]; then
  PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  PATH=/usr/local/opt/grep/libexec/gnubin:$PATH
  PATH=/usr/local/opt/gnu-indent/libexec/gnubin:$PATH
  PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
  PATH=/usr/local/opt/gnu-tar/libexec/gnubin:$PATH
  PATH=/usr/local/opt/findutils/libexec/gnubin:$PATH

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

export MINIKUBE_CONTAINER_RUNTIME=crio
export MINIKUBE_DRIVER=kvm2

export ANSIBLE_STDOUT_CALLBACK=yaml

if command -v pyenv>> /dev/null; then
  export PYENV_ROOT=$XDG_DATA_HOME/pyenv
  eval "$(pyenv init --path)"
fi
