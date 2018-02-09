####################################################
# Here we source all files in the /shell directory.
####################################################

# Load pathfile
source $DOTFILES_ROOT/shell/pathfile

# Load nix
{% if os.mac %}
if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
  bass source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ^/dev/null
end
{% endif %}

{% if os.linux %}
if test -e $HOME/.nix-profile/etc/profile.d/nix.sh
  # If ~.nix-profile/sbin doesn't exist this will echo a warning.
  # To avoid seeing that we pipe its output to null.
  bass source $HOME/.nix-profile/etc/profile.d/nix.sh ^/dev/null
end
{% endif %}




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


#################################################################33

# TODO temp fix
set -x __BRYDOTS_DO_ONE_SHOT_SETUP 1

# These files run on boot
# /etc/rc.d/rc.local, and in Ubuntu, it is located in /etc/rc.local.
# TODO you would set __BRYDOTS_DO_ONE_SHOT_SETUP to zero here.

function _should_do_one_shot_setup
  [ $__BRYDOTS_DO_ONE_SHOT_SETUP = 1 ]
end

if not set -q __BRYDOTS_DO_ONE_SHOT_SETUP
  echo "Performing One Shot Setup"
  set -gx __BRYDOTS_DO_ONE_SHOT_SETUP 1
end



# TODO must fail with error msg if unkown hostname

set -gx __BRYDOTS_ENV_GEO 'home'

switch (hostname)
  case "dev-ncl*"
      set -gx __BRYDOTS_ENV_GEO 'work'
  case "*Linux*"
      set -gx __BRYDOTS_ENV_GEO '???'
end

# === Explicit Imports ===
source $DOTFILES_ROOT/bootstrap/index.fish
source $DOTFILES_ROOT/git/index.fish
source $DOTFILES_ROOT/nix/index.fish
