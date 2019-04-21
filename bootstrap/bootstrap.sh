#!/usr/bin/env bash

set -e

# # Sets DOTFILES_ROOT to where the dotfiles project was cloned on machine.
# # Must expand to full path.
# cd "$(dirname "$0")/.."
# export DOTFILES=$(pwd -P)

DOTFILES=$HOME/src/dotfiles

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
 setup_fish() {
  info 'installing fish files'

  if [ -d "$HOME/.config/fish/" ]; then

    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    ln -sf $DIR/dotfiles/fishfile $HOME/.config/fish/fishfile
    ln -sf $DIR/dotfiles/config.fish $HOME/.config/fish/config.fish

    # I think the plugin doesn't care if its on windows.
    # # Make sure brew plugin is added to fishfile if we are on macos.
    # if [[ "$platform" == 'macos' ]]; then
    #   LINE='oh-my-fish/plugin-brew'
    #   FILE=$DOTFILES/fish/fishfile
    #   grep -qF "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
    # fi
  else
    warn_not_installed "fish shell"
  fi
  success 'fish files installed!'
}


# # TODO Foreach folder in emacs/, build a workdir folder and symlink files in.
# setup_emacs() {
#   info 'setting up emacs'
#   local workdir=$DOTFILES/emacs/workdir/brymacs/.emacs.d
#   mkdir -p $workdir
#   ln -sf $DOTFILES/emacs/brymacs/* $workdir
#   success 'emacs setup complete!'
# }

####################################################
# Bootstrap
####################################################

# compile_templates

info 'setting up fish shell'
if [ -d "$HOME/.config/fish/" ]; then

  ln -sf $DOTFILES/fish/dotfiles/fishfile $HOME/.config/fish/fishfile
  ln -sf $DOTFILES/fish/dotfiles/config.fish $HOME/.config/fish/config.fish

  # I think the plugin doesn't care if its on windows.
  # # Make sure brew plugin is added to fishfile if we are on macos.
  # if [[ "$platform" == 'macos' ]]; then
  #   LINE='oh-my-fish/plugin-brew'
  #   FILE=$DOTFILES/fish/fishfile
  #   grep -qF "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
  # fi
else
  warn_not_installed "fish shell"
fi

info 'setting up git'
source $DOTFILES/git/bootstrap.sh

# info 'setting up nix'
# source $DOTFILES/nix/bootstrap.sh

# info 'setting up sublime'
# source $DOTFILES/sublime/bootstrap.sh

# info 'setting up vim'
# source $DOTFILES/vim/bootstrap.sh # TODO Fix it

info 'setting up julia'
source $DOTFILES/languages/julia/bootstrap.sh


success 'bootstrap complete!'
