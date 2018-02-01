function emacs.custom
  # Load emacs using custom working directory.
  # -nw No window system. Run in terminal.
  # -q Inhibit loading of site-start.el and default.el that may be
  # pre-existing site-wide configurations. TODO this also ignores the init.el
  env HOME=$DOTFILES_ROOT/emacs/custom-attempt emacs #-nw
end



# update Vundle plugins
function vim.update
    set -lx SHELL (which sh)
    vim +BundleInstall! +BundleClean +qall
end



# TODO doesnt seem to work, try on mac, if no also remove vimrc plugin
function viman
  vim -c "Man $argv $argv" -c 'silent only'
end

