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

- Fractal folders.  So in most first level dirs you will find fish files that contain
  commands for that particular app.  They may also contain setup, but in this case files should
  be imported manually so the order of import can be fixed.

- All files ending in `*.symlink`, no matter their location, are to be symlinked into $HOME.
  TODO Directories should also work, for example the dir /atom.symlink will be symlinked into $HOME/.atom

----------------------------------------------------

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

> !! Big note: do not use wildcards bc it doesn't seem to work right on mac.
> it seems to be more a like copy.  Strange effects all around. dont use.

> These commands must be run together, or sublime must be off,
> bc it creates the User folder on delete.

```bash

# On Mac
set -l subldir /Users/bryan/Library/Application\ Support/Sublime\ Text\ 3/Packages

# On Linux
set -l subldir $HOME/.config/sublime-text-3/Packages

rm -rf $subldirbase/User; rm -rf $subldirbase/Default;  \
 ln -sf $DOTFILES_ROOT/sublime/User/      $subldir;   \
 ln -sf $DOTFILES_ROOT/sublime/Default/   $subldir

```

------------------------------------------------------------------------------

# Resources

[OMF Packages](https://github.com/oh-my-fish/packages-main/tree/master/packages)

https://github.com/holman/dotfiles

https://github.com/atelic/dotfiles

https://fishshell.com/docs/current/index.html#redirects
https://github.com/JorgeBucaran/fish-shell-cookbook#how-to-redirect-stdout-or-stderr-to-a-file-in-fish

https://github.com/fisherman/getopts


------------------------------------------------
https://github.com/sdegutis/hydra

https://nixos.org/nixos/nix-pills/index.html


# To install from unstable while running stable
> Shouldnt need to do this, even on non nix host.
> First check you have unfree packages enabled.
> Then just add the unstable channel the normal way.

git clone https://github.com/NixOS/nixpkgs.git ~/.nixpkgs/channels/unstable
nix-env -iA nixos.firefox -f ~/nixpkgs-unstable
nix-env -iA nixos.slack -f ~/.nixpkgs/channels/unstable

And without downloading the git repo:

To install Firefox from the latest revision in the Nixpkgs/NixOS 14.12 channel:
$ nix-env -f https://github.com/NixOS/nixpkgs-channels/archive/nixos-14.12.tar.gz -iA firefox

------------------------------------------------

trd workstation redundancy plan
- Req: Concurrent VNC sessions,
  Req: both users must see the same screen/session,
  Req: both users must be able to control mouse and keyboard.
- Req: Backup Power
  Req: 1 Monitor on UPS, must be able to move windows to this monitor if others are off.
  Req: On UPS Backup:
    * Monitor, PSU, EdgeX Router, Comcast modem.
  Req: cellular via USBC to pc
  * write a script to quickly connect, optionally a menu bar shortcut
  * test it in demo by unplugging ethernet, make sure process works.
  * should always be connected to machine when trading.
- Server/Client Archi (later, but pretty damn simple..)


------------------------------------------------


# TODO add to config.nix
syncthing
syncthing-inotify
borgbackup
encfs
gnupg
gitAndTools.git-annex
sl
sshfsFuse


# COMMANDS #
nix-env -i ...  # Install
nix-env -e ...  # Uninstall
nix-env -q --installed # List Installed
nox ...         # Search


# Mac install list #
TODO alfred
https://www.alfredapp.com/

brew install vimpager
brew install diff-so-fancy

highlight check works with fzf preview

brew cask install virtualbox
brew cask install virtualbox-extension-pack

iterm2

## Enable Extra Casks (Beta Nightly mostly)
brew tap caskroom/versions
brew cask install firefox-nightly

https://caskroom.github.io/search
brew cask install \
    alfred \
    virtualbox \
    google-chrome \
    firefox \
    sublime-text \


### sublimerge
- and also the binary download


gnome3.gnome-characters Simple utility application to find and insert unusual characters



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

# TODO windows backup
borgbackup
> Try chocolatey install first on dad's
https://chocolatey.org/packages/borgbackup/
https://github.com/billyc/borg-releases


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
diff has some options that can be useful to you:

   -E, --ignore-tab-expansion
          ignore changes due to tab expansion

   -Z, --ignore-trailing-space
          ignore white space at line end

   -b, --ignore-space-change
          ignore changes in the amount of white space

   -w, --ignore-all-space
          ignore all white space

   -B, --ignore-blank-lines
          ignore changes whose lines are all blank
