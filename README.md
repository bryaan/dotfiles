


Anything with an extension of .symlink will get symlinked without extension into $HOME when you run script/bootstrap.



=========================================================

https://www.digitalocean.com/community/tutorials/how-to-use-git-to-manage-your-user-configuration-files-on-a-linux-vps



# Cloning To Setup Machine

# Download the .git but not any files.
cd ~/dotfiles
git clone --no-checkout http://git_lab_ip/your_gitlab_user/configs.git

# Set folder we want to extract repo into.
git config core.worktree "~"

# Force overwrite of any files currently present on machine with those from repo.
git reset --hard origin/master



# Updating Machine



=========================================================



bc we may need something other than direct extraction of all files, this git approach isnt going to work out best.



- still want .git repo in folder other than $HOME



- Project root:  src/dotfiles  
/home/bryan/.yadm/repo.git/


- better to use YADM's approach for multiple machines of labeling filename instead of using git branches becasue:
  - if we update a shared zshenv used on both machines, then we would have to update both git repos.  
    instead we use yadm and update a single file in single repo.  or if its machine cpecific it goes in a properly labeled file.



main bootstrap script goes in
$HOME/.yadm/bootstrap

This should add other bootstrap scripts.



Favorite Setup:
https://github.com/atelic/dotfiles

- Fractal folders.  So in zsh/ git/ etc we have an aliases file and other commons and specifics.
- All files ending in *.symlink, no matter where they are, are to be symlinked into home.
  - Directories should also work.  For example the dir /atom.symlink will be symlinked into $HOME/.atom


#!/usr/bin/env node console.log('hello world')




# TODO 

https://github.com/so-fancy/diff-so-fancy
- install and git config update (one liner to activate diff-so-fancy, or just add it in the general .gitconfig)

- Might be better to use a visual tool.
https://www.slant.co/topics/1324/~diff-tools-for-git




# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv