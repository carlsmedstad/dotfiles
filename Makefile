ifeq ($(OS), Windows_NT)
    DETECTED_OS := Windows
else
    DETECTED_OS := $(shell uname)
endif

.PHONY: all shellcheck install install-system

all: shellcheck install install-system

SHELL_FILES = $(shell bin/findsh)

shellcheck:
	shellcheck -x $(SHELL_FILES)

install:
	dotbot -d . -c dotbot/common.conf.yaml
ifeq ($(DETECTED_OS), Linux)
	dotbot -d . -c dotbot/linux.conf.yaml
endif
ifeq ($(DETECTED_OS), Darwin)
	dotbot -d . -c dotbot/darwin.conf.yaml
endif

install-system:
	dotbot -d system -c dotbot/system.conf.yaml
