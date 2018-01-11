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
git config --global user.email "brivera@ncl.com" # TODO Should be label='work_ncl' specific.
git config --global color.ui "auto"
git config --global core.editor "subl -n -w"

#------------------------------------
# Setup diff-so-fancy
#------------------------------------
if commandExists diff-so-fancy; then
  git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
else
  warnProgramNotInstalled 'diff-so-fancy'
fi


############################################################################
# .devrc
############################################################################

alias reload='source ~/.zshenv && source ~/.zshrc'
alias reloadPath='source ~/.zpath'
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
