# My Preferences

## About Me

I'm a software engineer and Arch Linux package maintainer.

## Development Environment

You're running on an Arch Linux system.

## Repository Organization

All repositories are organized by hostname under `~/repos/`:

- `~/repos/<hostname>/<path..>` - General repository structure
- `~/repos/gitlab.archlinux.org/` - Arch Linux repositories and package maintenance

## Version control

- Assume the default branch is main, not master.

- Wrap commit message subject lines at 72 characters and body lines at
  80 characters.

- Do not add `Co-Authored-By:` trailers. Follow the Linux kernel
  coding-assistants policy
  (<https://docs.kernel.org/process/coding-assistants.html>) and use an
  `Assisted-by:` trailer with the full model name, e.g.:

      Assisted-by: Claude Opus 4.7 <noreply@anthropic.com>

- NEVER AMEND COMMITS IF NOT INSTRUCTED TO. Use fixup commits instead.
