# Agents

## Repository layout

Files mirror their paths under `$HOME`; add new managed files to the matching
section of `lninstall.ini`.

## Platforms

These dotfiles are used on Arch Linux and Fedora Sway Spin, but not every
configuration applies to both systems.

## Conventions

- Follow `.editorconfig` and the conventions of nearby configuration files.

- Keep commits focused with short, imperative, component-scoped subjects.

- For AI-assisted commits, add `Assisted-by: Codex:<actual-model-identifier>`.
  Never add a `Signed-off-by` trailer on the user's behalf.

## Validation

Run `make check` after Lua or Neovim changes. Use an application's native
validation command for other configuration when available.

## Safety

- Do not run `make install` unless explicitly requested; it changes symlinks in
  the user's home directory.

- Never add credentials, private keys, tokens, or machine-specific secrets.
