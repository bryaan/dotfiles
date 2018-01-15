####################################################
# git config
####################################################


# Check all configs with:  git config --list
git config --global user.name "Bryan A. Rivera"
git config --global user.email "mail@bryaan.com"
git config --global color.ui "auto"
git config --global core.editor "subl -n --wait"

{{if .IsWork}}

git config --global user.email "brivera@ncl.com"

{{end}}

#------------------------------------
# Setup diff-so-fancy
#------------------------------------
# Idea1: {template "func_if" "commandExists diff-so-fancy"}
# {template "ifCommandExists" "diff-so-fancy" "warn-not-installed"}}
#   git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

#   # Use diff-so-fancy as Textual Diff Tool
#   git config --global diff.tool "diff-so-fancy | less --tabs=4 -RFX"
# {end}}

# TODO Use generic interface like above, or call this file with bash-c or bass
{{if .IsZshShell}}
	if commandExists diff-so-fancy; then
	  git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

	  # Use diff-so-fancy as Textual Diff Tool
	  git config --global diff.tool "diff-so-fancy | less --tabs=4 -RFX"

	else
	  warnProgramNotInstalled 'diff-so-fancy'
	fi
{{end}}


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

alias gst="git status"
alias gco="git checkout"
alias gci="git commit"
alias gbr="git branch"

{{if .IsZshShell}}

# Deletes local snapshot copies of remote branches. refs/remotes/...
function clean_deleted_branches {

	# Deletes all stale remote-tracking branches under.
	# These stale branches have already been removed from the remote repository referenced by , but are still locally available in "remotes/".
	git remote prune origin

	# 1) List local git branches
	# 2) Filter git branches down to only those with deleted upstream/remote counterparts
	# 3) Pluck out branch names from output
	local branch_names=$(git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}')

	echo "[ . ] Local Copy Of Remote Branches to Delete:"
	echo $branch_names
	# $branch_names | xargs git branch -d # Doesnt work for some reason.

	echo "[ . ] Deleting Local Copy Of Remote Branches..."

	for branch in $branch_names; do
		echo $branch
		res=$(git branch -d $branch)
		echo $res
		# if [[ $res == "Deleted branch"* ]]; do
		# 	echo "[ ✔ ] S!"
		# fi
	done

	echo "[ ✔ ] Complete!"

	# To review before
	# branch_names | pb_copy
	# pbpaste | xargs git branch -d
}

{{end}}
