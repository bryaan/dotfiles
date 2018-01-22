
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

############################################################################
# Program/System Shorcuts
############################################################################

# lsblk - Tree like view of block devices.
function idea
  run_silent ~/bin/idea-IU-173.4301.1/bin/idea.sh
end

function gitkraken
  run_silent /usr/local/src/gitkraken/gitkraken
end

function torrent
  transmission-cli -w ~/Downloads
end


# TODO Put this on cronjob.
# TODO Add to git repo.  Using whitelist: https://stackoverflow.com/questions/9162919/whitelisting-and-subdirectories-in-git
function backup.run
  eval $HOME/Desktop/runBackup
end
function backup.edit
  $VISUAL $HOME/Desktop/runBackup
end


# TODO Backup IntelliJ Settings
# Linux: .IntelliJIdea2017.2
# Use regex on first part.
# https://intellij-support.jetbrains.com/hc/en-us/community/posts/206381509-Export-settings-via-command-line-OS-X-

############################################################################
# dotfile edits
############################################################################

# alias dots.devrc='$EDITOR $DOTFILES_ROOT/shell/dev/aliases'
# alias deva='devrc'

# alias dots.zshrc='$EDITOR ~/.zshrc'
# alias dots.zshenv='$EDITOR ~/.zshenv'

############################################################################
# Terminator
############################################################################

function terminator.conf
  $VISUAL ~/.config/terminator/config
end

############################################################################
# Tmux
############################################################################

function tmux.conf
  $VISUAL ~/.tmux.conf
end

function tmux.reload
  tmux source-file ~/.tmux.conf
end

