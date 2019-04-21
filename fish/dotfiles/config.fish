###
# This is the entrypoint - first file that is run.
#

set -x DOTFILES $HOME/src/dotfiles
set -x DOTFILES_ROOT $DOTFILES

# This first sources init.pathfile, then sources all other fish files.
source $DOTFILES/fish/shell/index.fish
