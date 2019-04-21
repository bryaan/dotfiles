
# TODO auto install Vundle

# Create backup and swap dirs which are set in .vimrc
mkdir -p ~/.local/tmp/vim/backup
mkdir -p ~/.local/tmp/vim/swap
mkdir -p ~/.local/tmp/vim/undo

# Check test -d ~/.vim/bundle/Vundle.vim/ exists
# If not tell user:
# git clone <url> ~/.vim/bundle/Vundle.vim
# And only after that should the vimrc and other folders be synced.
# This means delete everything but bundle folder when symlinking.
# ln -sfn $DOTFILES/vim/* $HOME/.vim/

# TODO Install vundle plugins from command line, but when is this done?
# vim +PluginInstall +qall
