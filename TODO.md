# TODOs

---- TODO ----
Rename this init.pathfile to paths.fish or pathfile.fish

---- TODO ----
Add this to some global setup/update script
pip3 install --upgrade pip setuptools wheel
pip install --upgrade pip setuptools wheel

---- TODO ----
After running clean-brew.sh in particular the 'brew clean' step
it messes up virtualenv symlinks.  And you must run this on each virtualenv to recreate the symlinks.

find ~/.virtualenvs/my-virtual-env/ -type l -delete
virtualenv ~/.virtualenvs/my-virtual-env

---- TODO ----
add brew, cask, chrome, etc examples from
https://github.com/junegunn/fzf/wiki/examples

---- TODO ----
switch task runner from gulp to python?
pip install watchdog

---- TODO ----
should seperate jina_script compile and install_dotfiles

---- TODO ----
add an `open` or opendir alias that will open current or given dir in system's finder.

---- TODO ----
Bring iterm settings into dotfiles.


## Pending Github issues

https://github.com/NixOS/nix/issues/1866
https://github.com/lotabout/skim/issues/78
https://github.com/lotabout/skim/issues/77

## Other TODOs

Maybe: Tweak tool -> typing -> Ctrl key position -> Swap Left Win key with Left Ctrl key
- might want this on say ncl keyboard to mimic
Super+x,c,v combo on mac

On keyboards where Super is tougher to reach than Ctrl
(usually ctrl,fn,super,alt order keyboards)

gnome: Switch Ctrl and Super keys
(prob now is in emacs want to use new-Super key as standard-Ctrl, so..)
emacs: Switch Ctrl and Super keys

TODO symlink all configs in linux/config to ~/.config, but only on linux.
cp ~/.config/terminator/config ~/src/dotfiles/linux/config/terminator/


TODO skim issues - code some rust?
https://github.com/lotabout/skim/issues/78
https://github.com/lotabout/skim/issues/77


TODO cua-mode for sublime
https://www.emacswiki.org/emacs/CuaMode
- probably acheived using "keybinding contexts",
ie. only listen for these commands when a region is higlighted


---- TODO ----
Fix Alt-C on Mac
53:NOTE: On OS X, Alt-c (Option-c) types ç by default. In iTerm2, you can send the right escape sequence with Esc-c. If you configure the option key to act as +Esc (iTerm2 Preferences > Profiles > Default > Keys > Left option (⌥) acts as: > +Esc), then alt-c will work for fzf as documented.

TODO Copy fish PATH to bash.
from fish:
must format the space delimited to colon delimited, then inject:
bash -c "export PATH=$fmt_path"

TODO create a global .agignore file for ag searches
also check if rg has the same.

TODO create a `sublime commands` file for easy goto readme and stuff

TODO That doc book generator for dotfiles and mac setup.
`gitbook`.
http://sourabhbajaj.com/mac-setup/iTerm/zsh.html
also krypton support ref?

TODO https://github.com/aio-libs/aiomonitor
python event loop manager


---- TODO ----
Vinyl - cloud file system
https://github.com/gulpjs/vinyl-fs
can use this with tibra data so large data files can reside off git.
then project is copied somewhere, then when at location, it downloads what is required.


---- TODO ----
My Ideal `history`
- All commands enetered in any terminal should be added, in order of runtime, to a global shared history file.
- However the current history of any given shell should only be those commands that were run in it. (Up arrow search should pull from local history)
- However if we search in one shell for a command just run in the other, we should be able to find it. (history search should pull from the global file)
- TODO Only successful commands should be saved in history. (or reallly i think i mean those commands run without spelling error)
  - but still allow pressing up to modify typo in last command
  - delete only after a certain # lines, or cronjob.
  - errord cmd history line numbers must be saved to another file so we know which lines to delete later on cleanup.

https://unix.stackexchange.com/questions/41739/keep-only-successful-commands-in-bash-history
- some other approach


---- TODO ----
Add Christmas tree to terminal greeting schedule Thanksgiving+1 to Jan/Feb End
https://www.cyberciti.biz/open-source/command-line-hacks/linux-unix-desktop-fun-christmas-tree-for-your-terminal/
