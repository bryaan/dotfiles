
# Resources
# https://github.com/jaagr/dots/blob/master/.aliases
#

# TODO rename file util.tpl and move setenv stuff to pathfile or index?

# TODO android.tpl
# add the adb backup commands.

################################################
# Environment Config
################################################

setenv SHELL (which fish)
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

# Prevent MSFT things telemetry
# TODO Would be great to add IPs to block lists.
setenv DOTNET_CLI_TELEMETRY_OPTOUT '1'

################################################
# Startup Items
################################################

# TODO running this causes an annoying enter pw every terminal start, even though its only in one window.
# So only run it when you need it.  Or better yet there is a way to let ssh config use mac keychain.
#
# When first shell of session starts we start ssh-agent.
# Only one shell gets this message.
#
# if not [ -e /tmp/brydots.ssh_agent.lock ]
#   touch /tmp/brydots.ssh_agent.lock
#   ssh_agent_start
#   rm /tmp/brydots.ssh_agent.lock
# end

################################################
# Local Utility Commands
################################################

# TODO move to notify-util.fish ?
# combine with getopts to submenu errors?

function warn
  echo [Warning] $1
end

function warn.program-not-installed
  warn "Package '$1' Not Installed!\nAlternatively, check that it is available on your PATH.\n"
end

################################################
# Utility Commands
################################################

# alias su='sudo -i'
# alias su='sudo su -'

alias c='clear'
alias cl='clear; ll'
alias rr='reload'
alias e='eval $EDITOR'   # "Edit"
alias eg='eval $VISUAL'  # "Edit Gui"
alias b='eval $BROWSER'  # TODO? use ob for "Open Browser"


alias h='history'
alias j='jobs -l'

function path -d 'prints the $PATH'
  bash -c 'echo ${PATH//:/\\n}'
end

alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'


abbr -a reboot 'sudo reboot'
abbr -a poweroff 'sudo poweroff'
abbr -a halt 'sudo halt'
function hibernate
  systemctl --no-wall hybrid-sleep
end

################################################
# reloading
################################################

function reload
  clear; fish.reload
  # clear; spin fish.reload
end

function fish.reload -d "Reload fish process via exec, keeping some context"
  set -q CI; and return 0
  #clear; commandline -f repaint

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


# TODO add imagemagick to sys deps
set -x SCREENSHOT_DIR $HOME/Desktop/Screenshots
function screenshot
  set -l date (date +"%d-%m-%Y")
  set -l time (date +"%T")
  mkdir -p $SCREENSHOT_DIR
  import $SCREENSHOT_DIR/$date-$time.png
end
# gnome-screenshot -a


# # TODO Must Install colorize.
# # ccze is much slower than colorize and hasnt been updated.
# # tail -f /var/my/log | color
# alias color='colorize'

if type --quiet colordiff
  alias diff='colordiff'
end



# So that funced uses vim.
# https://github.com/fish-shell/fish-shell/issues/4677
function func
  funced --editor $EDITOR $argv
end
abbr -a funced 'funced --editor $EDITOR'


function fishhistory
  eval $EDITOR ~/.local/share/fish/fish_history
end

# Typing `!!<SPC>` will get it replaced with the previous cmd.
function bind_bang
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

# Typing `!$<SPC>` will get it replaced with the previous cmd's final arg.
function bind_dollar
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# If the command line has content, it prepends sudo.
# If there is no content, it prepends sudo to the last item in the history.
function prepend_command
  set -l prepend $argv[1]
  if test -z "$prepend"
    echo "prepend_command needs one argument."
    return 1
  end

  set -l cmd (commandline)
  if test -z "$cmd"
    commandline -r $history[1]
  end

  set -l old_cursor (commandline -C)
  commandline -C 0
  commandline -i "$prepend "
  commandline -C (math $old_cursor + (echo $prepend | wc -c))
end

