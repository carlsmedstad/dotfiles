ifeq ($(OS), Windows_NT)
    DETECTED_OS := Windows
else
    DETECTED_OS := $(shell uname)
endif

ifeq ($(DETECTED_OS), Linux)

.PHONY: install-configs-user
install-configs-user:
	cat installer/common.paths.ini installer/linux.paths.ini \
	  | ./installer/filter-ini \
	  | while read -r line; do \
	      ./installer/install-symlink $$line; \
	    done

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
	git submodule update --recursive --init
	sudo make install-configs-system
	make install-configs-user
	./bootstrap/common/nvim

endif

ifeq ($(DETECTED_OS), Darwin)

.PHONY: install-configs-user
install-configs-user:
	eval "$(/opt/homebrew/bin/brew shellenv)" \
	  && cat installer/common.paths.ini installer/darwin.paths.ini \
	    | ./installer/filter-ini \
	    | while read -r line; do \
	        ./installer/install-symlink $$line; \
	      done

TMP_FILE:=$(shell mktemp)

.PHONY: dump-packages
dump-packages:
	./pkgs/darwin/dump

.PHONY: bootstrap
bootstrap:
	./bootstrap/darwin/shell
	./bootstrap/darwin/homebrew
	./bootstrap/darwin/pkgs
	git submodule update --recursive --init
	PATH=/opt/homebrew/bin:$$PATH make install-configs-user
	./bootstrap/common/nvim

endif

include .mkincl/init.mk
