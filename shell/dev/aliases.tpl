# https://www.alfredapp.com/
# https://github.com/sdegutis/hydra

# Gitkraken ssap
# hqfaf@slipry.net11


# sudo dmidecode --type chassis

# TODO Install/Check useful Gnome Shell Extensions
# - Desktop Scroller
# - Docker Integration
# - Jump List, but requires install of zeitgeist
# pip install howdoi

# Upgrades node+npm. Works great!
# npx dist-upgrade

# https://github.com/js-n/awesome-npx
# npx npm-check


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
if commandExists diff-so-fancy; then
  git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

  # Use diff-so-fancy as Textual Diff Tool
  git config --global diff.tool "diff-so-fancy | less --tabs=4 -RFX"

else
  warnProgramNotInstalled 'diff-so-fancy'
fi

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


# TODO Move to git.fish 
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


############################################################################
# .devrc
############################################################################

alias reloadTmux='tmux source-file ~/.tmux.conf'

alias devrc='$EDITOR $DOTFILES_ROOT/shell/dev/aliases'
alias deva='devrc'

alias zshrc='$EDITOR ~/.zshrc'
alias zshenv='$EDITOR ~/.zshenv'
alias zprofile='$EDITOR ~/.zprofile'
alias zpath='$EDITOR ~/.zpath'
alias ohmyzsh='$EDITOR ~/.oh-my-zsh/oh-my-zsh.sh'

alias terminatorconf='$EDITOR ~/.config/terminator/config'
alias tmuxconf='$EDITOR ~/.tmux.conf'
alias mux="rvm use ruby-2.4 && tmuxinator"

alias idea='runSilent ~/bin/idea-IU-173.4301.1/bin/idea.sh'
alias gitkraken='runSilent /usr/local/src/gitkraken/gitkraken'


alias yi='sudo yum install'
# alias torrent='transmission-cli -w ~/Downloads '
# lsblk - Tree like view of block devices.

# TODO Put this on cronjob.
# TODO Add to git repo.  Using whitelist: https://stackoverflow.com/questions/9162919/whitelisting-and-subdirectories-in-git
alias runBackup='/home/bryan/Desktop/runBackup'
alias editBackup='$EDITOR ~/Desktop/runBackup'

# TODO Backup IntelliJ Settings
# Linux: .IntelliJIdea2017.2
# Use regex on first part.
# https://intellij-support.jetbrains.com/hc/en-us/community/posts/206381509-Export-settings-via-command-line-OS-X-
