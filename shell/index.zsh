#!/usr/bin/env sh
#
# Here we source all files in the /shell directory.
#

# TODO !!!!!!!!!!!!!!

# only if FISH, or rather move to a paths file, or even
# use custom fun whose def changes dep on shell
# Take each arg and prepend to path, also impl a setpathap command that appends.
# setpath /usr/local/bin /usr/sbin
#
# set PATH /usr/local/bin /usr/sbin $PATH

# Also need to combine with .zpath file.



####################################################
# FISH
####################################################



####################################################
# ZSH
####################################################



# Works on Mac and Linux
function command_exists {
  # this should be a very portable way of checking if something is on the path
  # usage: "if command_exists foo; then echo it exists; fi"
  type "$1" &> /dev/null
}

# Purpose of wrapping it is so the local vars stay local.
namespaced_load() {

	local shellfilesdir=$DOTFILES_ROOT/shell

	source $shellfilesdir/base/aliases.zsh
	# source $shellfilesdir/base/functions.zsh

	source $shellfilesdir/dev/aliases.zsh
	# source $shellfilesdir/dev/functions.zsh

	source $shellfilesdir/ncl/aliases.zsh
	# source $shellfilesdir/ncl/functions.zsh


	## Setup dir_colors
	# TODO May need different files for Mac.
	local dir_colors_path=$DOTFILES_ROOT/shell/base/dir_colors

	# if [ command_exists dircolors ] && [ "$TERM" != "dumb" ] && [ -f $dir_colors_path ]; then
	#   eval "$(dircolors $dir_colors_path)"
	#   # Might need this on Mac:
	#   # eval "$(dircolors -b $dir_colors_path)"
	# fi

	# if [ command_exists gdircolors ]; then
	#   eval $(gdircolors ~/.dircolors/dircolors.256dark)
	# fi
}

namespaced_load




