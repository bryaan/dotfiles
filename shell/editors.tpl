function emacs.custom
  # Load emacs using custom working directory.
  # -nw No window system. Run in terminal.
  # -q Inhibit loading of site-start.el and default.el that may be
  # pre-existing site-wide configurations. TODO this also ignores the init.el
  env OHOME=$HOME \
      HOME=$DOTFILES_ROOT/emacs/workdir/brymacs \
      emacs
end

function emacs.custom.nogui
  emacs.custom -nw
end

# Install Prelude to dotfiles workdir
# sh -c 'export PRELUDE_INSTALL_DIR="$DOTFILES_ROOT/emacs/workdir/prelude/.emacs.d" && curl -L https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh'

function prelude
  env OHOME=$HOME \
      HOME=$DOTFILES_ROOT/emacs/workdir/prelude \
      emacs
end


function brymacs
  emacs.custom
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

