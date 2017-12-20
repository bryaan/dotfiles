# dotfiles

Anything with an extension of .symlink will get symlinked (without .symlink extension) into $HOME when you run ./install.sh.


=========================================================

## Cloning To Setup Machine

cd ~/src
git clone https://github.com/bryaan/dotfiles.git
./install.sh

## Updating Machine

cd ~/src/dotfiles
git pull
./install.sh

=========================================================

# TODO Common Software Install/Update Script
- pip install howdoi
- sublime settings.


# Discussion / TODO

bc we may need something other than direct extraction of all files, this git approach isnt going to work out best.

- still want .git repo in folder other than $HOME

- Project root:  src/dotfiles  
/home/bryan/.yadm/repo.git/


- better to use YADM's approach for multiple machines of labeling filename instead of using git branches becasue:
  - if we update a shared zshenv used on both machines, then we would have to update both git repos.  
    instead we use yadm and update a single file in single repo.  or if its machine cpecific it goes in a properly labeled file.
 

- Fractal folders.  So in zsh/ git/ etc we have an aliases file and other commons and specifics.
- All files ending in *.symlink, no matter where they are, are to be symlinked into home.
  - Directories should also work.  For example the dir /atom.symlink will be symlinked into $HOME/.atom


#!/usr/bin/env node console.log('hello world')




# TODO 

https://github.com/so-fancy/diff-so-fancy
- install and git config update (one liner to activate diff-so-fancy, or just add it in the general .gitconfig)

- Might be better to use a visual tool.
https://www.slant.co/topics/1324/~diff-tools-for-git



in ./install.sh  in link function, add option to stash changes in git, instead of backup with orig.backup
Also, would be nice to just let them be merged


To merge changes:
- first pull from remote, if breaking changes now will have to merge
- then run install if neccesaary to resymlink.


Specific Env Configs:
Detect appened env options similar to yadm
 


# REFS

https://www.digitalocean.com/community/tutorials/how-to-use-git-to-manage-your-user-configuration-files-on-a-linux-vps

https://github.com/holman/dotfiles

Favorite Setup:
https://github.com/atelic/dotfiles
