function __sk_find_file -d "List files and folders"
  # set -l commandline (__fzf_parse_commandline)
  # set -l dir $commandline[1]
  # set -l sk_query $commandline[2]

  # set -q FZF_FIND_FILE_COMMAND
  # or set -l FZF_FIND_FILE_COMMAND "
  # command find -L \$dir -mindepth 1 \\( -path \$dir'*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
  # -o -type f -print \
  # -o -type d -print \
  # -o -type l -print 2> /dev/null | sed 's@^\./@@'"


  set -l git_lookup_cmd "
    command git ls-tree -r --name-only HEAD \
      2> /dev/null "

  set -l rg_lookup_cmd "
    command rg --files  \
      --follow --glob '!.git/*' --glob '!Library/' \
      2> /dev/null"

  eval "$git_lookup_cmd or $rg_lookup_cmd | sed 's@^\./@@' | sort -k1 | "(__skcmd)


  # TODO https://github.com/lotabout/skim#as-interactive-interface

  # set -l SK_FIND_FILE_COMMAND "$git_lookup_cmd or $rg_lookup_cmd | sed 's@^\./@@'"

  # begin
    # eval "$SK_FIND_FILE_COMMAND | "(__skcmd) '--ansi -i -c "'$sk_query'"' | while read -l s; set results $results $s; end
  # end

  # if test -z "$results"
  #   commandline -f repaint
  #   return
  # else
  #   commandline -t ""
  # end

  # for result in $results
  #   commandline -it -- (string escape $result)
  #   commandline -it -- " "
  # end
  # commandline -f repaint
end


# # Set default FZF input to ripgrep.  Can also do ag.
# # Default is `find`.
# # The git ls-tree is to improve lookup speed in large repos.
# # --files: List files that would be searched but do not search
# # --no-ignore: Do not respect .gitignore, etc...
# # --hidden: Search hidden files and folders
# # --follow: Follow symlinks
# # --smartcase: Makes ripgrep search case-insensitively if the pattern is all lowercase, however if there is a capital the search becomes case-sensitive.
# # --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
# # TODO add --smartcase but it doesnt work in ~ folder for some reason.
# # TODO --hidden

