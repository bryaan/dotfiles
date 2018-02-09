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

