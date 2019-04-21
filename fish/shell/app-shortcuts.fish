################################################
# Program/System Shorcuts
################################################

# lsblk - Tree like view of block devices.
function idea
  sh ~/bin/idea-IU-173.4301.1/bin/idea.sh ^/dev/null &
end

function gitkraken
  # silentrun /usr/local/src/gitkraken/gitkraken
  sh /usr/local/src/gitkraken/gitkraken ^/dev/null &
end


function terminator.conf
  eval $VISUAL ~/.config/terminator/config
end

function tmux.conf
  eval $VISUAL ~/.tmux.conf
end

function tmux.reload
  tmux source-file ~/.tmux.conf
end

# TODO should open gui calc
function calc
  bc -l
end


# TODO backup using borgbackup
# TODO- Put this on cronjob.
# TODO- https://stackoverflow.com/questions/9162919/whitelisting-and-subdirectories-in-git
function backup.run
  eval $HOME/Desktop/runBackup
end
function backup.edit
  $VISUAL $HOME/Desktop/runBackup
end






