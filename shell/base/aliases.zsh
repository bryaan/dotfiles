#!/usr/bin/env sh

# Resources
# https://github.com/jaagr/dots/blob/master/.aliases
#

# Allows aliases to be run under sudo.
alias sudo='sudo '


####################################################
# Local Utility Commands
####################################################



  # Commands to proxy thru sudo when not su.
  if [ $UID -ne 0 ]; then
      alias reboot='sudo reboot'
      # TODO Only on when yum command present && linux
      alias update='sudo yum upgrade'
  fi

  warn() {
  	printf "[Warning] $1"
  }

  warnProgramNotInstalled() {
    warn "Package '$1' Not Installed!\nAlternatively, check that it is available on your PATH.\n"
  }

  ####################################################
  # Colorize
  ####################################################

  

  # TODO Must Install colorize.
  # ccze is much slower than colorize and hasnt been updated.
  # tail -f /var/my/log | color
  alias color='colorize'



####################################################
# Utility Commands
####################################################

alias c='clear'
alias cl='clear; ll'
alias edit='$EDITOR'
alias browser='$BROWSER'
alias hibernate='systemctl --no-wall hybrid-sleep'
alias h='history'
alias j='jobs -l'
# alias path='echo -e ${PATH//:/\\n}' # TODO make work with fish.
# TODO can do a simple fish for loop.
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
# alias su='sudo -i'

alias bi="brew install"
alias bs="brew search"

# the zsh seems to be neccessary on mac.
alias reload_dotfiles="zsh -e $DOTFILES_ROOT/bootstrap/bootstrap.sh; reload"


  alias reload='source ~/.zshenv && source ~/.zshrc'
  alias reloadPath='source ~/.zpath'


# TODO Copy prev commands.
# This copies the *args* from the previously run command.
# Ex. cd prev
# alias prev='​​!:1-$'
# Nvm this doesnt quite work.  What we need is something that
# either we exec, then it asks for the command.  but this is inflexible.
# Instead, do something like sudo where pressing a key twice will copy those args.
# And paste them at cursor.

alias vim="nvim"
alias vi="nvim"
alias gpg-decrypt-clipboard='xclip -o | gpg --decrypt | xclip'
alias reboot="sudo reboot"
alias poweroff="sudo poweroff"
alias halt="sudo halt"
alias tv="tvremote"

# TODO So dont put password here, pull password from system keyring.
# Linux
# secret-tool store --label='Password for mydrive' drive mydrive
# secret-tool lookup drive mydrive
# Mac
# security add-generic-password -a ${USER} -s playground -w `pwgen`
# security delete-generic-password -a ${USER} -s playground
# security find-generic-password -a ${USER} -s playground -w
alias rebootlinksys="curl -u 'admin:my-super-password' 'http://192.168.1.2/setup.cgi?todo=reboot'"

## replace mac with your actual server mac address #
# alias wakeupnas01='/usr/bin/wakeonlan 00:11:32:11:15:FC'

# TODO Check colordiff command exists.
alias diff='colordiff'

# Cryptographic Hashes
alias sha1='openssl sha1'


  commandExists() {
    command -v $1 >/dev/null
  }

  runSilent() {
    nohup "$@" &>/dev/null 2>&1 &
  }


# `--` on these doesnt work on macos.


alias ll="ls -lh"
alias l="ls -la"
alias l.="ls -d .*"  # Show hidden files

# Create parent directories if not exist.
alias mkdir='mkdir -pv'

# File System Structure & Size
alias df='df -H'
alias du='du -ch'

# Open calc in math mode...?
alias bc='bc -l'

# Make mount command output pretty and human readable format
alias mount='mount | column -t'

####################################################
# Net Test
####################################################

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'

# Show open ports.
alias ports='netstat -tulanp'

####################################################
# System Perf
####################################################

# top is atop, just like vi is vim
alias top='atop'

## pass options to free ##
alias meminfo='free -m -l -t'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'

## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

####################################################
# IpTables
####################################################

## shortcut  for iptables and pass it via sudo#
alias ipt='sudo /sbin/iptables'

# display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

####################################################
# Curl
####################################################

# get web server headers #
alias header='curl -I'

# find out if remote server supports gzip / mod_deflate or not #
alias headerc='curl -I --compress'

# Resume downloads by default
alias wget='wget -c'

####################################################
# Safety Nets
####################################################

# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'



####################################################
# For Debain
####################################################

# # distro specific  - Debian / Ubuntu and friends #
# # install with apt-get
# alias apt-get="sudo apt-get"
# alias updatey="sudo apt-get --yes"

# # update on one command
# alias update='sudo apt-get update && sudo apt-get upgrade'

## Fedora/RHEL/CentOS ##
alias update='yum update'
alias updatey='yum -y update'