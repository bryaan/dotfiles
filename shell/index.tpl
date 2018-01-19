#!/usr/bin/env sh
#
# Here we source all files in the /shell directory.
#


# setpath /usr/local/bin /usr/sbin
# set PATH /usr/local/bin /usr/sbin $PATH


####################################################
# FISH
####################################################

{% if shell.fish %}

# Load PATH
# TODO Rename to more generic file. 
# Possibly move into ./shell
# single files named by program and combined with their env vars and functions.
# > Using bash -c *does not* bring over aliases. (dont use them in zpath)
bass source $DOTFILES_ROOT/shell/pathfile

# Bring nix-env and its packages into env.
if test -e $HOME/.nix-profile/etc/profile.d/nix.sh
	# If ~.nix-profile/sbin doesn't exist this will echo a warning.
	# To avoid seeing that we pipe its output to null.
	bass source $HOME/.nix-profile/etc/profile.d/nix.sh ^/dev/null
end


set -l shellfilesdir $DOTFILES_ROOT/build/shell

# TODO Work on and uncomment files below
source $shellfilesdir/base.fish
source $shellfilesdir/git.fish
# source $shellfilesdir/dev.fish
source $shellfilesdir/ncl.fish

# Using bash -c *does not* bring over aliases.
# bash -c "source $shellfilesdir/ncl.zsh"



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

# TODO not working: https://github.com/junegunn/fzf/issues/1202
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

# Load PATH
[[ -f ~/.zpath ]] && source ~/.zpath

# Purpose of wrapping it is so the local vars stay local.
function load_shell_files() {

	local shellfilesdir=$DOTFILES_ROOT/build/shell

	source $shellfilesdir/base.zsh
	source $shellfilesdir/git.zsh
	source $shellfilesdir/dev.zsh
	# source $shellfilesdir/ncl.zsh
}

load_shell_files

{% endif %}


