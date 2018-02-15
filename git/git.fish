# git/index.fish.tpl
#

source $DOTFILES_ROOT/git/git-functions.fish

####################################################
# git config
####################################################

# Check config with:  git config --list

if _should_do_one_shot_setup

  ln -sf $DOTFILES_ROOT/git/gitconfig $HOME/.gitconfig
  ln -sf $DOTFILES_ROOT/git/gitmessage $HOME/.gitmessage
  ln -sf $DOTFILES_ROOT/git/gitignore_global $HOME/.gitignore_global

  # TODO emails to secrets file?

  git config --global user.name 'Bryan A. Rivera'
  git config --global user.email 'mail@bryaan.com'

  if [ $__BRYDOTS_ENV_GEO = 'work' ]
    git config --global user.email 'brivera@ncl.com'
  end

  git config --global color.ui 'auto'
  git config --global core.editor 'subl -n --wait'

  # Global .gitignore file.
  git config --global core.excludesfile ~/.gitignore_global


  # git push will by default push all branches that have the same name on the remote.
  # To limit this behavior to just the current branch
  git config --global push.default tracking

  # Because branch merges in git are recorded with a merge commit,
  # they are supposed to be meaningful—for example, to indicate
  # when a feature has been merged to a release branch. However,
  # during a regular daily workflow where several team members
  # sync a single branch often, the timeline gets polluted with
  # unnecessary micro-merges on regular git pull.
  # Rebasing ensures that the commits are always re-applied so
  # that the history stays linear.
  #
  # Setup rebase for every *remote* tracking branch
  git config --global branch.autosetuprebase remote

#############################################
# Diff & Merge
#############################################

  # Makes `git diff` Pretty Print submodule info.
  git config --global diff.submodule log

  #   if commandExists diff-so-fancy
  #     git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
  #
  #     # Use diff-so-fancy as Textual Diff Tool
  #     git config --global diff.tool "diff-so-fancy | less --tabs=4 -RFX"
  #
  #   else
  #     warn.program-not-installed 'diff-so-fancy'
  #   end

  # The Textual diff tool to use.
  # TODO this or diff-so-fancy
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

end

