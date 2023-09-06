ifeq ($(OS), Windows_NT)
    DETECTED_OS := Windows
else
    DETECTED_OS := $(shell uname)
endif

ifeq ($(DETECTED_OS), Linux)

.PHONY: install-configs-user
install-configs-user:
	dotbot -d . -c dotbot/common.conf.yaml
	dotbot -d . -c dotbot/linux.conf.yaml

.PHONY: install-configs-system
install-configs-system:
	cd system/linux && ./install

.PHONY: dump-packages
dump-packages:
	./pkgs/linux/dump

.PHONY: bootstrap
bootstrap:
	sudo pacman -S --needed base base-devel
	./bootstrap/linux/paru
	./bootstrap/linux/pkgs
	sudo make install-configs-system
	make install-configs-user
	./bootstrap/common/nvim

endif

ifeq ($(DETECTED_OS), Darwin)

.PHONY: install-configs-user
install-configs-user:
	eval "$(/opt/homebrew/bin/brew shellenv)" && dotbot -d . -c dotbot/common.conf.yaml
	eval "$(/opt/homebrew/bin/brew shellenv)" && dotbot -d . -c dotbot/darwin.conf.yaml

.PHONY: dump-packages
dump-packages:
	brew bundle dump --force --file pkgs/darwin/Brewfile

.PHONY: bootstrap
bootstrap:
	./bootstrap/darwin/shell
	./bootstrap/darwin/homebrew
	./bootstrap/darwin/pkgs
	make install-configs-user
	./bootstrap/common/nvim

endif

include .mkincl/init.mk
