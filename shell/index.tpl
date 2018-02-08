####################################################
# Here we source all files in the /shell directory.
####################################################

# Load pathfile
source $DOTFILES_ROOT/shell/pathfile

# === source compiled shell templates ===
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

# TODO so on build every folder except shell/functions/ gets copied to build/
# but that is kinda confusing.  Just copy functions as well, as the functions below are redundant

# === source fish functions ===
# Sources all *.fish files in shell/functions/
# Must come after above, as these funs' setup may depend on correct PATH setup.
set -l files (rg --files --follow --glob "*.fish" --glob "!.git/*" $DOTFILES_ROOT/shell/functions)
for file in $files
  source $file
end
