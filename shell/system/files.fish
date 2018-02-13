################################################
# exa, ls - File/Directory Structure & Size
################################################

alias ls='exa'
alias ll='exa --long --git --header'
alias l.='exa --all --long --git --header'
abbr -a tree 'exa --tree --level=2'

# TODO if exa not present.
# alias ll="ls -lh"
# alias l="ls -la"
# alias l.="ls -d .*"  # Show hidden files

# Create parent directories if not exist.
abbr -a mkdir 'mkdir -pv'


# TODO look into Z autojump and fzf-autojump
alias o='open.finder'

function open.finder
  if [ $__BRYDOTS_ENV_PLATFORM = 'linux' ]
    gnome-open $argv
  else if [ $__BRYDOTS_ENV_PLATFORM = 'macos' ]
    open $argv
  end
end

  # find -depth 1 . | begin read dirs
  #   echo $dirs
  # end
  # switch $argv
  #   case ''
  #     set -l paths '*'
  #   case '*'
  #     set -l paths $argv
  # end
################################################
# lsblk - Block Devices
################################################

# --all Include empty devices.
# --fs  Output info about filesystems.
abbr -a lsblk 'lsblk --all --fs'

################################################
# df, du - File System Structure & Size
################################################

# du
#   -h, --human-readable
#          print sizes in human readable format (e.g., 1K 234M 2G)
#   -c, --total
#          produce a grand total
#   -s, --summarize
#          display only a total for each argument

abbr -a df 'df -H -T'
# abbr -a du ' du -hcs *'




#> rg is apparently slower than find for directories.

# # Recursively gets all directories in current path.
# # By first getting all files, then extract path, and remove dups.
# function __get_dirs_recurse
#   rg --files --hidden --null | xargs -0 dirname | uniq
# end

# function yield
#     for a in $argv
#         printf '%s' $a
#         _yield
#     end
# end

# Gets all directories in current path.
function __get_dirs_in_cwd
  set dirs (find . -maxdepth 1 -type d)
  if [ "$dirs[1]" = "." ]
    set dirs $dirs[2..(count $dirs)]
  end
  echo $dirs
end

# # Gets all files and directories in current path.
# function __get_all_in_cwd
#   find . -maxdepth 1
# end

# # Recursively gets all files and directories in current path.
# function __get_all
#   find .
# end

# TODO wanted to see config file size of terminology


# du -hcs *
# > What this actually does is it interprets the wildcard as get all paths in cwd as list.
# Then it runs du -hcs /tmp/path1 /tmp/path2

# TODO Problems:
# - Fish shell cannot output arrays. This causes probs when passed to du.
#   If anything I would have to
#   remove the quotes around dirs retured from __get_dirs_in_cwd
#
# function du
#   echo 'Listing all directories...'
#   if not count $argv >/dev/null
#     set dirs (__get_dirs_in_cwd)
#   end
#   command du -hcs (string replace '\'' '' $dirs)
# end

# TODO Workaround:
# - perform du or someother fast file size function, on each
# directory, then create a custom formatted list.
# - Instead just use exa to say file size?  What does du do that exa doesnt anyway?
# - Might just want to write my own toolin fish, or in Rust? to print this info.

# TODO fish shell insert a variable but without the quotes.
# So this: du $dirs
# Doesn't become: du -hcs './foo ./bar'
# But: -hcs du ./foo ./bar

# List all directiores in current path with total size.
function du.dirs
  echo 'Listing all directories...'
  # check if any args were passed
  if not count $argv >/dev/null
    set dirs (find . -maxdepth 1 -type d)
    if [ "$dirs[1]" = "." ]
      set dirs $dirs[2..(count $dirs)]
    end
  end
  command du -hcs $dirs
end

# List all files and directiores in current path with total size.
# abbr -a du.all 'du -hcs .??* *'
function du.all
  echo 'Listing all files & directories...'
  # check if any args were passed
  if not count $argv >/dev/null
    set paths (__get_dirs)
  end
  # switch $argv
  #   case ''
  #     set -l paths '*'
  #   case '*'
  #     set -l paths $argv
  # end
  echo gg $paths
  command du -hcs "($paths)"
end

################################################
# Disk Mounting
################################################

# Make mount command output pretty and human readable format
abbr -a mount 'mount | column -t'


################################################
# Safety Nets
################################################

# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# NOTE fish shell doesn't append functions like bash does with aliases.
# fish handles aliases, but warns of infinite loop when appending later.
# workaround is to use aliases which fish respects like bash/zsh.
if [ $__BRYDOTS_ENV_PLATFORM = "linux" ]
  # do not delete / or prompt if deleting more than 3 files at a time #
  alias rm='rm -I --preserve-root'

  # Parenting changing perms on / #
  alias chown='chown --preserve-root'
  alias chmod='chmod --preserve-root'
  alias chgrp='chgrp --preserve-root'
end

