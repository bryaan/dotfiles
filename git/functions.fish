####################################################
# functions
####################################################

abbr -a gst git status
abbr -a gco git checkout
abbr -a gci git commit
abbr -a gbr git branch
abbr -a ga 'git add .'
abbr -a gp git push
abbr -a gpl git pull

function acp --description 'Add, commit and push'
  git add . # Git 2.x Stage All (new, modified, deleted) files
  # git add --all
  git commit -m $argv
  git push
end

function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | fzf | xargs git checkout
end

function fcoc -d "Fuzzy-find and checkout a commit"
  git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | xargs git checkout
end

# Deletes local snapshot copies of remote branches. refs/remotes/...
function clean_deleted_branches

  # Deletes all stale remote-tracking branches under.
  # These stale branches have already been removed from the remote repository referenced by , but are still locally available in "remotes/".
  git remote prune origin

  # 1) List local git branches
  # 2) Filter git branches down to only those with deleted upstream/remote counterparts
  # 3) Pluck out branch names from output
  set -l branch_names (git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}')

  echo "[ . ] Local Copy Of Remote Branches to Delete:"
  echo $branch_names
  # $branch_names | xargs git branch -d # Doesnt work for some reason.

  echo "[ . ] Deleting Local Copy Of Remote Branches..."

  for branch in $branch_names
    echo $branch
    res = (git branch -d $branch)
    echo $res
    # if [[ $res == "Deleted branch"* ]]; do
    #   echo "[ ✔ ] S!"
    # fi
  end

  echo "[ ✔ ] Complete!"

  # To review before
  # branch_names | pb_copy
  # pbpaste | xargs git branch -d
end


#################################
# git unstaging
#################################

# https://stackoverflow.com/questions/19730565/how-to-remove-files-from-git-staging-area

# Unstage all files.
function git.unstage.all --description 'Remove all files from staging area'
  # Explantion: git checkout replaces the file/dir that is in the workdir and
  # cache with the file specified. That means when using `.` the replacement will be the
  # same file that is already in the cache.  So this cmd has the effect of
  # keeping all files, as they are now, but removing them from staging.
  git checkout -- .
end

function git.unstage --description 'Remove given files from staging area'
  git checkout $argv
end

# TODO so what do these do differently?

function git.reset.staging.all --description 'Remove all files from staging area'
  git reset HEAD -- .
end

function git.reset.staging --description 'Remove given files from staging area'
  git reset HEAD -- $argv
end


# Undo                  With
#
# git add .             git reset
# git add <file>        git reset <file>


# Undo git add .
# With git reset

# Undo git add <file>
# With git reset <file>
