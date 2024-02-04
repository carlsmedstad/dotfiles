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

function nvim
    command nvim --startuptime /tmp/nvim-startuptime $argv
end

function open
    command xdg-open $argv
end

function gitprune
    git --no-pager branch --format='%(refname:short)' | xargs -n1 -I{} git branch -d {} 2>/dev/null
end

function gitfix
    git diff --name-only | uniq | xargs $EDITOR
end

function screenshot
    grim -g "(slurp)"
end

function podrun
    podman run --rm --interactive --tty --volume "(pwd):/pwd" --workdir /pwd $argv
end

function rga
    rg --glob='*' --glob='!.git' --glob='!build' $argv
end
