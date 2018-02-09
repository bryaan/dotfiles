################################################
# Dotfile Dev Commands
################################################

abbr -a r reload

function dots
  cd $DOTFILES_ROOT; gulp
end

function dots.bootstrap
  $DOTFILES_ROOT/bootstrap/bootstrap.sh
end
