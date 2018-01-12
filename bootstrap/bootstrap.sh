#!/usr/bin/env bash

set -e

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# Sets DOTFILES_ROOT to where the dotfiles project was cloned on machine.
# Must expand to full path.
cd "$(dirname "$0")/.."
export DOTFILES_ROOT=$(pwd -P)

# Want to use both zsh and fish, or at minimum have setup ready.
compile_templates () {

  # TODO DRY Helper function.

  # TODO all compiled and otherwise, should be sent to their own directory.
  # add that dir to .gitignore

  local IsMac=false
  local IsLinux=false
  local IsWork=false

  if [[ $(hostname) == *"nclmiami.ncl.com"* ]]; then
    IsWork=true
  fi

  if [[ "$machine" == 'Linux' ]]; then
    IsLinux=true
  elif [[ "$machine" == 'Mac' ]]; then
    IsMac=true
  fi

  envvars="IsWork=\"$IsWork\" IsLinux=\"$IsLinux\" IsMac=\"$IsMac\""

  echo "  Template Vars:"
  echo "  $envvars"
  echo ""

  IsWork=$IsWork IsLinux=$IsLinux IsMac=$IsMac Shell="FISH" envtpl $DOTFILES_ROOT/shell/index.tpl -o $DOTFILES_ROOT/shell/index.fish
  IsWork=$IsWork IsLinux=$IsLinux IsMac=$IsMac Shell="ZSH" envtpl $DOTFILES_ROOT/shell/index.tpl -o $DOTFILES_ROOT/shell/index.zsh

  Shell="FISH" envtpl $DOTFILES_ROOT/shell/base/aliases.tpl -o $DOTFILES_ROOT/shell/base/aliases.fish
  Shell="ZSH" envtpl $DOTFILES_ROOT/shell/base/aliases.tpl -o $DOTFILES_ROOT/shell/base/aliases.zsh

  Shell="FISH" envtpl $DOTFILES_ROOT/shell/dev/aliases.tpl -o $DOTFILES_ROOT/shell/dev/aliases.fish
  Shell="ZSH" envtpl $DOTFILES_ROOT/shell/dev/aliases.tpl -o $DOTFILES_ROOT/shell/dev/aliases.zsh

  Shell="FISH" envtpl $DOTFILES_ROOT/shell/ncl/aliases.tpl -o $DOTFILES_ROOT/shell/ncl/aliases.fish
  Shell="ZSH" envtpl $DOTFILES_ROOT/shell/ncl/aliases.tpl -o $DOTFILES_ROOT/shell/ncl/aliases.zsh

}

# Copy fish shell configs over to its expected dir.
# Works on mac and linux.
link_fish_files () {
  if [[ "$machine" == 'Linux' ]]; then

    # Remove first so a recursive link doesn't get setup.
    rm -rf $HOME/.config/omf
    ln -sfn $DOTFILES_ROOT/fish $HOME/.config/omf

  elif [[ "$machine" == 'Mac' ]]; then
    for file in $(ls ./fish)
    do
      ln -sfn $DOTFILES_ROOT/fish/$file $HOME/.config/omf/$file
    done
  fi
}

####################################################
# Bootstrap
####################################################

compile_templates

echo '  [ ✔ ] templates compiled!'

sh bootstrap/install_dotfiles.sh

echo '  [ ✔ ] dotfiles installed!'

# Copy fish shell configs over to its expected dir.
if [ -d "$HOME/.config/omf" ]; then
  link_fish_files
fi

echo '  [ ✔ ] fish files installed!'

echo '  [ ✔ ] bootstrap complete!'
