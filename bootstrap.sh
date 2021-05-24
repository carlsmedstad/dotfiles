#!/bin/sh

set -eu

if [ "$(uname)" = Darwin ]; then

  # install homebrew if it's missing
  if ! command -v brew >/dev/null 2>&1; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew bundle --file pkgs/Brewfile

fi

if [ -f /etc/arch-release ]; then

  sudo pacman -S --needed base base-devel
  # shellcheck disable=2002
  cat pkgs/arch.official.txt | sudo pacman -S --needed -

  # install yay if it's missing
  if ! command -v yay >/dev/null 2>&1; then
    repo_dir=$(mktemp -d)
    old_dir="$(pwd)"
    trap 'rm -rf $repo_dir' EXIT

    git clone https://aur.archlinux.org/yay.git "$repo_dir"

    cd "$repo_dir"
    makepkg -si
    cd "$old_dir"
  fi

  yay -S --needed - < pkgs/arch.aur.txt

fi

plug_path="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
if [ ! -f "$plug_path" ]; then
  curl -fLo "$plug_path" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if command -v nvim >/dev/null 2>&1; then
  nvim '+PlugUpgrade' '+PlugInstall' '+PlugUpdate' '+PlugClean!' '+qall'
fi
