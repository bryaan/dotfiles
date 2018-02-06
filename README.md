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

# TODOs

TODO add brew, cask, chrome, etc examples from
https://github.com/junegunn/fzf/wiki/examples

TODO Auto Software/System Updates
Cron to periodically ask about updating, or check on first login shell.

TODO Do we need to:
chmod +x ./bootstrap/bootstrap.sh
chmod +x ./bootstrap/jinja_script.py

TODO switch task runner from gulp to python?
pip install watchdog

TODO should seperate jina_script 
compile and install_dotfiles


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

## Enable Extra Casks (Beta Nightly mostly)
brew tap caskroom/versions
brew cask install firefox-nightly

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




TODO move to ai / jarvis

http://strategoxt.org/
http://strategoxt.org/Spoofax/WebHome
http://strategoxt.org/Transform/ProgramTransformation
http://strategoxt.org/Stratego/StrategoLanguage

https://console.bluemix.net/docs/services/alchemy-language/customizing.html#overview
https://console.bluemix.net/docs/services/alchemy-language/migration.html#index
https://console.bluemix.net/docs/services/alchemy-language/visual-constraints.html#visualConstraints


