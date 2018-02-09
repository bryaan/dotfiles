function __sk_parse_commandline -d 'Parse the current command line token and return split of existing filepath and rest of token'
    # eval is used to do shell expansion on paths
    set -l commandline (eval "printf '%s' "(commandline -t))

    if [ -z $commandline ]
        # Default to current directory with no --query
        set dir '.'
        set sk_query ''
    else
        set dir (__sk_get_dir $commandline)

        if [ "$dir" = "." -a (string sub -l 1 $commandline) != '.' ]
            # if $dir is "." but commandline is not a relative path, this means no file path found
            set sk_query $commandline
        else
            # Also remove trailing slash after dir, to "split" input properly
            set sk_query (string replace -r "^$dir/?" '' "$commandline")
        end
    end

    echo $dir
    echo $sk_query
end
