
# Resources
# https://github.com/jaagr/dots/blob/master/.aliases
#

# TODO Move /shell to /fish

# TODO rename file util.tpl and move setenv stuff to pathfile or index?

################################################
# Environment Config
################################################

set --global SHELL (which fish)
setenv EDITOR 'vim'
setenv VISUAL 'subl'
setenv GIT_EDITOR 'vim'
setenv SUDO_EDITOR 'vim'

setenv BROWSER '/usr/bin/google-chrome'
# /usr/bin/firefox

setenv SSH_KEY_PATH '$HOME/.ssh/rsa_id'

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
# Misc
################################################

## Google Cloud SDK.
if [ -f ~/src/google-cloud-sdk/path.fish.inc ]; . ~/src/google-cloud-sdk/path.fish.inc; end

################################################
# Python
################################################

alias prp 'pipenv run python'

# Directory for all python venv(s)
# NOTE Must use $
setenv WORKON_HOME "$HOME/.virtualenvs"

# For VirtualFish a Python venv wrapper
eval (python -m virtualfish compat_aliases auto_activation)

eval (pipenv --completion)

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

# alias su 'sudo -i'
alias su 'sudo su -'

alias c 'clear'
alias cl 'clear; ll'
alias rr 'reload'
alias e 'eval $EDITOR'   # "Edit"
alias eg 'eval $VISUAL'  # "Edit Gui"
alias b 'eval $BROWSER'  # TODO? use ob for "Open Browser"

alias cleanbrew '$DOTFILES/os_macos/clean-brew.sh'

alias h 'history'
alias j 'jobs -l'

function path -d 'prints the $PATH'
  bash -c 'echo ${PATH//:/\\n}'
end

alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# To clear 'z' directory jumping history.
# rm ~/.local/share/z/data

abbr -a reboot 'sudo reboot'
abbr -a poweroff 'sudo poweroff'
abbr -a halt 'sudo halt'
function hibernate
  systemctl --no-wall hybrid-sleep
end

abbr -a r 'clear; reload'

function reload
  fish.hardreload
  # spin fish.hardreload
end

function fish.hardreload -d "Reload fish process via exec, keeping some context"
  set -q CI; and return 0
  #clear; commandline -f repaint

  # Keeping here just in case I want to change how history is saved.
  # history --save
  # set -gx dirprev $dirprev
  # set -gx dirnext $dirnext
  # set -gx dirstack $dirstack
  # set -gx fish_greeting ''

  exec fish
end

function fish.softreload
  source ~/.config/fish/config.fish
end

################################################
# Dotfile Dev Commands
################################################

function dots
  cd $DOTFILES; gulp
end

function dots.bootstrap
    #cd $DOTFILES; gulp bootstrap
    exec $DOTFILES/bootstrap/bootstrap.sh
end

################################################
# Misc
################################################

# TODO Implement this.
#set -x SCREENSHOT_DIR $HOME/Desktop/Screenshots
#
# function screenshot
#   set -l date (date +"%d-%m-%Y")
#   set -l time (date +"%T")
#   mkdir -p $SCREENSHOT_DIR
#   import $SCREENSHOT_DIR/$date-$time.png
# end
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


# TODO These are more generic and should be moved to single function files.
# TODO These are more generic and should be moved to single function files.

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

# # If the command line has content, it prepends sudo.
# # If there is no content, it prepends sudo to the last item in the history.
# function prepend_command
#   set -l prepend $argv[1]
#   if test -z "$prepend"
#     echo "prepend_command needs one argument."
#     return 1
#   end

#   set -l cmd (commandline)
#   if test -z "$cmd"
#     commandline -r $history[1]
#   end

#   set -l old_cursor (commandline -C)
#   commandline -C 0
#   commandline -i "$prepend "
#   commandline -C (math $old_cursor + (echo $prepend | wc -c))
# end

