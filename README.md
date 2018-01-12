# dotfiles

**Makes me feel at $HOME**

Anything with an extension of .symlink will get symlinked (without .symlink extension) into $HOME when you run ./install.sh.


# Setup

```bash
go get github.com/subfuzion/envtpl

npm install --global gulp
cd $DOTFILES; npm link gulp

chmod +x ./bootstrap/bootstrap.sh

npm install
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

-----------------------------------

TODO Save Sublime Setting Files

# One time save
cp -R ~/.config/sublime-text-3/Packages/User/* $DOTFILES_ROOT/sublime/

# Linking

> Must first be removed so child folders will link properly.

```bash

rm -rf $HOME/.config/sublime-text-3/Packages/User; ln -sfn $DOTFILES_ROOT/sublime/ $HOME/.config/sublime-text-3/Packages/User



set DOTFILES_ROOT $HOME/src/dotfiles
set -l subldirbase /Users/bryan/Library/Application\ Support/Sublime\ Text\ 3/Packages/

rm -rf $subldirbase; mkdir $subldirbase; ln -s $DOTFILES_ROOT/sublime $subldirbase; mv $subldirbase/sublime $subldirbase/User

May need to run:
Package Control: Upgrade/Overide All Packages
to reinstall packages.

```


TODO That doc book generator for dotfiles and mac setup.  gitbook.
http://sourabhbajaj.com/mac-setup/iTerm/zsh.html
also krypton support ref?

TODO Stop templates from triggering by compiling to build/ dir.
npx nodemon --exec "bootstrap/bootstrap.sh"

TODO APFS new filesys


TODO Sublime PAckages
"Rainglow"



# TODO Vinyl
https://github.com/gulpjs/vinyl-fs
can use this with tibra data. so large data files can reside off git
then project is copied somewhere, then when at location, it downloads what is required.
- added benifit we keep skelaton files in repo so we know.

also research this vs git-lfs, pretty sure this is way more flexible, indeed
we should be able to write a git-lfs backend for vinyl.
                                        

brew cask install virtualbox
brew cask install virtualbox-extension-pack

brew install nvim ag

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
brew cask install virtualbox google-chrome firefox puppet-agent
> Figure out what each one of these does
> I think we just need teamviewer-host
teamviewer teamviewer-host teamviewer-quickjoin quicksupport supportcollector




TODO i really want my git aliases from zsh to work.
1. Build my own customized repo by copying from there, prob a good idea.
2. fish `bass` might work with aliases and functions.
3. pull anything with alias out to new file, but since they can use functions this likely requires lots of work.

# TODO Use that go watcher to create a dev service that runs:

$DOTFILES_ROOT/bootstrap/bootstrap.sh
reloadAllTerminals

TODO create a sublime commands file for easy goto readme and stuff

# TODO Make sure reload terminal script works with fish.

# TODO Cron to periodically ask about updating, that is if fish doesnt ask
# automatically like zsh. Ideally it should trigger a flag, and next time an interactive prompt is opned the user should be asked (try to make sure the shell isnt execing a command, but that the proc is /usr/bin/zsh or similar)

omf self-update
omf update

# TODO also add this to initial pc setup bootstrap. Or better, detect if should run install bc there were no files in there to begin with, or if they changed.

=========================================================



=========================================================


- Fractal folders.  So in zsh/ git/ etc we have an aliases file and other commons and specifics.
- All files ending in *.symlink, no matter where they are, are to be symlinked into home.
  - Directories should also work.  For example the dir /atom.symlink will be symlinked into $HOME/.atom




# REFS

https://www.digitalocean.com/community/tutorials/how-to-use-git-to-manage-your-user-configuration-files-on-a-linux-vps

https://github.com/holman/dotfiles

Favorite Setup:
https://github.com/atelic/dotfiles


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
## Linux Hierachy Best Practices

http://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.html


If you will be compiling your own software then you ultimately control the installation location. By convention, software compiled and installed manually (not through a package manager, e.g apt, yum, pacman) is installed in /usr/local. Some packages (programs) will create a sub-directory within /usr/local to store all of their relevant files in, such as /usr/local/openssl. Other packages will install their necessary files into existing directories such as /usr/local/sbin and /usr/local/etc. These are simply default locations and can be changed during compilation.

When you are compiling software, the installation location can be specified by using the --prefix= option when running ./configure. It is highly recommended that you look at all of the available options for your package by running $ ./configure --help | less. Additionally, browsing the INSTALL and README documents provided with your package is a good idea. They tend to include installation instructions and dependency information that is specific to the package.

It should also be noted that although you can store software anywhere, according to the FHS, source code for locally installed software should be stored in /usr/local/src Standardizing where you store your source trees will allow you to easily locate a tree if you need to copy a stock configuration file or binary. Even though some packages use it, your source code should not be stored in /usr/src as that is designated for system software such as the kernel.

Finally, you need to ensure that your installation location is included in your $PATH. If you decide to install your package in /opt but it's not in your $PATH your shell won't find the executables and you will have to use the absolute path to invoke your programs. Here are some great discussions from AU about configuring your $PATH


https://unix.stackexchange.com/questions/11544/what-is-the-difference-between-opt-and-usr-local

All files under /usr are shareable between OS instances, although this is rarely done with Linux. This is a part where the FHS is slightly self-contradictory, as /usr is defined to be read-only, but /usr/local/bin needs to be read-write for local installation of software to succeed. The SVR4 file system standard, which was the FHS' main source of inspiration, is recommending to avoid /usr/local and use /opt/local instead to overcome this issue.


/opt/local

- /usr/local, for self, inhouse, compiled and maintained software

- Install files built from source.
/opt/local/bin  /opt/local/src  /opt/local/lib  ... mimic /usr/local

/opt/<packge name>

- Packages that come pre-built (with binaries)
- is for non-self, external, prepackaged binary/application bundle

- For example, someapp would be installed in /opt/someapp, with one of its command being /opt/someapp/bin/foo, its configuration file would be in /etc/opt/someapp/foo.conf, and its log files in /var/opt/someapp/logs/foo.access.

/usr/local/

- Bc of 'problem' above should use /opt/local instead. On both mac and linux this directory usually comes
prepopulated with a bunch of stuff.  Better to leave that alone and install all thigns in /opt.

- /usr/local, for self, inhouse, compiled and maintained software

- For installing programs that must be compiled from source.  Shared system wide.

/usr/src/

- Never use.  This is for kernel stuff.







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
  
  