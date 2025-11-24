function mv
    command mv -iv $argv
end

function cp
    command cp -riv $argv
end

function mkdir
    command mkdir -pv $argv
end

if test (uname) != Darwin
    function ls
        command ls --color=auto --group-directories-first $argv
    end
end
