####################################################
# git config
####################################################


# Check all configs with:  git config --list
git config --global user.name "Bryan A. Rivera"
git config --global user.email "mail@bryaan.com"

{% if geo.work %}
  git config --global user.email "brivera@ncl.com"
{% endif %}

git config --global color.ui "auto"
git config --global core.editor "subl -n --wait"

#   if commandExists diff-so-fancy
#     git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
#
#     # Use diff-so-fancy as Textual Diff Tool
#     git config --global diff.tool "diff-so-fancy | less --tabs=4 -RFX"
#
#   else
#     warnProgramNotInstalled 'diff-so-fancy'
#   end

# The Textual diff tool to use.
# Can use diff-so-fancy
git config --global diff.tool 'gvimdiff'

# Use Sublimerge as Diff Tool & Merge Tool
# TODO Verify sublimerge is installed before running.
git config --global diff.guitool 'sublimerge'
git config --global merge.tool 'sublimerge'

# Specify the command to invoke the specified diff tool.
# You can have multiple of them and pick at runtime with
# See the --tool=<tool> option above for more details.
git config --global difftool.sublimerge.cmd 'subl -n --wait "$REMOTE" "$LOCAL" --command "sublimerge_diff_views {\"left_read_only\": true, \"right_read_only\": true}'
git config --global mergetool.sublimerge.cmd 'subl -n --wait "$REMOTE" "$BASE" "$LOCAL" "$MERGED" --command "sublimerge_diff_views"'

# Use 3 way merge
git config --global merge.conflictstyle diff3

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
		# 	echo "[ ✔ ] S!"
		# fi
	end

	echo "[ ✔ ] Complete!"

	# To review before
	# branch_names | pb_copy
	# pbpaste | xargs git branch -d
end
