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

- Only amend commits to reword them, never to change the diff. Use fixup commits
  instead.

- Worktrees should be created as `$REPO_ROOT/.claude/worktrees/$branch_name`.

## GitHub

Never wrap lines in issues, comments or PR descriptions. This renders poorly,
let GitHub's Markdown rendered do the wrapping.
