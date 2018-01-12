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

{{if eq .Shell "FISH"}}

# Dunno why it wasnt set on my mac, same path on linux.
# Actually that was checked under zsh, maybe thats why.
set -x OMF_PATH $HOME/.local/share/omf

set -l shellfilesdir $DOTFILES_ROOT/shell
# set -l _SHELLFILESDIR $DOTFILES_ROOT/shell

source $shellfilesdir/base/aliases.fish
# source $shellfilesdir/base/functions.fish

# source $shellfilesdir/dev/aliases.fish
# source $shellfilesdir/dev/functions.fish

# source $shellfilesdir/ncl/aliases.fish
# source $shellfilesdir/ncl/functions.fish


####################################################
# `bobthefish` Theme Specific Settings
####################################################

# Number of chars to show in abbreviated path. 0=show full path
set -g fish_prompt_pwd_dir_length 3

# For the path rel to project root
set -g theme_project_dir_length 0

# The impl needs some work. => For Minikube it should only show when in a kubenetes project folder.
# If fixed, you can set this back to yes.
set -g theme_display_k8s_context no

set -g theme_display_ruby no
set -g theme_display_virtualenv yes
set -g theme_display_vagrant yes
set -g theme_display_docker_machine no

set -g theme_color_scheme dark
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_title_display_process no
set -g theme_newline_cursor no


{{end}}

####################################################
# ZSH
####################################################

{{if eq .Shell "ZSH"}}

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

{{end}}


