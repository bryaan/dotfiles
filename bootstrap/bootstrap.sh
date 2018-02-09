#!/usr/bin/env bash

set -e

# Sets DOTFILES_ROOT to where the dotfiles project was cloned on machine.
# Must expand to full path.
cd "$(dirname "$0")/.."
export DOTFILES_ROOT=$(pwd -P)

############################################################################
# Helpers
############################################################################

[ "Linux" = "$(uname)" ] && platform="linux" || platform="macos"
[ "x86_64" = "$(uname -m)" ] && arch="amd64" || arch="386"

success() {
  local msg="$1"
  echo "  [ ✔ ] $msg"
}

info() {
  local msg="$1"
  echo "  [ ℹ ] $msg"
}

warn() {
  local msg="$1"
  echo "  [ ✘ ] $msg"
}

warn_not_installed() {
  local program_name="$1"
  warn "\`$program_name\` is not installed."
}

############################################################################
# Functions
############################################################################

# Compile templates in ./shell to ./build/shell
compile_templates() {
  info 'compiling templates'
  info 'installing dotfiles'
  ./bootstrap/jinja_script.py
  success 'templates compiled!'
  success 'dotfiles installed!'
}

# Copy fish shell configs over to its expected dir.
# Only runs if fish is installed.
# Works on mac and linux.
setup_fish () {
  info 'installing fish files'
  if [ -d "$HOME/.config/fish/" ]; then
    # Link files in ./fish/ to ~/.config/fish/
    # Do not change method... Problems with recursive links and whatnot await.
    for file in $(ls $DOTFILES_ROOT/fish); do
      ln -sfn $DOTFILES_ROOT/fish/$file $HOME/.config/fish/$file
    done
    #
    # ln -sf $DOTFILES_ROOT/fish/fishfile $HOME/.config/fish/
    # ln -sf $DOTFILES_ROOT/fish/config.fish $HOME/.config/fish/

    # Make sure brew plugin is added to fishfile if we are on macos.
    if [[ "$platform" == 'macos' ]]; then
      LINE='oh-my-fish/plugin-brew'
      FILE=$DOTFILES_ROOT/fish/fishfile
      grep -qF "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
    fi
  else
    warn_not_installed "Fish Shell"
  fi
  success 'fish files installed!'
}

# TODO need to add symlink stuff for the sublime files.
# Pull section from readme.
# Only runs if sublime is installed.
setup_sublime() {
  info 'setting up sublime'
  # TODO Update with chnages
  # # This just links the subl binary to ~/.local/bin/
  # # Only needed on mac.
  # if [[ "$platform" == 'macos' ]]; then
  #   local subl_app_path="/Applications/Sublime Text.app"
  #   local subl_bin_path=$subl_app_path/Contents/SharedSupport/bin/subl
  #   if [ -d "$subl_app_path" ]; then
  #     ln -sf $subl_bin_path $HOME/.local/bin/
  #   else
  #     warn_not_installed "Sublime Text"
  #   fi
  # fi
  success 'sublime setup complete!'
}

setup_nixenv() {
  info 'setting up nix'
  mkdir -p $HOME/.nixpkgs/
  ln -sf $DOTFILES_ROOT/nix/* $HOME/.nixpkgs/
  success 'nix setup complete!'
}

# TODO Resolve vim bundles.
# Only package we need to automate install is vundle.
# So really just tell user to do a:
setup_vim() {
  info 'setting up vim'

  # Check test -d ~/.vim/bundle/Vundle.vim/ exists
  # If not tell user:
  # git clone <url> ~/.vim/bundle/Vundle.vim
# And only after that should the vimrc and other folders be synced.
# This means delete everything but bundle folder when symlinking.
  # ln -sfn $DOTFILES_ROOT/vim/* $HOME/.vim/

  success 'vim setup complete!'
}

# TODO Foreach folder in emacs/, build a workdir folder and symlink files in.
setup_emacs() {
  info 'setting up emacs'
  local workdir=$DOTFILES_ROOT/emacs/workdir/brymacs/.emacs.d
  mkdir -p $workdir
  ln -sf $DOTFILES_ROOT/emacs/brymacs/* $workdir
  success 'emacs setup complete!'
}

####################################################
# Bootstrap
####################################################

compile_templates
setup_fish
setup_sublime
setup_nixenv
# setup_vim # TODO fix
setup_emacs

success 'bootstrap complete!'
