
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

alias idea='runSilent ~/bin/idea-IU-173.4301.1/bin/idea.sh'
alias gitkraken='runSilent /usr/local/src/gitkraken/gitkraken'
# alias torrent='transmission-cli -w ~/Downloads '

# lsblk - Tree like view of block devices.


# TODO Only on systems with yum installed.
alias yi='sudo yum install'

# TODO Put this on cronjob.
# TODO Add to git repo.  Using whitelist: https://stackoverflow.com/questions/9162919/whitelisting-and-subdirectories-in-git
alias runBackup='$HOME/Desktop/runBackup'
alias editBackup='$EDITOR $HOME/Desktop/runBackup'

# TODO Backup IntelliJ Settings
# Linux: .IntelliJIdea2017.2
# Use regex on first part.
# https://intellij-support.jetbrains.com/hc/en-us/community/posts/206381509-Export-settings-via-command-line-OS-X-

############################################################################
# File Edit Shorcuts
############################################################################

alias devrc='$EDITOR $DOTFILES_ROOT/shell/dev/aliases'
alias deva='devrc'

alias zshrc='$EDITOR ~/.zshrc'
alias zshenv='$EDITOR ~/.zshenv'
alias zprofile='$EDITOR ~/.zprofile'
alias zpath='$EDITOR ~/.zpath'
alias ohmyzsh='$EDITOR ~/.oh-my-zsh/oh-my-zsh.sh'

alias terminatorconf='$EDITOR ~/.config/terminator/config'
alias tmuxconf='$EDITOR ~/.tmux.conf'


############################################################################
# Reloads
############################################################################

alias reloadTmux='tmux source-file ~/.tmux.conf'


