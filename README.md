These are my dotfiles at the moment.

I use these regularly on both MacOS and Arch Linux and aim for them to be
compatable with both operating systems.

Deployment can be done using my dotfile manager of choice, [dotbot][]:

    dotbot -c install.conf.yaml

Package lists for both Arch and Brew are located in `pkgs/`.

In `root/` I've put system-wide configuration files deemed valuable to have in
this repository. These can be deployed in the same manner as the other ones:

    sudo dotbot -c root/install.conf.yaml

[dotbot]: https://github.com/anishathalye/dotbot
