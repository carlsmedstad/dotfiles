if status is-interactive
    set -U fish_color_cwd f9e2af
    set -g fish_sheme "Catppuccin Mocha"
    set -g fish_greeting ""
end

direnv hook fish | source
