
# TODO can we get colors from `git br --all` to passthru to skim?
function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | sk | \
    while read branchName
      # TODO shouldn't this come *before* skim? Actually at very beginning?
      git fetch --all
      # The currently selected branch has a leading asterisk to indicate it is currently open,
      # This removes it so we have the path only.
      set -l branchName (echo $branchName | string replace '* ' '')
      switch $branchName
        case 'remotes/*/*'
          # In this case a remote branch was selected, a local copy will be made.
          # ie. most of the time it is `origin`
          set -l remoteName (echo $branchName | awk -F / '{ print $2 }')
          set -l remoteString "remotes/$remoteName/"
          set -l branchName (echo $branchName | string replace $remoteString '')
          # This works in the case: If the branch name you’re trying to checkout (a) doesn’t exist and (b) exactly matches a name on only one remote, Git will create a tracking branch for you:
          # So only when there is 1 remote pretty much. So lets make it more flexible with --track.
          # git checkout $branchName
          git checkout --track $remoteName/$branchName
          # Where --track is really short for:
          # git checkout -b $branchName $remoteName/$branchName
        case '*'
          # In this case it should be a local branch that was selected.
          git checkout $branchName
      end
    end
end

# TODO maybe same thing as above must be applied here?
function fcoc -d "Fuzzy-find and checkout a commit"
  git log --pretty=oneline --abbrev-commit --reverse | sk --tac --no-sort --exact | \
    awk '{print $1;}' | xargs git checkout
end
