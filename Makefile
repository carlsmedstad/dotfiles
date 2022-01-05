ifeq ($(OS), Windows_NT)
    DETECTED_OS := Windows
else
    DETECTED_OS := $(shell uname)
endif

SHELL_FILES = $(shell bin/findsh)

.PHONY: all
all: check install install-system

.PHONY: check-shellcheck
check-shellcheck:
	shellcheck -x $(SHELL_FILES)

.PHONY: check-shfmt
check-shfmt:
	shfmt -d $(SHELL_FILES)

.PHONY: check-stylua
check-stylua:
	stylua --check .

.PHONY: check
check: check-shellcheck check-shfmt check-stylua

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
	dotbot -d system -c dotbot/system.conf.yaml
