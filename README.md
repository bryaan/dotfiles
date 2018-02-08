# dotfiles

**Makes me feel at $HOME**

Anything with an extension of .symlink will get symlinked (without .symlink extension) into $HOME when you run ./install.sh.

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

## Cloning To New Machine
```bash
cd ~/src/dotfiles
git clone ...
start at Install Nix instructions below

#git submodule init
#git submodule update
```

## Updating Machines
```bash
cd $DOTFILES; git pull; dots.bootstrap; reload
```

<!-- ### To update submodules:
```bash
git submodule update --remote
git submodule update --remote <submodule-repo-name>
``` -->

------------------------------------------------------------------------------

# Update fish/fisherman
fisher up

# Update fish completions  `fish_update_completions`
to parse man pages and gernate new completions.
They go in ~/.config/fish/completions

# Update Sublime and Sublime Packages
Open Command Menu (Super + Shift + p)
Search for: "Package Control: Upgrade/Overide All Packages"

------------------------------------------------------------------------------

# Install Nix and Fish (RHEL 7)

```
curl https://nixos.org/nix/install | sh
source /home/bryan/.nix-profile/etc/profile.d/nix.sh

nix-env -i fish
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fish
set PATH ~/.nix-profile/bin $PATH
fisher install
chsh -s (which fish)
```

> None of these commands were neccessary. First install didn't seem to work, but deleting all nix folders in root and home dirs and reinstall worked.  Make sure to use bash shell.

nix-channel --add https://nixos.org/channels/nixos-17.09 nixos
nix-channel --update

# RHEL - Enable Passwordless sudo for user
```
sudo visudo
# Allow bryan to run sudo command as root on any terminal without passwd
bryan ALL=(root) NOPASSWD: /usr/bin/sudo
```

# Build and install dotfiles

```
cd ~/src/dotfiles
chmod u+x bootstrap/jinja_script.py
nix-shell
gulp
```

------------------------------------------------------------------------------

# Install nerd-fonts (works mac and linux)
TODO move to one-shot script

https://nerdfonts.com/

```
mkdir $HOME/.fonts; cd $HOME/.fonts
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
./nerd-fonts/install.sh Hack
./nerd-fonts/install.sh Inconsolata
./nerd-fonts/install.sh Monoid
./nerd-fonts/install.sh Meslo
./nerd-fonts/install.sh DroidSansMono
rm -rf ./nerd-fonts
```

------------------------------------------------------------------------------

# Sublime Install + Setup

1. Run functions below to copy settings over.
2. Sublime Cmd Menu -> Install Package Control
3. Sublime Cmd Menu -> Package Control: Upgrade/Overide All Packages

## For Linux
```bash

rm -rf $HOME/.config/sublime-text-3/Packages/User; \
  rm -rf $HOME/.config/sublime-text-3/Packages/Default; \
  ln -sfn $DOTFILES_ROOT/sublime/User/ $HOME/.config/sublime-text-3/Packages/; \
  ln -sfn $DOTFILES_ROOT/sublime/Default/ $HOME/.config/sublime-text-3/Packages/

```

## For Mac
```bash

set DOTFILES_ROOT $HOME/src/dotfiles
set -l subldirbase /Users/bryan/Library/Application\ Support/Sublime\ Text\ 3/Packages/

rm -rf $subldirbase; mkdir $subldirbase; \
  ln -s $DOTFILES_ROOT/sublime/User/      $subldirbase \
  ln -s $DOTFILES_ROOT/sublime/Default/   $subldirbase

```

------------------------------------------------------------------------------

# Resources

[OMF Packages](https://github.com/oh-my-fish/packages-main/tree/master/packages)

https://github.com/holman/dotfiles

https://github.com/atelic/dotfiles

https://fishshell.com/docs/current/index.html#redirects
https://github.com/JorgeBucaran/fish-shell-cookbook#how-to-redirect-stdout-or-stderr-to-a-file-in-fish

https://github.com/fisherman/getopts

------------------------------------------------------------------------------

# TODOs

TODO add brew, cask, chrome, etc examples from
https://github.com/junegunn/fzf/wiki/examples

TODO Auto Software/System Updates
Cron to periodically ask about updating, or check on first login shell.

TODO switch task runner from gulp to python?
pip install watchdog

TODO should seperate jina_script
compile and install_dotfiles

TODO fishfile erase bug
TODO fishfile should have brew plugin on mac but not on linux

TODO Check out whether to use z or fzf-autojump
https://github.com/wting/autojump
https://github.com/rominf/omf-plugin-fzf-autojump

TODO add an `opendir` alias that will open current or given dir in system's finder.

TODO Bring iterm settings into dotfiles.
# Fix Alt-C on Mac
53:NOTE: On OS X, Alt-c (Option-c) types ç by default. In iTerm2, you can send the right escape sequence with Esc-c. If you configure the option key to act as +Esc (iTerm2 Preferences > Profiles > Default > Keys > Left option (⌥) acts as: > +Esc), then alt-c will work for fzf as documented.

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

TODO Bring zsh aliases (and completions via bass?) over to fish.
- Make them fish abbreviations.
- via bass or better yet by copy paste so we know what we've got.

TODO create an .agignore file for ag searches
also check if rg has the same.

TODO create a `sublime commands` file for easy goto readme and stuff

TODO That doc book generator for dotfiles and mac setup.
`gitbook`.
http://sourabhbajaj.com/mac-setup/iTerm/zsh.html
also krypton support ref?

TODO https://github.com/aio-libs/aiomonitor
python event loop manager


TODO Vinyl - cloud file system
https://github.com/gulpjs/vinyl-fs
can use this with tibra data so large data files can reside off git.
then project is copied somewhere, then when at location, it downloads what is required.
- added benefit we keep skeleton files in repo so we know they exist.

also research this vs git-lfs, pretty sure this is way more flexible, indeed we should be able to write a git-lfs backend for vinyl.


TODO My history requirements
- All commands enetered in any terminal should be added, in order of runtime, to a global shared history file.
- However the current history of any given shell should only be those commands that were run in it. (Up arrow search should pull from local history)
- However if we search in one shell for a command just run in the other, we should be able to find it. (history search should pull from the global file)
- TODO Only successful commands should be saved in history. (or reallly i think i mean those commands run without spelling error)
  - but still allow pressing up to modify typo in last command
  - delete only after a certain # lines, or cronjob.
  - errord cmd history line numbers must be saved to another file so we know which lines to delete later on cleanup.

https://unix.stackexchange.com/questions/41739/keep-only-successful-commands-in-bash-history
- some other approach


TODO Add Christmas tree to terminal greeting schedule Thanksgiving+1 to Jan/Feb End
https://www.cyberciti.biz/open-source/command-line-hacks/linux-unix-desktop-fun-christmas-tree-for-your-terminal/



------------------------------------------------
https://github.com/sdegutis/hydra

https://nixos.org/nixos/nix-pills/index.html

------------------------------------------------

# install list
nix-env -i
git
exa ripgrep
axel
fish fzf
emacs mu offlineimap
gcc
# gcc-wrapper
glibc
# binutils - i think linux/nix only
cmake
rustc
cargo
# rustBeta.cargo
yarn

!!!!!!!!!!!!!!!!!!!!
cargo install skim
cargo install fd-find  # nix: fd


pip install ripgrep
pip install glances
vimpager - from github compile
yarn global add gulp tern


# Mac install list

TODO alfred
https://www.alfredapp.com/

brew install nvim vimpager
brew install glances
brew install ag ripgrep fzf
sublime?

highlight check works with fzf preview

brew cask install virtualbox
brew cask install virtualbox-extension-pack

## Enable Extra Casks (Beta Nightly mostly)
brew tap caskroom/versions
brew cask install firefox-nightly


### sublimerge
- and also the binary download


# nix-env -q --installed

binutils-2.28.1
cargo-0.23.0
cmake-3.10.2
fish-2.7.1
gcc-6.4.0
git-2.16.1
glibc-2.26-131
nix-1.11.16
patchelf-0.9
rustc-1.22.1
yarn-1.3.2
workEnv




fish
asdf
- Recommnded Pkgs:
  brew install coreutils automake autoconf openssl libyaml readline libxslt libtool unixodbc
  brew install asdf

brew install diff-so-fancy


# Mac Extra
iterm2

https://caskroom.github.io/search
brew cask install \
    alfred \
    virtualbox \
    google-chrome \
    firefox \
    sublime-text \

# Linux Extra


# For Krypton:

> Figure out what each one of these does:
> I think we just need teamviewer-host
teamviewer teamviewer-host teamviewer-quickjoin quicksupport supportcollector

brew cask install \
    virtualbox \
    google-chrome \
    google-drive \
    firefox \
    puppet-agent \ # Actually this should be regualr brew since no gui.


# Chrome Extensions:

Autofill
Lastpass
sessionbuddy
BrowserStack
iMacros for Chrome
JSON Viewer
Visual Event
Vue.js devtools
No Coin



----------------------------------------------------

- Fractal folders.  So in zsh/ git/ etc we have an aliases file and other commons and specifics.
- All files ending in *.symlink, no matter where they are, are to be symlinked into home.
  - Directories should also work.  For example the dir /atom.symlink will be symlinked into $HOME/.atom



----------------------------------------------------
# Tips / Useful / Misc

# Record a shell session

```bash
script screen.log
...
exit
```

----------------------------------------------------

Gitkraken ssap
hqfaf@slipry.net11


pip install howdoi

sudo dmidecode --type chassis

TODO Install/Check useful Gnome Shell Extensions
- Desktop Scroller
- Docker Integration
- Jump List, but requires install of zeitgeist

Upgrades node+npm. Works great!
npx dist-upgrade

https://github.com/js-n/awesome-npx
npx npm-check


----------------------------------------------------

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


----------------------------------------------------


TODO move to ai / jarvis

http://strategoxt.org/
http://strategoxt.org/Spoofax/WebHome
http://strategoxt.org/Transform/ProgramTransformation
http://strategoxt.org/Stratego/StrategoLanguage

https://console.bluemix.net/docs/services/alchemy-language/customizing.html#overview
https://console.bluemix.net/docs/services/alchemy-language/migration.html#index
https://console.bluemix.net/docs/services/alchemy-language/visual-constraints.html#visualConstraints




----------------------------------------------------
