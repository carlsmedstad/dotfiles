if status is-interactive
    for file in $XDG_CONFIG_HOME/fish/config.d/*
      source $file
    end
    set -U fish_color_cwd f9e2af
    set -g fish_sheme "Catppuccin Mocha"
    set -g fish_greeting ""
end
