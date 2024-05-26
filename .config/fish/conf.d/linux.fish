function open
    command xdg-open $argv
end

function screenshot
    grim -g "(slurp)"
end
