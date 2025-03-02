function mv
    command mv -iv $argv
end

function cp
    command cp -riv $argv
end

function mkdir
    command mkdir -pv $argv
end

function ls
    command ls --color=auto --group-directories-first $argv
end
