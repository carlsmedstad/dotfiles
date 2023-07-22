# My Dotfiles

These are my dotfiles at the moment.

I use these regularly on both MacOS and Arch Linux and aim for them to be
compatible with both operating systems.

As much as possible is themed with [Catppuccin][].

[Catppuccin]: https://github.com/catppuccin/catppuccin

## Usage

Deployment can be done using my dotfile manager of choice, [dotbot][], and
[GNUMake][]:

```sh
make install-configs-user
```

In `system/` I've put system-wide configuration files deemed valuable to have
in this repository. These can be deployed in the same manner with the
`install-system` target:

```sh
sudo make install-configs-system
```

Package lists for both Arch and Brew are located in `pkgs/`.

[dotbot]: https://github.com/anishathalye/dotbot
[GNUMake]: https://www.gnu.org/software/make/
