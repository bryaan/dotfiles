############################################################
#
############################################################

# set -l for_local_vars

# Set ENV Vars
# TODO Unify Env Var Setting with devrc stuff
set -x DOTFILES_ROOT ~/src/dotfiles


# Import shell index file that imports everything else.
source $DOTFILES_ROOT/shell/index.fish


# asdf
source /usr/local/opt/asdf/asdf.fish
