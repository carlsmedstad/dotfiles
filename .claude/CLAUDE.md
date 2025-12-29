# My Preferences

## About Me

I'm a software engineer and Arch Linux package maintainer.

## Development Environment

You're running on an Arch Linux system.

## Repository Organization

All repositories are organized by hostname under `~/repos/`:

- `~/repos/<hostname>/<path..>` - General repository structure
- `~/repos/gitlab.archlinux.org/` - Arch Linux repositories and package maintenance

## Working Directory Guidelines

Avoid using `cd` to change directories. Instead, supply the directory as an
argument to commands. NOTE: Don't add a directory argument if not necessary,
i.e. if your CWD is the target directory.

IMPORTANT: Don't use `git -C <CWD>`, just use `git` without the `-C` command.

### Examples

- **Preferred**: `make -C /path/to/project`
- **Avoid**: `cd /path/to/project && make`

- **Preferred**: `pytest /path/to/tests`
- **Avoid**: `cd /path/to && pytest tests`

## Version control

- Include only "Co-Authored-By: Claude" in commit messages, not "Generated
  with..".

- Keep lines in commit messages no longer than 80 characters.

- NEVER AMEND COMMITS IF NOT INSTRUCTED TO. Use fixup commits instead.
