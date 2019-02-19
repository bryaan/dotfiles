# dotfiles

**Makes me feel at $HOME**

Anything with an extension of .symlink will get symlinked (without .symlink extension) into $HOME when you run ./install.sh.

TODO Try to replace the python script with a bash script.
Then delte ./default.nix
If we haven't done this then on linux must run 'nix-shell' to get the proper host config.

- Fractal folders.  So in most first level dirs you will find fish files that contain
  commands for that particular app.  They may also contain setup, but in this case files should
  be imported manually so the order of import can be fixed.

- All files ending in `*.symlink`, no matter their location, are to be symlinked into $HOME.
  TODO Directories should also work, for example the dir /atom.symlink will be symlinked into $HOME/.atom


```bash
## Run Bootstrap Once
dots.bootstrap
## Run Bootstrap Loop
dots

## (Optional) Set System Config Defaults
sh ./macos/set-defaults.sh
sh ./linux/gnome-set-defaults.sh
```

-----------------------------------------------------------------------------------

## Setup

Must have the nix package manager installed.

### Cloning To New Machine

```bash
git clone ... ~/src/dotfiles
See Install Nix instructions below
```

### Updating Machines

```bash
cd $DOTFILES; git pull; dots.bootstrap; reload
```

Update fish completions  `fish_update_completions`
to parse man pages and gernate new completions.
They go in ~/.config/fish/completions

Update Sublime and Sublime Packages
Open Command Menu (Super + Shift + p)
Search for: "Package Control: Upgrade/Overide All Packages"


## RHEL - Enable Passwordless sudo for user

```bash
sudo visudo
# Allow bryan to run sudo command as root on any terminal without passwd
bryan ALL=(root) NOPASSWD: /usr/bin/sudo
```

## Build and install dotfiles

```bash
cd ~/src/dotfiles
chmod u+x bootstrap/jinja_script.py
nix-shell
gulp
```

## Install nerd-fonts (works mac and linux)

TODO move to one-shot script

https://nerdfonts.com/

```bash
mkdir $HOME/.fonts; cd $HOME/.fonts
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
./nerd-fonts/install.sh Hack
./nerd-fonts/install.sh Inconsolata
./nerd-fonts/install.sh Monoid
./nerd-fonts/install.sh Meslo
./nerd-fonts/install.sh DroidSansMono
rm -rf ./nerd-fonts
```


## Sublime Install + Setup

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

## Resources

[OMF Packages](https://github.com/oh-my-fish/packages-main/tree/master/packages)



### Enable Extra Casks (Beta Nightly mostly)

brew tap caskroom/versions
brew cask install firefox-nightly

https://caskroom.github.io/search
brew cask install \
    alfred \
    virtualbox \
    google-chrome \
    firefox \
    sublime-text \

gnome3.gnome-characters Simple utility application to find and insert unusual characters

## Chrome Extensions

uBlock Origin
Autofill
Lastpass
sessionbuddy

BrowserStack
iMacros for Chrome
JSON Viewer
Visual Event
Vue.js devtools


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

