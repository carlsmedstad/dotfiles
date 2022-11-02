ifeq ($(OS), Windows_NT)
    DETECTED_OS := Windows
else
    DETECTED_OS := $(shell uname)
endif

SHELL_FILES = $(shell bin/findsh)
LUA_FILES = $(shell find -name '*.lua')
SHFMT_OPTS = -i 2 -bn -sr

.PHONY: all
all: check install install-system

.PHONY: install install-system
install:
	dotbot -d . -c dotbot/common.conf.yaml
ifeq ($(DETECTED_OS), Linux)
	dotbot -d . -c dotbot/linux.conf.yaml
endif
ifeq ($(DETECTED_OS), Darwin)
	dotbot -d . -c dotbot/darwin.conf.yaml
endif

install-system:
ifeq ($(DETECTED_OS), Linux)
	cd system/linux && ./install
endif

include .mkincl/init.mk
