#!/bin/bash
#
# [Inspired from](https://github.com/holman/dotfiles)
# https://github.com/holman/dotfiles/blob/master/script/bootstrap
#

set -e

# Note This doesn't seem to set it globally.
# So we need to set manually somehwere.
# Sets DOTFILES_ROOT to where the dotfiles project was cloned on machine.
# Must expand to full path.
cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}


link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

install_dotfiles () {
  info 'installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
}


# TODO all compiled and otherwise, should be sent to their own
# directory.  So that a clean command simply removes that directory.
# TODO add that dir to .gitignore

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
# Utility Commands
####################################################

compile_templates

install_dotfiles

# Copy fish shell configs over to its expected dir.
# TODO Only do this when FISH shell setup configured? Or when fish shell detected?
ln -sfn $DOTFILES_ROOT/fish $HOME/.config/omf


# # ### Wrapup ###
source ~/.zshenv
# reload &