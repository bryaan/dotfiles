
# TODOs

Maybe: Tweak tool -> typing -> Ctrl key position -> Swap Left Win key with Left Ctrl key
- might want this on say ncl keyboard to mimic
Super+x,c,v combo on mac

On keyboards where Super is tougher to reach than Ctrl
(usually ctrl,fn,super,alt order keyboards)

gnome: Switch Ctrl and Super keys
(prob now is in emacs want to use new-Super key as standard-Ctrl, so..)
emacs: Switch Ctrl and Super keys


TODO when creating a js fun, put the {} on the next line,
or just use a snippet and binding

we have a parent library that uses Plotting and add all things outside of the plot canvas

TODO when that { is create after js function def, should have some
keystoke or mayybe auto, where you move cursor to point where
where } should be, and it should indent anything in between

TODO shortcut to quickly open a new sublime or emacs window
prefeably org-mode, where I can drop rich text notes
it should auto date and save notes.
Also shortcut to bring up last note
Key chord to select note to switch to (maybe use projectile and notes fodler?
or actually org-mode will have a list notes function)

TODO Modifier key + arrow to jump forward words

TODO can we use a modifier key to navigate by words, like we do winows in emacs?


TODO if nix doesn't handle everything use a 'Brewfile'


TODO skim issues - code some rust?
https://github.com/lotabout/skim/issues/78
https://github.com/lotabout/skim/issues/77


TODO cua-mode for sublime
https://www.emacswiki.org/emacs/CuaMode
- probably acheived using "keybinding contexts",
ie. only listen for these commands when a region is higlighted

TODO sublime collapse all folders command, which complements file path highlight in nav

TODO copy sublime origami-emacs keybindings

TODO add brew, cask, chrome, etc examples from
https://github.com/junegunn/fzf/wiki/examples

TODO Backup IntelliJ Settings
Linux: .IntelliJIdea2017.2
Use regex on first part.
https://intellij-support.jetbrains.com/hc/en-us/community/posts/206381509-Export-settings-via-command-line-OS-X-


TODO emacs as service
https://nixos.org/nixos/manual/index.html#idm140737316268176

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
