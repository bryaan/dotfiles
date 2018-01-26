# dotfiles

**Makes me feel at $HOME**

Anything with an extension of .symlink will get symlinked (without .symlink extension) into $HOME when you run ./install.sh.


# Resources

[OMF Packages](https://github.com/oh-my-fish/packages-main/tree/master/packages)

https://github.com/holman/dotfiles

https://github.com/atelic/dotfiles

https://fishshell.com/docs/current/index.html#redirects
https://github.com/JorgeBucaran/fish-shell-cookbook#how-to-redirect-stdout-or-stderr-to-a-file-in-fish

https://github.com/fisherman/getopts


# Setup

Must have the nix package manager installed.

## Development
```bash
cd $DOTFILES
nix-shell
nix-shell --command 'env HOME=/tmp/foo fish'
yarn install
gulp
```

## Cloning To Setup Machine
```bash
cd $DOTFILES
git clone ...
git submodule init
git submodule update
dots.bootstrap; reload
```

## Updating Machines
```bash
cd $DOTFILES
git pull; dots.bootstrap; reload
```

### To update submodules:
```bash
git submodule update --remote
git submodule update --remote <submodule-repo-name>
```


# Misc

## Adding asdf plugins
asdf plugin-add golang
asdf install golang 1.9.2
asdf global golang 1.9.2


# Shortcuts

Fish:
Ctrl+S => sudo insert

Ctrl-A => Home button
Ctrl-E => End Button

RightArrow or Tab: To autcomplete cmd.
Ctrl+RightArrow: To autocomplete word by word.

Note that erasing from history doesn't require bash shenanigans:

history --delete --prefix some_command
fish_config history also lets you do it by point-n-click.

------------------------------------------------------------------------------

# Linking Sublime Settings
TODO Move this section to bootstrap script.

May need to run" Package Control: Upgrade/Overide All Packages"
to install packages when complete.

> Must first be removed so child folders will link properly.

Must be setup in such a way that when sublime adds/removes packages or settings, those changes will appear in our dotifles repo. This can only work when the parent directory is symlinked, do not symlink all files in folder as that would not satisfy the latter.

## For Linux
```bash
rm -rf $HOME/.config/sublime-text-3/Packages/User; ln -sfn $DOTFILES_ROOT/sublime/ $HOME/.config/sublime-text-3/Packages/User
```

## For Mac
```fish
set DOTFILES_ROOT $HOME/src/dotfiles
set -l subldirbase /Users/bryan/Library/Application\ Support/Sublime\ Text\ 3/Packages/

rm -rf $subldirbase; mkdir $subldirbase; ln -s $DOTFILES_ROOT/sublime $subldirbase

need this bc folder needs to be named 'User', but want an informative 'sublime' here.
mv $subldirbase/sublime $subldirbase/User
```

------------------------------------------------------------------------------

# TODO Auto Software/System Updates

# Cron to periodically ask about updating, that is if fish doesnt ask
# automatically like zsh. Ideally it should trigger a flag, and next time an interactive prompt is opned the user should be asked (try to make sure the shell isnt execing a command, but that the proc is /usr/bin/zsh or similar)

# update fish/fisherman
fisher up

# update fish completions  `fish_update_completions`
to parse man pages and gernate new completions.
They go in ~/.config/fish/completions

# update sublime and packages
sublime: install/update all packages


Update all plugins
asdf plugin-update --all

Update asdf itself
asdf update


Sublime Update:

May need to run" Package Control: Upgrade/Overide All Packages"
to install packages when complete.

------------------------------------------------------------------------------


Check out whether to use z or fzf-autojump
https://github.com/wting/autojump
https://github.com/rominf/omf-plugin-fzf-autojump

# TODO Bring iterm settings into dotfiles.
# Fix Alt-C on Mac
53:NOTE: On OS X, Alt-c (Option-c) types ç by default. In iTerm2, you can send the right escape sequence with Esc-c. If you configure the option key to act as +Esc (iTerm2 Preferences > Profiles > Default > Keys > Left option (⌥) acts as: > +Esc), then alt-c will work for fzf as documented.

------------------------------------------------------------------------------

https://github.com/peco/peco
peco can be a great tool to filter stuff like logs, process stats, find files, because unlike grep, you can type as you think and look through the current result

Searching file contents
with ag - respects .agignore and .gitignore
try this with peco

ag --nobreak --nonumbers --noheading . | fzf


TODO Copy fish PATH to bash. 
from fish:
must format the space delimited to colon delimited, then inject:
bash -c "export PATH=$fmt_path"

programs that call the bash shell, but havent run into anything yet so maybe not)
Add a source 'file' line in .bashrc.
The target file is written to by fish, on demand, with PATH setting code.
Impl: Pick a target pattern to delimit code from where path string goes,
fish script finds that line number, erases anything below,
then appends a colon seperated list of directories.


TODO create an .agignore file for ag searches
also check if rg has the same.

TODO add an `opendir` alias that will open current or given dir in system's finder.

TODO Do we need to:
chmod +x ./bootstrap/bootstrap.sh
chmod +x ./bootstrap/jinja_script.py

TODO Bring zsh aliases (and completions via bass?) over to fish.
- Make them fish abbreviations.
- via bass or better yet by copy paste so we know what we've got.

TODO create a `sublime commands` file for easy goto readme and stuff

TODO switch task runner from gulp to python?
pip install watchdog

TODO add brew, cask, chrome, etc examples from
https://github.com/junegunn/fzf/wiki/examples

TODO That doc book generator for dotfiles and mac setup.  
`gitbook`.
http://sourabhbajaj.com/mac-setup/iTerm/zsh.html
also krypton support ref?

TODO https://github.com/aio-libs/aiomonitor
python event loop manager


# TODO Vinyl - cloud file system
https://github.com/gulpjs/vinyl-fs
can use this with tibra data so large data files can reside off git.
then project is copied somewhere, then when at location, it downloads what is required.
- added benefit we keep skeleton files in repo so we know they exist.

also research this vs git-lfs, pretty sure this is way more flexible, indeed we should be able to write a git-lfs backend for vinyl.


# TODO My history requirements
- All commands enetered in any terminal should be added, in order of runtime, to a global shared history file.
- However the current history of any given shell should only be those commands that were run in it. (Up arrow search should pull from local history)
- However if we search in one shell for a command just run in the other, we should be able to find it. (history search should pull from the global file)
- TODO Only successful commands should be saved in history. (or reallly i think i mean those commands run without spelling error)
  - but still allow pressing up to modify typo in last command
  - delete only after a certain # lines, or cronjob.
  - errord cmd history line numbers must be saved to another file so we know which lines to delete later on cleanup.

https://unix.stackexchange.com/questions/41739/keep-only-successful-commands-in-bash-history
- some other approach




------------------------------------------------
https://github.com/sdegutis/hydra

------------------------------------------------

# install list
nix-env
nix-env -iA nixos.emacs
nix-env -i yarn
fish
git
pip install ripgrep
pip install glances
vimpager - from github compile
cargo install exa
yarn global add gulp tern

# Mac install list

TODO alfred
https://www.alfredapp.com/

brew install nvim vimpager
brew install glances kak
brew install ag ripgrep fzf
bi yarn
sublime?

highlight check works with fzf preview

brew cask install virtualbox
brew cask install virtualbox-extension-pack

## Dependency Notes
spacemacs requirements:
emacs - a recent version
tern - for the js layer

# RHEL 7
nix-env -i gcc-wrapper-7.2.0
nix-env -iA nixpkgs.fish

### PackageDev
https://github.com/SublimeText/PackageDev
To make tools avialble under Tools → Packages → Package Development,

### HighlightWords

### sublimerge
- and also the binary download



fish
asdf
- Recommnded Pkgs:
  brew install coreutils automake autoconf openssl libyaml readline libxslt libtool unixodbc
  brew install asdf

diff-so-fancy
- brew install diff-so-fancy

nerdline fonts (for fish)
[Avaiable Fonts & Glyphs](https://nerdfonts.com/) (Scroll to bottom)
- brew tap caskroom/fonts
  brew cask install font-hack-nerd-font 
  # Doesnt work: font-hasklig-nerd-font

Mac:
iterm2


Linux:



For Krypton:

https://caskroom.github.io/search
brew cask install \
	virtualbox \
	google-chrome \
	firefox \
	puppet-agent \ # Actually this should be regualr brew since no gui.
> Figure out what each one of these does
> I think we just need teamviewer-host
teamviewer teamviewer-host teamviewer-quickjoin quicksupport supportcollector



=========================================================

- Fractal folders.  So in zsh/ git/ etc we have an aliases file and other commons and specifics.
- All files ending in *.symlink, no matter where they are, are to be symlinked into home.
  - Directories should also work.  For example the dir /atom.symlink will be symlinked into $HOME/.atom




==================
## Linux Installs

#### Golang Install
```
yum update
wget ttps://storage.googleapis.com/golang/go1.9.2.linux-amd64.tar.gz
tar -xzf go1.9.2.linux-amd64.tar.gz
mv go /opt/go-1.9.2
Check
go version
go env
```

##### Forking 3rd party golibs
```
mkdir -p $GOPATH_PUBLIC/src/github.com/kubernetes-incubator
cd $_ # or cd $GOPATH_PUBLIC/src/github.com/kubernetes-incubator
git clone https://github.com/kubernetes-incubator/cri-o # or your fork
cd cri-o
```

==================
## Linux Hierachy ~~Best Practices~~ My Modified Best Practices

http://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.html

https://unix.stackexchange.com/questions/11544/what-is-the-difference-between-opt-and-usr-local

## /usr/local/bin -> /opt/local/bin

- new place to store additional (not come with os) binaries.

## /usr/local/

Since this is designed to be read-only by FHS but require RW access in its bin subfolder, we use /opt/local instead.  And now we can make /usr/local read-only if required.

https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04s09.html
says /usr/local/ must have a certain set of dirs under it and nothing more.  So...

## /opt/local/
- will have bin, etc, include, lib, lib64, man, sbin, share, src.

## /opt/
- has `local` and all other dirs are program names.  then as a subfolder use program version `/opt/go/1.9/...`

- For example, someapp would be installed in /opt/someapp/1.5/, with one of its command being /opt/someapp/1.5/bin/foo, its configuration file would be in /etc/opt/someapp/foo.conf, and its log files in /var/opt/someapp/logs/foo.access.

----------------------------------------------------
# Tips / Useful / Misc

# Record a shell session

```bash
script screen.log
...
exit
```

----------------------------------

Quick Look plugins
These plugins adds support for the corresponding file type to Mac Quick Look (In Finder, mark a file and press Space to start Quick Look). The plugins includes features like syntax highlighting, markdown rendering, preview of JSON, patch files, csv, zip files and more.

$ brew cask install \
    qlcolorcode \
    qlstephen \
    qlmarkdown \
    quicklook-json \
    qlprettypatch \
    quicklook-csv \
    betterzipql \
    webpquicklook \
    suspicious-package
App Suggestions
Here are some useful apps that are available on Cask.

$ brew cask install \
    alfred \
    android-file-transfer \
    asepsis \
    appcleaner \
    caffeine \
    cheatsheet \
    docker \
    doubletwist \
    dropbox \
    google-chrome \
    google-drive \
    google-hangouts \
    flux \
    latexian \
    1password \
    pdftk \
    spectacle \
    sublime-text \
    superduper \
    totalfinder \
    transmission \
    valentina-studio \
    vlc



Gitkraken ssap
hqfaf@slipry.net11


sudo dmidecode --type chassis

TODO Install/Check useful Gnome Shell Extensions
- Desktop Scroller
- Docker Integration
- Jump List, but requires install of zeitgeist
pip install howdoi
Alfred

Upgrades node+npm. Works great!
npx dist-upgrade

https://github.com/js-n/awesome-npx
npx npm-check



https://console.bluemix.net/docs/services/alchemy-language/customizing.html#overview

https://console.bluemix.net/docs/services/alchemy-language/migration.html#index

https://console.bluemix.net/docs/services/alchemy-language/visual-constraints.html#visualConstraints




# Android Backup

helium and titanuim backup

- should be able to do it manually by simply copying everything apparently [check this]

- https://www.techrepublic.com/article/how-to-create-a-full-backup-of-your-android-device-without-root/  Uses `adb` from android studio to connect to phone and download data.


Just a comment that in bash you can get the line numbers while debugging by adding the following:
#!/bin/bash
# For testing. First line outputs line numbers. 
# Second line says to output what is going on in script
PS4=':${LINENO}+'
#set -x





TODO there is a warn that the underscore var is treied to change.  this is an evn var _=/usr/bin/env  its intermittent
Probably raised due to bass's code




# Dont need virtualenv with python 3.6+ has it builtin
python3.6 -m venv my36project

# Activate the my36project sandbox:
source my36project/bin/activate

# Check the Python version in the sandbox (it should be Python 3.6.3):
python --version

# Test pip installs work.
- May need to set python path to something writable.
pip install hello

# Deactivate the sandbox:
deactivate


[Nix and Python]
https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.md
https://nixos.org/nixpkgs/manual/#python
https://ariya.io/2016/06/isolated-development-environment-using-nix

https://github.com/search?p=2&q=python36.withPackages&type=Code&utf8=%E2%9C%93



# TODO should seperate jina_script 
compile and install_dotfiles




