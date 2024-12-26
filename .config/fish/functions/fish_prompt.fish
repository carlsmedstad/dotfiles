function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -q fish_color_status
    or set -g fish_color_status red

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
    set -l current_time (date "+%H:%M:%S")

    set -l prompt_optional_hostname ""
    if test "$SSH_CLIENT" -o "$SSH_TTY"
        set prompt_optional_hostname (hostname -s)"@"
    end

    set -l suffix '$'

    echo -n -s \
        (set_color "#fab387") $current_time " " \
        (set_color $fish_color_cwd) $prompt_optional_hostname (prompt_pwd) \
        (set_color normal) (fish_vcs_prompt) \
        " "$prompt_status " " \
        $suffix " "
end
