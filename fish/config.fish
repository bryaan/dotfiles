# Set only this required var.
set -x DOTFILES_ROOT $HOME/src/dotfiles

# Source our entry file.
# file that imports everything else.
source $DOTFILES_ROOT/shell/index.fish

# TODO Where did this come from or used in?
set -g fish_user_paths "/usr/local/opt/jpeg-turbo/bin" $fish_user_paths

