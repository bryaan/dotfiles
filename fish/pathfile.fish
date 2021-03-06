############################################################################
# pathfile - Set your $PATH here and never be left wondering again.
############################################################################

# TODO This file should be moved to bash.
# TODO This file should be moved to bash.

# Default Path
# Temporarily set to run basic shell utilities below.
set -x PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin

if [ "Linux" = (uname) ]
  set platform "linux"
else
  set platform "macos"
end
# [ "Linux" = (uname) ] && platform="linux" || platform="macos"
# [ "x86_64" = "$(uname -m)" ] && arch="amd64" || arch="386"


# TODO add a directory check before appending to path to avoid missing path errors.

# # FIXME For some very strange reason on macos + bash the directory test
# # will not work for any of these paths:
# # /usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
# function checkIfDirectory
#   if test -d $argv
#       return 1
#   else
#       return 0
#   end
# end

# Checks that the path exists before adding it.
function append_path
  set -l dir $argv
  # FIXME see `checkIfDirectory`  also fix shell/functions/append_path.fish
  # checkIfDirectory $dir && PATH=$PATH:$dir
  set --export TMPPATH $TMPPATH $argv
end

set --erase TMPPATH
set --export TMPPATH ''

############################################################################
# Linux
############################################################################

if [ $platform = 'linux' ]

  ### yarn ###
  append_path $HOME/.yarn/bin

  ### rust / cargo ###
  set -x CARGO_HOME $HOME/.cargo
  append_path $CARGO_HOME/bin

  ###################################
  # User
  ###################################

  ### User's Private Paths ###
  append_path $HOME/bin
  append_path $HOME/.local/bin

  ###################################
  # System
  ###################################

  # /opt  For non-system software.
  # /opt/local For un-vc'd, pre-compiled software.
  # /opt/local/bin For the binaries.
  # /opt/local/sbin For administrative binaries.

  # There should be no /opt/bin.  The local route is for stuff we don't
  # want to pull in via git.  If we do, then it goes in /opt/foo-project.
  # Config goes in /etc/opt/foo-project/xx.conf
  # Logs go in /var/opt/foo-project/xx.log

  # For non-system bundled software binaries.
  append_path /opt/local/bin
  # For administrative non-system bundled software binaries.
  append_path /opt/local/sbin

  ### Default Linux Paths ###
  append_path /usr/local/bin
  append_path /usr/bin/
  append_path /bin
  append_path /usr/local/sbin
  append_path /usr/sbin
  append_path /sbin

############################################################################
# Mac
############################################################################

else if [ $platform = 'macos' ]

  ### User's Private Paths ###
  append_path $HOME/bin # TODO delete me
  append_path $HOME/.local/bin

  ### rust / cargo ###
  set -x CARGO_HOME $HOME/.cargo
  append_path $CARGO_HOME/bin

  ### Default Mac Paths ###
  append_path /usr/local/bin
  append_path /usr/local/sbin
  append_path /usr/bin
  append_path /bin
  append_path /usr/sbin
  append_path /sbin

end

set --erase --global PATH
set --export PATH $TMPPATH
# set --erase TMPPATH
# set -g fish_user_paths "" $fish_user_paths

# TODO File a bug report on fish, show echos and outputs
# For some reason a `.` is being added to the beginning of PATH
# which seemingly occurs precisely when the path is set on line:
# `set -x PATH $TMPPATH`
# This line removes it.
# Could be that dot means current directory?
set PATH (string match -v . $PATH)

# TODO Read each path var and drop any with a dot. But also look for where
# /usr/local/opt/jpeg-turbo/bin bc maybe its there, but prob not.

# TODO move this to index.fish
# === Load nix ===
# Comes after above so PATH set by nix script isnt messed with
#
if [ $platform = 'linux' ]

  if test -e $HOME/.nix-profile/etc/profile.d/nix.sh
    bass source $HOME/.nix-profile/etc/profile.d/nix.sh ^/dev/null
  end

else if [ $platform = 'macos' ]
  # TODO This must be updated for Nix 2.x - no longer works.

  #if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  #  bass source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ^/dev/null
  #end
end
