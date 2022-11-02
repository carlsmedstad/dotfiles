ifeq ($(OS), Windows_NT)
    DETECTED_OS := Windows
else
    DETECTED_OS := $(shell uname)
endif

.PHONY: install
install:
	dotbot -d . -c dotbot/common.conf.yaml
ifeq ($(DETECTED_OS), Linux)
	dotbot -d . -c dotbot/linux.conf.yaml
endif
ifeq ($(DETECTED_OS), Darwin)
	dotbot -d . -c dotbot/darwin.conf.yaml
endif

.PHONY: install-system
install-system:
ifeq ($(DETECTED_OS), Linux)
	cd system/linux && ./install
endif

include .mkincl/init.mk
