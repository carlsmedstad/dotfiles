# Dotfiles

These are my dotfiles at the moment. This repository used to contain a lot
more, but I've migrated large portions of the configurations to _kits_, see
<https://github.com/carlsmedstad/kits>.

## Installation

Configurations can be installed as symlinks by running:

```sh
make install
```

Note, the install script which is called underneath, `lninstall`, will handle
conflicts in the following way:

- If a regular file exists at a target path, the script will exit with a failure.
- If a symlink exists at a target path, the script will overwrite it.

## Copyright

The contents of this repository are licensed under the
[Zero-Clause BSD license](https://spdx.org/licenses/0BSD.html).
