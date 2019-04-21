function __sk_cd -d "Change directory"
    set -l commandline (__sk_parse_commandline)
    set -l dir $commandline[1]
    # set -l sk_query $commandline[2]

    # This should set the var _flag_hidden
    set -l options  "h/hidden"
    argparse $options -- $argv

    set -l COMMAND

    # TODO sort order
    # root directories in current path come last. alphabetical.
    # then everything else on topa

    function __fd_find_dir
        command fd --follow --type d
    end

    function __fd_find_dir_with_hidden
        command fd --hidden --follow --type d
    end

    if set -q _flag_hidden
        set COMMAND __fd_find_dir_with_hidden
    else
        set COMMAND __fd_find_dir
    end

    eval "$COMMAND | " (__skcmd) | read -l select

    if not test -z "$select"
        cd "$select"

        # Remove last token from commandline.
        commandline -t ""
    end
    commandline -f repaint
end

# function __sk_cd -d "Change directory"
#     set -l commandline (__fzf_parse_commandline)
#     set -l dir $commandline[1]
#     set -l fzf_query $commandline[2]

#     set -l options  "h/hidden"

#     argparse $options -- $argv

#     set -l COMMAND

#     set -q FZF_CD_COMMAND
#     or set -l FZF_CD_COMMAND "
#     command find -L \$dir -mindepth 1 \\( -path \$dir'*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
#     -o -type d -print 2> /dev/null | sed 's@^\./@@'"

#     set -q FZF_CD_WITH_HIDDEN_COMMAND
#     or set -l FZF_CD_WITH_HIDDEN_COMMAND "
#     command find -L \$dir \
#     \\( -path '*/\\.git*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
#     -o -type d -print 2> /dev/null | sed 1d | cut -b3-"

#     if set -q _flag_hidden
#         set COMMAND $FZF_CD_WITH_HIDDEN_COMMAND
#     else
#         set COMMAND $FZF_CD_COMMAND
#     end

#     eval "$COMMAND | "(__fzfcmd)' +m --query "'$fzf_query'"' | read -l select

#     if not test -z "$select"
#         cd "$select"

#         # Remove last token from commandline.
#         commandline -t ""
#     end

#     commandline -f repaint
# end

# # Comes from somewhere else, pick whichever like better.
# function fzf-cdhist-widget -d 'cd to one of the previously visited locations'
#   # Clear non-existent folders from cdhist.
#   set -l buf
#   for i in (seq 1 (count $dirprev))
#     set -l dir $dirprev[$i]
#     if test -d $dir
#       set buf $buf $dir
#     end
#   end
#   set dirprev $buf
#   string join \n $dirprev | tac | sed 1d | eval (__fzfcmd) +m --tiebreak=index --toggle-sort=ctrl-r $FZF_CDHIST_OPTS | read -l result
#   [ "$result" ]; and cd $result
#   commandline -f repaint
# end
