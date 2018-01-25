#!/usr/bin/env sh

# Resources
# https://github.com/jaagr/dots/blob/master/.aliases
#

setenv EDITOR 'kak'
setenv VISUAL 'subl'
setenv GIT_EDITOR 'kak'
setenv SUDO_EDITOR 'kak'
setenv FILTER 'fzf'  # used by `fisher omf/marlin`

setenv BROWSER "/usr/bin/google-chrome"
# /usr/bin/firefox
# /usr/bin/chrome-gnome-shell  # What is this?

setenv SSH_KEY_PATH "~/.ssh/rsa_id"


setenv PAGER 'vimpager'
# TODO can pipe stdout into vim directly.
# setenv PAGER 'vim -Rn -'

# Uncomment the following line if you don't like systemctl's auto-paging feature:
setenv SYSTEMD_PAGER $PAGER
# vimpager not working well with manpages on linux.
# TODO check mac.
setenv MANPAGER 'less'

####################################################
# Dotfile Dev Commands
####################################################

abbr -a r reload

function dots
  cd $DOTFILES_ROOT; gulp
end
function dots.bootstrap
  $DOTFILES_ROOT/bootstrap/bootstrap.sh
end
function reload
  clear; fish.reload
  # clear; spin fish.reload
end
function fish.reload -d "Reload fish process via exec, keeping some context"
  set -q CI; and return 0
  # see what those vars do. And i thinks history is getting saved already.
  # history --save
  # set -gx dirprev $dirprev
  # set -gx dirnext $dirnext
  # set -gx dirstack $dirstack
  # set -gx fish_greeting ''
  exec fish
end
function fish.reload.soft
  source ~/.config/fish/config.fish
end
# TODO reload.terminals

# update Vundle plugins
function vim.update
    set -lx SHELL (which sh)
    vim +BundleInstall! +BundleClean +qall
end

####################################################
# Local Utility Commands
####################################################

# Current User ID
set -l UID (id -u (whoami))

# Commands to proxy thru sudo when not su.
if [ UID != 0 ]
    alias reboot='sudo reboot'
    {% if os.linux %}
      alias update='sudo yum upgrade'
    {% endif %}
end

function warn
  echo [Warning] $1
end

function warnProgramNotInstalled
  warn "Package '$1' Not Installed!\nAlternatively, check that it is available on your PATH.\n"
end

####################################################
# Colorize
####################################################

# Make rg'scolors look like ag's
alias rg='rg --colors line:fg:yellow --colors line:style:bold --colors path:fg:green --colors path:style:bold --colors match:fg:black --colors match:bg:yellow --colors match:style:nobold'

# {% if os.linux %}
#   # alias ls='ls --color=auto'
#   #alias dir='ls --color=auto --format=vertical'
#   #alias vdir='ls --color=auto --format=long'

#   alias grep='grep --color=auto'
#   alias fgrep='fgrep --color=auto'
#   alias egrep='egrep --color=auto'
#   alias yum='yum --color=always'

#   # TODO Check colordiff command exists.
#   alias diff='colordiff'

# {% endif %}

# # TODO Must Install colorize.
# # ccze is much slower than colorize and hasnt been updated.
# # tail -f /var/my/log | color
# alias color='colorize'

if type --quiet colordiff
  alias diff='colordiff'
end


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
# alias path='echo -e ${PATH//:/\\n}'
# TODO make work with fish. - fish has its own way of showing path.
# alias su='sudo -i'

abbr -a reboot 'sudo reboot'
abbr -a poweroff 'sudo poweroff'
abbr -a halt 'sudo halt'
alias tv='tvremote'

# TODO doesnt seem to work, try on mac, if no also remove vimrc plugin
function viman
  vim -c "Man $argv $argv" -c 'silent only'
end

# alias vim="nvim"
# alias vi="nvim"

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
# alias wakeupnas01='/usr/bin/wakeonlan 00:11:22:33:44:FC'


# # Works on Mac and Linux
# function command_exists {
#   # this should be a very portable way of checking if something is on the path
#   # usage: "if command_exists foo; then echo it exists; fi"
#   type "$1" &> /dev/null
# }
#
function command_exists
  command -v $1 >/dev/null
end

# Note this is using sh, may need to be bash/fish depending on use.
function run_silent
  sh -c 'nohup "$@" &>/dev/null 2>&1 &'
end

function rimraf
    rm -rf $argv
end



function fssh -d "Fuzzy-find ssh host and ssh into it"
  ag '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | xargs -o ssh
end

function fs -d "Switch tmux session"
  tmux list-sessions -F "#{session_name}" | fzf | xargs tmux switch-client -t
end

function fpass -d "Fuzzy-find a Lastpass entry and copy the password"
  if not lpass status -q
    lpass login $EMAIL
  end

  if not lpass status -q
    exit
  end

  lpass ls | fzf | string replace -r -a '.+\[id: (\d+)\]' '$1' | xargs lpass show -c --password
end



  # function fish_user_key_bindings
  #   bind \cs 'prepend_command sudo'
  #   bind ! bind_bang
  #   bind '$' bind_dollar

  #   bind \cb fzf-bcd-widget

  #   # If using vi or hybrid mode must specift insert mode.
  #   # fish_hybrid_key_bindings
  #   # bind -M insert ! bind_bang
  #   # bind -M insert '$' bind_dollar
  # end


# TODO Copy prev commands.
# This copies the *args* from the previously run command.
# Ex. cd prev
# alias prev='​​!:1-$'
# Nvm this doesnt quite work.  What we need is something that
# either we exec, then it asks for the command.  but this is inflexible.
# Instead, do something like sudo where pressing a key twice will copy those args.
# And paste them at cursor.


####################################################
# Built-in Commands
####################################################

alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

### Directory Structure & Size ###
alias ls='exa'
alias ll='exa --long --git --header'
alias l.='exa --all --long --git --header'
abbr -a tree 'exa --tree --level=2'

# Don't need these since using `exa`
# alias ll="ls -lh"
# alias l="ls -la"
# alias l.="ls -d .*"  # Show hidden files

# Create parent directories if not exist.
abbr -a mkdir 'mkdir -pv'

### File System Structure & Size ###
abbr -a df 'df -H'
abbr -a du 'du -ch'
# List all files and folders in current directory with size.
abbr -a du.all 'du -shc .??* *'

# Open calc in math mode...?
alias bc='bc -l'

### Disk Mounting ###
# Make mount command output pretty and human readable format
abbr -a mount 'mount | column -t'

### ss - Socket Statistics ###
# By default only CONNECTED sockets will show
# with `-a` both CONNECTED and LISTENING will show.
abbr -a ss.tcp 'ss -A tcp'
abbr -a ss.udp 'ss -a -A udp'
abbr -a ss.unix 'ss -A unix'
abbr -a ss.tcp.listening 'ss -ltn'
abbr -a ss.udp.listening 'ss -lun'

### ps - Process Status ###
# Usage: pid.info <pid>
abbr -a pid.info 'ps -Flww -p'


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


{% if os.linux %}
  # do not delete / or prompt if deleting more than 3 files at a time #
  alias rm='rm -I --preserve-root'

  # Parenting changing perms on / #
  alias chown='chown --preserve-root'
  alias chmod='chmod --preserve-root'
  alias chgrp='chgrp --preserve-root'
{% endif %}
