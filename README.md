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