
# TODO fish upon entering a directory, runs a local .devrc (or something like that)
# which sets up functions used for that project.  This way we keep that stuff localt to project.



function fssh -d "Fuzzy-find ssh host and ssh into it"
  ag '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | xargs -o ssh
end

function fs -d "Switch tmux session"
  tmux list-sessions -F "#{session_name}" | fzf | xargs tmux switch-client -t
end


function ssh.classified --description='Log into remote server'
  ssh -t bryan@classified "export TERM=iterm2; fish"
end

################################################
# Program/System Shorcuts
################################################

# lsblk - Tree like view of block devices.
function idea
  sh ~/bin/idea-IU-173.4301.1/bin/idea.sh ^/dev/null &
end

function gitkraken
  # run_silent /usr/local/src/gitkraken/gitkraken
  sh /usr/local/src/gitkraken/gitkraken ^/dev/null &
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

