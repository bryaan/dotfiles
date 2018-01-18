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
  ./bootstrap/jinja_script.py
}

# Copy fish shell configs over to its expected dir.
# Only runs if fish is installed.
# Works on mac and linux.
setup_fish () {
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
}

# Only runs if sublime is installed.
# TODO Make work on linux.
setup_sublime() {
  if [[ "$platform" == 'macos' ]]; then
    local subl_app_path="/Applications/Sublime Text.app"
    local subl_bin_path=$subl_app_path/Contents/SharedSupport/bin/subl
    if [ -d "$subl_app_path" ]; then
      ln -sf $subl_bin_path $HOME/.local/bin/
    else
      warn_not_installed "Sublime Text"
    fi
  fi
}

####################################################
# Bootstrap
####################################################

info 'compiling templates'
compile_templates
success 'templates compiled!'

# TODO When there is a dotfile to make an overwrite choice on 
# the python script fails with no error output.
# We should quit with an informative error message to run the bootstrap/bootstrap.sh
# directly and then resume.
info 'installing dotfiles'
sh bootstrap/install_dotfiles.sh
success 'dotfiles installed!'

info 'installing fish files'
setup_fish
success 'fish files installed!'

info 'setting up sublime'
setup_sublime
success 'sublime setup complete!'

success 'bootstrap complete!'
