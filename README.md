# dotfiles

**Makes me feel at $HOME**

Anything with an extension of .symlink will get symlinked (without .symlink extension) into $HOME when you run ./install.sh.

TODO Try to replace the python script with a bash script.
Then delte ./default.nix
If we haven't done this then on linux must run 'nix-shell' to get the proper host config.

TODO Mac should only use brew not nix.  nix is to be used on linux so we get consistent packages.


## Run Bootstrap just once
```
dots.bootstrap
```

## Development: Active Bootstrap on File Change
```
$ dots
```

-----------------------------------------------------------------------------------

# Setup

Must have the nix package manager installed.

## Cloning To New Machine
```bash
git clone ... ~/src/dotfiles
See Install Nix instructions below
```

## Updating Machines
```bash
cd $DOTFILES; git pull; dots.bootstrap; reload
```

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
TODO These instructions are out of date!

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

> These commands must be run together, or sublime must be off,
> bc it creates the User folder on delete.

```bash

# On Mac
set -l subldir /Users/bryan/Library/Application\ Support/Sublime\ Text\ 3/Packages

# On Linux
set -l subldir $HOME/.config/sublime-text-3/Packages

rm -rf $subldirbase/User; rm -rf $subldirbase/Default;  \
 ln -sf $DOTFILES/sublime/User/      $subldir;   \
 ln -sf $DOTFILES/sublime/Default/   $subldir

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

# To install from unstable while running stable
> Shouldnt need to do this, even on non nix host.
> First check you have unfree packages enabled.
> Then just add the unstable channel the normal way.

git clone https://github.com/NixOS/nixpkgs.git ~/.nixpkgs/channels/unstable
nix-env -iA nixos.firefox -f ~/nixpkgs-unstable
nix-env -iA nixos.slack -f ~/.nixpkgs/channels/unstable

To instead download without the git repo, by specifying a Nixpkgs/NixOS channel:
$ nix-env -f https://github.com/NixOS/nixpkgs-channels/archive/nixos-14.12.tar.gz -iA firefox


------------------------------------------------


# COMMANDS #

nix-env -i ...  # Install
nix-env -e ...  # Uninstall
nix-env -q --installed # List Installed
nox ...         # Search


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

sublimerge
- and also the binary download

gnome3.gnome-characters Simple utility application to find and insert unusual characters



# Chrome Extensions:

uBlock Origin
Autofill
Lastpass
sessionbuddy

BrowserStack
iMacros for Chrome
JSON Viewer
Visual Event
Vue.js devtools


----------------------------------------------------

# Tips / Useful / Misc

# Record a shell session

```bash
script screen.log
...
exit
```


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

TODO move to aii

http://strategoxt.org/
http://strategoxt.org/Spoofax/WebHome
http://strategoxt.org/Transform/ProgramTransformation
http://strategoxt.org/Stratego/StrategoLanguage

https://console.bluemix.net/docs/services/alchemy-language/customizing.html#overview
https://console.bluemix.net/docs/services/alchemy-language/migration.html#index
https://console.bluemix.net/docs/services/alchemy-language/visual-constraints.html#visualConstraints

