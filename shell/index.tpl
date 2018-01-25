####################################################
# Here we source all files in the /shell directory.
####################################################

{% if os.linux %}
set -x SHELL /usr/bin/fish
{% endif %}

# Load base PATH
source $DOTFILES_ROOT/shell/pathfile

# This is only set by our custom nix-shell command.
# If its here it should totally overright other stuff.
# if $NIX_PASSTHRU_PATH
	# echo $NIX_PASSTHRU_PATH
	# setenv PATH $NIX_PASSTHRU_PATH
# end

# Load various fish functions
source $DOTFILES_ROOT/shell/functions/ssh_agent_start.fish
source $DOTFILES_ROOT/shell/functions/append_path.fish

# Source all component files.
# TODO Need ability to order of import. Prepend with numbers?
# TODO What we do for subfolders is:
# 1. search for index.tpl file and source
# 2. search for file with same name as folder and source
# 3. source all files.
for file in (ls -1 $DOTFILES_ROOT/build/**/*.fish)
	# Don't import any index files. (recursive loop...)
	if [ $file != $DOTFILES_ROOT/build/**/index.fish ]
		# echo $file
		# echo $PATH
		source $file
	end
end

# Directory where shell files are built to.
# set -l shellfilesdir $DOTFILES_ROOT/build/shell
#
# Using bash -c *does not* bring over aliases.
# bash -c "source $shellfilesdir/ncl.zsh"


{% if os.linux %}
xset r rate 250 50
{% endif %}
