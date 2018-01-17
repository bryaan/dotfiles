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

# # Want to use both zsh and fish, or at minimum have setup ready.
# compile_templates () {

#   # TODO DRY Helper function.

#   # TODO all compiled and otherwise, should be sent to their own directory.
#   # add that dir to .gitignore

#   local IsMac=false
#   local IsLinux=false
#   local IsWork=false

#   if [[ $(hostname) == *"nclmiami.ncl.com"* ]]; then
#     IsWork=true
#   fi

#   if [[ "$machine" == 'Linux' ]]; then
#     IsLinux=true
#   elif [[ "$machine" == 'Mac' ]]; then
#     IsMac=true
#   fi

#   envvars="IsWork=\"$IsWork\" IsLinux=\"$IsLinux\" IsMac=\"$IsMac\""

#   echo "  Template Vars:"
#   echo "  $envvars"
#   echo ""

#   local buildroot="$DOTFILES_ROOT/build/shell"
#   local shellfileroot="$DOTFILES_ROOT/shell"

#   rm -rf $buildroot; mkdir -p $buildroot

#   local envprefix_fish="env IsWork=$IsWork IsLinux=$IsLinux IsMac=$IsMac IsFishShell=true IsZshShell="
#   local envprefix_zsh="env IsWork=$IsWork IsLinux=$IsLinux IsMac=$IsMac IsZshShell=true IsFishShell="

#   $envprefix_fish envtpl $shellfileroot/index.tpl -o $buildroot/index.fish
#   $envprefix_zsh  envtpl $shellfileroot/index.tpl -o $buildroot/index.zsh

#   $envprefix_fish envtpl $shellfileroot/base.tpl -o $buildroot/base.fish
#   $envprefix_zsh  envtpl $shellfileroot/base.tpl -o $buildroot/base.zsh

#   $envprefix_fish envtpl $shellfileroot/dev.tpl -o $buildroot/dev.fish
#   $envprefix_zsh  envtpl $shellfileroot/dev.tpl -o $buildroot/dev.zsh

#   $envprefix_fish envtpl $shellfileroot/git.tpl -o $buildroot/git.fish
#   $envprefix_zsh  envtpl $shellfileroot/git.tpl -o $buildroot/git.zsh

#   $envprefix_fish envtpl $shellfileroot/ncl.tpl -o $buildroot/ncl.fish
#   $envprefix_zsh  envtpl $shellfileroot/ncl.tpl -o $buildroot/ncl.zsh

# }

# Copy fish shell configs over to its expected dir.
# Works on mac and linux.
link_fish_files () {
  if [[ "$machine" == 'Linux' ]]; then

    # Remove first so a recursive link doesn't get setup.
    rm -rf $HOME/.config/omf
    ln -sfn $DOTFILES_ROOT/fish $HOME/.config/omf

    # TODO Migrate to fisherman on mac:
    # 1. Install fisherman.
    # 2. Copy fishfile and config.fish over
    # ln -sf $DOTFILES_ROOT/fish/fishfile $HOME/.config/fish/
    # ln -sf $DOTFILES_ROOT/fish/config.fish $HOME/.config/fish/
    # 3. `fisher` to isntall
    # 4. Delete the omf stuff.
    # omf destroy
    #
    # ll $HOME/.config/fish/

  elif [[ "$machine" == 'Mac' ]]; then

    # TODO enable me after fishfile exists
    # Make sure brew plugin is added if we are on Mac.
    # LINE='oh-my-fish/plugin-brew'
    # FILE=$DOTFILES_ROOT/fish/fishfile
    # grep -qF "$LINE" "$FILE" || echo "$LINE" >> "$FILE"


    # TODO Remove me or mod for fisherman
    for file in $(ls ./fish)
    do
      ln -sfn $DOTFILES_ROOT/fish/$file $HOME/.config/omf/$file
    done
  fi
}

####################################################
# Bootstrap
####################################################

# compile_templates
./bootstrap/jinja_script.py

echo '  [ ✔ ] templates compiled!'

sh bootstrap/install_dotfiles.sh

echo '  [ ✔ ] dotfiles installed!'

# Copy fish shell configs over to its expected dir.
if [ -d "$HOME/.config/omf" ]; then
  link_fish_files
fi

echo '  [ ✔ ] fish files installed!'

echo '  [ ✔ ] bootstrap complete!'

