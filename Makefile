ifeq ($(OS), Windows_NT)
    DETECTED_OS := Windows
else
    DETECTED_OS := $(shell uname)
endif

.PHONY: all check-shellcheck check-shfmt check install install-system

all: check install install-system

SHELL_FILES = $(shell bin/findsh)

check-shellcheck:
	shellcheck -x $(SHELL_FILES)

check-shfmt:
	shfmt -d $(SHELL_FILES)

check: check-shellcheck check-shfmt

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
