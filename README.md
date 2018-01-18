# dotfiles

**Makes me feel at $HOME**

Anything with an extension of .symlink will get symlinked (without .symlink extension) into $HOME when you run ./install.sh.


# Resources

[OMF Packages](https://github.com/oh-my-fish/packages-main/tree/master/packages)

https://github.com/holman/dotfiles

https://github.com/atelic/dotfiles



# Setup

```bash
pip3 install jinja2

npm install --global gulp
cd $DOTFILES; npm link gulp
npm install

yarn global add gulp
yarn link
yarn

chmod +x ./bootstrap/bootstrap.sh
chmod +x ./bootstrap/jinja_script.py

```

## Cloning To Setup Machine
todo

## Updating Machines
todo


# Run

```bash
$DOTFILES_ROOT/bootstrap/bootstrap.sh

gulp
```

# Cleanup

```bash
rm -y shell/**/*.fish shell/**/*.zsh
```

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

rm -rf $subldirbase; mkdir $subldirbase; ln -s $DOTFILES_ROOT/sublime $subldirbase; mv $subldirbase/sublime $subldirbase/User
```

# Misc

## Adding asdf plugins
asdf plugin-add golang
asdf install golang 1.9.2
asdf global golang 1.9.2

==================================================================================

For network:
Since guest netwrok seemed to (or it was really the protal) slow speed, it should only be enabled when guests are over.  There is ssh admin possible, so write a script that can enable on demand from phone, also set pw at that time.

==================================================================================



TODO add to update script

Update all plugins
asdf plugin-update --all

Update asdf itself
asdf update



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



TODO https://github.com/junegunn/fzf
search for `fzf --preview` at bottom, add that to the fzf env var for file searchng.  and install highliht


Check out whether to use z or fzf-autojump
https://github.com/wting/autojump
https://github.com/rominf/omf-plugin-fzf-autojump


TODO Merge jinja_script and bootstrap.sh


TODO occasionaly run `fish_update_completions`
to parse man pages and gernate new completions.
They go in ~/.config/fish/completions


TODO Enable `fzf` so Ctrl+R history search wrks...
then again we have great history search with up key anyway right? just not full display at once. so yea lets add.

------------------------------------------------
------------------------------------------------

TODO i really want my git aliases from zsh to work.
1. Build my own customized repo by copying from zsh plugins, prob best approach idea, well besides for completions.
2. fish `bass` might work with aliases and functions.
3. pull anything with alias out to new file, but since they can use functions this likely requires lots of work.

TODO create a `sublime commands` file for easy goto readme and stuff

TODO Make sure reload terminal script works with fish.

# TODO Cron to periodically ask about updating, that is if fish doesnt ask
# automatically like zsh. Ideally it should trigger a flag, and next time an interactive prompt is opned the user should be asked (try to make sure the shell isnt execing a command, but that the proc is /usr/bin/zsh or similar)

omf self-update
omf update



add an update command in general.
- ohmyfish: `omf update`
- sublime: install all packages

Don't run the update command in dev loop.



TODO switch task runner from gulp to python to reduce need for setup. And node_modules dir.
pip install watchdog

TODO Stop templates from triggering by compiling to build/ dir.



TODO That doc book generator for dotfiles and mac setup.  
`gitbook`.
http://sourabhbajaj.com/mac-setup/iTerm/zsh.html
also krypton support ref?




https://github.com/aio-libs/aiomonitor
python event loop manager


# TODO Vinyl
https://github.com/gulpjs/vinyl-fs
can use this with tibra data. so large data files can reside off git
then project is copied somewhere, then when at location, it downloads what is required.
- added benifit we keep skelaton files in repo so we know.

also research this vs git-lfs, pretty sure this is way more flexible, indeed
we should be able to write a git-lfs backend for vinyl.




TODO Fish Only save successful commands in history.
- but still allow pressing up to modify typo in last command
- delete only after a certain # lines, or cronjob.
- errord cmd history line numbers must be saved to another file so we know which lines to delete later on cleanup.

https://unix.stackexchange.com/questions/41739/keep-only-successful-commands-in-bash-history
- some other approach


TODO All the commands that we check before using, we should generate a message on shell start?  Or just add them all to the install list instead?


------------------------------------------------
------------------------------------------------


# Linux install list

## fish
nix-env -i fish
then symlink fish into /usr/bin:
ln -sf $HOME/.nix-profile/bin/fish /usr/bin

## oneliners
pip install ripgrep
pip install glances
nvim?

# Mac install list

# TODO Add to install list on both systems
brew install nvim
brew install glances kak
brew install ag ripgrep fzf

highlight check works with fzf preview

brew cask install virtualbox
brew cask install virtualbox-extension-pack


# Same on all linux and mac
> If can do with brew on mac and pip on linux dont add to this list.
yarn global add gulp
cargo install exa


# RHEL 7
nix-env -i gcc-wrapper-7.2.0


## Sublime Packages To Install Auto:

### PackageDev
https://github.com/SublimeText/PackageDev
To make tools avialble under Tools → Packages → Package Development,

### HighlightWords

### sublimerge
- and also the binary download



# Things to add to Install Script

Both:
fish zsh
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


=====================================================





# Add terminal reload command to dev flow
Actually this might get messy when there are errors, just rely on reloadAllTerminals command.


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

```
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



https://www.alfredapp.com/
https://github.com/sdegutis/hydra

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



Good keyshorcuts for zsh and autocompletion

https://stackoverflow.com/questions/211378/hidden-features-of-bash/1416125#1416125

Alt - * To show all potential matches to wildcard



# Android Backup

helium and titanuim backup

- should be able to do it manually by simply copying everything apparently [check this]

- https://www.techrepublic.com/article/how-to-create-a-full-backup-of-your-android-device-without-root/  Uses `adb` from android studio to connect to phone and download data.