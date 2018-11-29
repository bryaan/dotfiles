# Set only this required var.
set -x DOTFILES_ROOT $HOME/src/dotfiles

# Import shell index file that imports everything else.
source $DOTFILES_ROOT/shell/index.fish
set -g fish_user_paths "/usr/local/opt/jpeg-turbo/bin" $fish_user_paths
