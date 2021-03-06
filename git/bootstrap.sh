DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -sf $DIR/dotfiles/gitconfig $HOME/.gitconfig
ln -sf $DIR/dotfiles/gitmessage $HOME/.gitmessage
ln -sf $DIR/dotfiles/gitignore_global $HOME/.gitignore_global


# Check config with:  git config --list

#   # if [ $__BRYDOTS_ENV_GEO = 'work' ]
#   #   git config --global user.email 'brivera@ncl.com'
#   # end

#   # Global .gitignore file.
#   git config --global core.excludesfile ~/.gitignore_global

#   #   if commandExists diff-so-fancy
#   #     git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
#   #
#   #     # Use diff-so-fancy as Textual Diff Tool
#   #     git config --global diff.tool "diff-so-fancy | less --tabs=4 -RFX"
#   #
#   #   else
#   #     warn.program-not-installed 'diff-so-fancy'
#   #   end

#   # Use Sublimerge as Diff Tool & Merge Tool
#   # TODO Verify sublimerge is installed before running.
#   git config --global diff.guitool 'sublimerge'
#   git config --global merge.tool 'sublimerge'

#   # Specify the command to invoke the specified diff tool.
#   # You can have multiple of them and pick at runtime with
#   # See the --tool=<tool> option above for more details.
#   git config --global difftool.sublimerge.cmd 'subl -n --wait "$REMOTE" "$LOCAL" --command "sublimerge_diff_views {\"left_read_only\": true, \"right_read_only\": true}'
#   git config --global mergetool.sublimerge.cmd 'subl -n --wait "$REMOTE" "$BASE" "$LOCAL" "$MERGED" --command "sublimerge_diff_views"'
