ifeq ($(OS), Windows_NT)
    DETECTED_OS := Windows
else
    DETECTED_OS := $(shell uname)
endif

ifeq ($(DETECTED_OS), Linux)

.PHONY: install
install:
	dotbot -d . -c dotbot/common.conf.yaml
	dotbot -d . -c dotbot/linux.conf.yaml

.PHONY: install-system
install-system:
	cd system/linux && ./install

.PHONY: update-pkgs
update-pkgs:
	pacman -Qqen | sort > pkgs/linux/arch.official.txt
	pacman -Qqem | sort | grep -v 'globalprotect' > pkgs/linux/arch.aur.txt

endif

ifeq ($(DETECTED_OS), Darwin)

.PHONY: install
install:
	dotbot -d . -c dotbot/common.conf.yaml
	dotbot -d . -c dotbot/darwin.conf.yaml

.PHONY: update-pkgs
update-pkgs:
	brew bundle dump --force --file pkgs/macos/Brewfile

endif

include .mkincl/init.mk
