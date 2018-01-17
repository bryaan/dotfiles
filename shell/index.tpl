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

# Bring nix-env and its packages into env.
# TODO causing a warning on fish start
bass source $HOME/.nix-profile/etc/profile.d/nix.sh
# We may only need to add a few things to our path:
# $HOME/.nix-profile/bin  $HOME/.nix-profile/sbin

####################################################
# FISH
####################################################

{% if shell.fish %}

# Dunno why it wasnt set on my mac, same path on linux.
# Actually that was checked under zsh, maybe thats why.
set -x OMF_PATH $HOME/.local/share/omf


# Load PATH
# TODO Rename to more generic file. 
# Possibly move into ./shell
# single files named by program and combined with their env vars and functions.
# > Using bash -c *does not* bring over aliases. (dont use them in zpath)
bash -c "source $HOME/.zpath"
# [[ -f ~/.zpath ]] && source ~/.zpath


set -l shellfilesdir $DOTFILES_ROOT/build/shell

# TODO Work on and uncomment files below
source $shellfilesdir/base.fish
source $shellfilesdir/git.fish
# source $shellfilesdir/dev.fish
# source $shellfilesdir/ncl.fish

# Using bash -c *does not* bring over aliases.
# TODO does `bass` ?
# bash -c "source $shellfilesdir/git.fish"


### asdf
if test -d $HOME/.asdf
	# On linux.
    source $HOME/.asdf/asdf.fish
    if not test -d ~/.config/fish/completions
    	mkdir -p ~/.config/fish/completions
    	# TODO should check if file exists first.
    	cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions
    end
else
	# On Mac, asdf installed by brew.
	source /usr/local/opt/asdf/asdf.fish
end



# Set default FZF input to ripgrep.  Can also do ag.
# Default is `find`.
# The git ls-tree is to improve lookup speed in large repos.
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --smartcase: Makes ripgrep search case-insensitively if the pattern is all lowercase, however if there is a capital the search becomes case-sensitive.
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
# TODO add --smartcase but it doesnt work in ~ folder for some reason.
set -x FZF_DEFAULT_COMMAND '(git ls-tree -r --name-only HEAD || rg --files --hidden --follow --glob "!.git/*" )'

# Add a file preview, with syntax highlighting.
# consider adding --reverse
# set -x FZF_DEFAULT_OPTS "--preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi -l {} || coderay {} || rougify {} || cat {})  2> /dev/null | head -500'"


# Apply to Ctrl-T command as well
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

set -x FZF_CTRL_R_COMMAND 'rg --files'

# rg can't search directories so use ag or bfs
# set -x  FZF_ALT_C_COMMAND "cd ~/; bfs -type d -nohidden | sed s/^\./~/"
set -x FZF_ALT_C_COMMAND "ag --ignore '.git' --ignore 'node_modules/' -g ."

# set -x FZF_ALT_C_OPTS "--preview 'tree -C {} | head -200'"

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


####################################################
# ZSH
####################################################

{% elif shell.zsh %}

# Works on Mac and Linux
function command_exists {
  # this should be a very portable way of checking if something is on the path
  # usage: "if command_exists foo; then echo it exists; fi"
  type "$1" &> /dev/null
}


# Load PATH
[[ -f ~/.zpath ]] && source ~/.zpath

# Purpose of wrapping it is so the local vars stay local.
namespaced_load() {

	local shellfilesdir=$DOTFILES_ROOT/build/shell

	source $shellfilesdir/base.zsh
	source $shellfilesdir/git.zsh
	source $shellfilesdir/dev.zsh
	source $shellfilesdir/ncl.zsh
}

namespaced_load

{% endif %}


