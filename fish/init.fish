############################################################
#
############################################################

# set -l for_local_vars


set -x DOTFILES_ROOT ~/src/dotfiles

# Import shell index file that imports everything else.

source $DOTFILES_ROOT/shell/index.fish


set -l _SHELLFILESDIR $DOTFILES_ROOT/shell