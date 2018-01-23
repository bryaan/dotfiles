####################################################
# Here we source all files in the /shell directory.
####################################################

{% if os.linux %}
set -x SHELL /usr/bin/fish
{% endif %}

# Load base PATH
source $DOTFILES_ROOT/shell/pathfile
# bash -c "export PATH='';   echo $PATH"
# bash -c "export PATH=''; source $DOTFILES_ROOT/shell/pathfile; echo $PATH"

# Checks that the path exists before adding it.
function append_path
  set -l dir "$argv"
  set -x PATH $PATH "$dir"
  # TODO as workaround can check if path is already on before appending.
end

# Directory where shell files are built to.
set -l shellfilesdir $DOTFILES_ROOT/build/shell

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
		source $file
	end
end

# Using bash -c *does not* bring over aliases.
# bash -c "source $shellfilesdir/ncl.zsh"


