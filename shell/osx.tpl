####################################################
# osx
####################################################
{% if os.mac %}


# iTerm2 Shell Integration
if test -e ~/.iterm2_shell_integration.fish
  source ~/.iterm2_shell_integration.fish
end

#############################
# Install/Update Commands
##############################

abbr -a bi brew install
abbr -a bs brew search

{% endif %}


# TODO Move this to linux.tpl or os_linux.tpl os_mac.tpl

####################################################
# linux
####################################################

{% if os.linux %}

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

{% endif %}
