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


################################################
# ag, rg, find - Search Files & Directories
################################################

# Make rg'scolors look like ag's
alias rg='rg --colors line:fg:yellow --colors line:style:bold --colors path:fg:green --colors path:style:bold --colors match:fg:black --colors match:bg:yellow --colors match:style:nobold'



################################################
# Safety Nets
################################################

# TODO fish shell doesn't append functions like bash does with aliases.
# fish handles aliases, but warns of infinite loop when appending later.
#
# alias testaliasappend='echo aa '
#
# function testaliasappend
#   testaliasappend bb
# end


# TODO Solution: Move safety nets to same places they are called, or leave single alias.


# confirmation #
alias mv='echo aa '
alias cp='cp -i'
alias ln='ln -i'


{% if os.linux %}
  # do not delete / or prompt if deleting more than 3 files at a time #
  alias rm='rm -I --preserve-root'

  # Parenting changing perms on / #
  alias chown='chown --preserve-root'
  alias chmod='chmod --preserve-root'
  alias chgrp='chgrp --preserve-root'
{% endif %}

