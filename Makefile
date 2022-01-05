ifeq ($(OS), Windows_NT)
    DETECTED_OS := Windows
else
    DETECTED_OS := $(shell uname)
endif

SHELL_FILES = $(shell bin/findsh)
LUA_FILES = $(shell find -name '*.lua')
SHFMT_OPTS = -p -i 2 -bn -sr

.PHONY: all
all: check install install-system


.PHONY: fix fix-shfmt fix-stylua
fix: fix-shfmt fix-stylua

fix-shfmt:
	shfmt -w $(SHFMT_OPTS) $(SHELL_FILES)

fix-stylua:
	stylua $(LUA_FILES)


.PHONY: check check-shellcheck check-shfmt check-stylua
check: check-shellcheck check-shfmt check-stylua

check-shellcheck:
	shellcheck -x $(SHELL_FILES)

check-shfmt:
	shfmt -d $(SHFMT_OPTS) $(SHELL_FILES)

check-stylua:
	stylua --check $(LUA_FILES)


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
	dotbot -d system -c dotbot/system.conf.yaml
