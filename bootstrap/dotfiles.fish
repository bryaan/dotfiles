################################################
# Dotfile Dev Commands
################################################

abbr -a r reload

function dots
  cd $DOTFILES_ROOT; gulp
end

function dots.bootstrap
    cd $DOTFILES_ROOT; gulp bootstrap
end
