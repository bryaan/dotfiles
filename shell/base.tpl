# TODO change usage to capital PLATFORM
# $PLATFORM should always be available and set only by us.
if [ "Linux" = (uname) ]
  setenv platform "linux"
else
  setenv platform "macos"
end
# switch (uname -a)
#     case "*Darwin*"
#         echo darwin stuff
#     case "*Linux*"
#         echo linux stuf
# end

# Resources
# https://github.com/jaagr/dots/blob/master/.aliases
#

# TODO rename file util.tpl and move setenv stuff to pathfile or index?

# TODO android.tpl
# add the adb backup commands.

################################################
# Environment Config
################################################

setenv EDITOR 'vim'
setenv VISUAL 'subl'
setenv GIT_EDITOR 'vim'
setenv SUDO_EDITOR 'vim'

setenv BROWSER "/usr/bin/google-chrome"
# /usr/bin/firefox
# /usr/bin/chrome-gnome-shell  # What is this?

setenv SSH_KEY_PATH "~/.ssh/rsa_id"

setenv FILTER 'fzf'  # used by `fisher omf/marlin`

setenv PAGER 'less'  # 'vimpager'
# can also pipe stdout into vim directly.
# setenv PAGER 'vim -Rn -'

# Uncomment the following line if you don't like systemctl's auto-paging feature:
setenv SYSTEMD_PAGER $PAGER

# vimpager not working well with manpages on linux. TODO check mac.
setenv MANPAGER 'less'

{% if os.linux %}
# set -x SHELL /usr/bin/fish
{% endif %}



################################################
# Local Utility Commands
################################################

function warn
  echo [Warning] $1
end

function warn.program-not-installed
  warn "Package '$1' Not Installed!\nAlternatively, check that it is available on your PATH.\n"
end

################################################
# Colorize TODO move to files.tpl?
################################################

# {% if os.linux %}
#   # alias ls='ls --color=auto'
#   #alias dir='ls --color=auto --format=vertical'
#   #alias vdir='ls --color=auto --format=long'

#   alias grep='grep --color=auto'
#   alias fgrep='fgrep --color=auto'
#   alias egrep='egrep --color=auto'
#   alias yum='yum --color=always'

# {% endif %}

# # TODO Must Install colorize.
# # ccze is much slower than colorize and hasnt been updated.
# # tail -f /var/my/log | color
# alias color='colorize'

if type --quiet colordiff
  alias diff='colordiff'
end


################################################
# Utility Commands
################################################

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

alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Open calc in math mode...?
alias bc='bc -l'


# TODO Copy prev commands.
# This copies the *args* from the previously run command.
# Ex. cd prev
# alias prev='​​!:1-$'
# Nvm this doesnt quite work.  What we need is something that
# either we exec, then it asks for the command.  but this is inflexible.
# Instead, do something like sudo where pressing a key twice will copy those args.
# And paste them at cursor.

# TODO sk # fkill - kill process
# fkill() {
#   ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
# }

# TODO move to util.tpl or to functions/util or each file.

# # Works on Mac and Linux
# function command_exists {
#   # this should be a very portable way of checking if something is on the path
#   # usage: "if command_exists foo; then echo it exists; fi"
#   type "$1" &> /dev/null
# }
#
function command_exists
  command -v $1 >/dev/null
  # Also there is type --quiet xxx, TODO what is diff?
end

# Note this is using sh, may need to be bash/fish depending on use.
function run_silent
  sh -c 'nohup "(echo $argv)" &>/dev/null 2>&1 &'
end

function rimraf
    rm -rf $argv
end

# Source file if it exists.
function source_if_exists
  set -l file $argv
  if test -e $file
    source $file
  end
end

# TODO this belongs in something like linux/set-defaults.sh
{% if os.linux %}
# Sets the keyrepeat rate; and hold delay before beginning repeat.
xset r rate 250 50
{% endif %}


# TODO add imagemagick to sys deps
set -x SCREENSHOT_DIR $HOME/Desktop/Screenshots
function screenshot
  set -l date (date +"%d-%m-%Y")
  set -l time (date +"%T")
  mkdir -p $SCREENSHOT_DIR
  import $SCREENSHOT_DIR/$date-$time.png
end
# gnome-screenshot -a



# Current User ID
set -l UID (id -u (whoami))

# Commands to proxy thru sudo when not su.
if [ UID != 0 ]
    alias reboot='sudo reboot'
    {% if os.linux %}
      alias update='sudo yum upgrade'
    {% endif %}
end

