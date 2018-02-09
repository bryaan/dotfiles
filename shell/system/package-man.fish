####################################################
# osx
####################################################
if [ $__BRYDOTS_ENV_PLATFORM = "macos" ]

  # TODO use nix to install iterm2
  # iTerm2 Shell Integration
  if test -e ~/.iterm2_shell_integration.fish
    source ~/.iterm2_shell_integration.fish
  end

  #############################
  # Install/Update Commands
  ##############################

  abbr -a bi brew install
  abbr -a bs brew search

end


####################################################
# linux
####################################################

if [ $__BRYDOTS_ENV_PLATFORM = "linux" ]

  #############################
  # Install/Update Commands
  ##############################

  ## Fedora/RHEL/CentOS ##
  abbr -a yi sudo yum install
  abbr -a ys yum search
  abbr -a yu yum -y update

  ## Debian / Ubuntu ##
  # alias apt-get="sudo apt-get"
  # alias updatey="sudo apt-get --yes"
  # alias update='sudo apt-get update && sudo apt-get upgrade'

end
