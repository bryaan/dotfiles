#!/usr/bin/env bash

# TODO all compiled and otherwise, should be sent to their own
# directory.  So that a clean command simply removes that directory.
# TODO add that dir to .gitignore

# Note This doesn't seem to set it globally.
# So we need to set manually somehwere.
# Sets DOTFILES_ROOT to where the dotfiles project was cloned on machine.
# Must expand to full path.
cd "$(dirname "$0")/.."
export DOTFILES_ROOT=$(pwd -P)

# Want to use both zsh and fish, or at minimum have setup ready.
compile_templates () {

  # TODO DRY Helper function.

  Shell="FISH" envtpl $DOTFILES_ROOT/shell/index.tpl -o $DOTFILES_ROOT/shell/index.fish
  Shell="ZSH" envtpl $DOTFILES_ROOT/shell/index.tpl -o $DOTFILES_ROOT/shell/index.zsh

  Shell="FISH" envtpl $DOTFILES_ROOT/shell/base/aliases.tpl -o $DOTFILES_ROOT/shell/base/aliases.fish
  Shell="ZSH" envtpl $DOTFILES_ROOT/shell/base/aliases.tpl -o $DOTFILES_ROOT/shell/base/aliases.zsh

  Shell="FISH" envtpl $DOTFILES_ROOT/shell/dev/aliases.tpl -o $DOTFILES_ROOT/shell/dev/aliases.fish
  Shell="ZSH" envtpl $DOTFILES_ROOT/shell/dev/aliases.tpl -o $DOTFILES_ROOT/shell/dev/aliases.zsh

  Shell="FISH" envtpl $DOTFILES_ROOT/shell/ncl/aliases.tpl -o $DOTFILES_ROOT/shell/ncl/aliases.fish
  Shell="ZSH" envtpl $DOTFILES_ROOT/shell/ncl/aliases.tpl -o $DOTFILES_ROOT/shell/ncl/aliases.zsh

}

####################################################
# Bootstrap
####################################################

compile_templates

sh ./bootstrap/install_dotfiles.sh

# Copy fish shell configs over to its expected dir.
# Works on mac and linux.
if [ -d "$HOME/.config/omf" ]; then
  for file in $(ls ./fish)
  do
    ln -sfn $DOTFILES_ROOT/fish/$file $HOME/.config/omf/$file
  done
fi

echo Bootstrap Complete!
