# This file is for settings related to fish and fish utilities.

# TODO mkdir shell/fish and split these sections to files.

################################################
# reloading
################################################

function reload
  clear; fish.reload
  # clear; spin fish.reload
end

function fish.reload -d "Reload fish process via exec, keeping some context"
  set -q CI; and return 0
  # see what those vars do. And i thinks history is getting saved already.
  # history --save
  # set -gx dirprev $dirprev
  # set -gx dirnext $dirnext
  # set -gx dirstack $dirstack
  # set -gx fish_greeting ''
  exec fish
end

function fish.reload.soft
  source ~/.config/fish/config.fish
end

# TODO reload.terminals



# So that funced uses vim.
# https://github.com/fish-shell/fish-shell/issues/4677
function func
  funced --editor $EDITOR $argv
end
abbr -a funced 'funced --editor $EDITOR'


function fishhistory
  $EDITOR ~/.local/share/fish/fish_history
end

# Typing `!!<SPC>` will get it replaced with the previous cmd.
function bind_bang
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

# Typing `!$<SPC>` will get it replaced with the previous cmd's final arg.
function bind_dollar
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# If the command line has content, it prepends sudo.
# If there is no content, it prepends sudo to the last item in the history.
function prepend_command
  set -l prepend $argv[1]
  if test -z "$prepend"
    echo "prepend_command needs one argument."
    return 1
  end

  set -l cmd (commandline)
  if test -z "$cmd"
    commandline -r $history[1]
  end

  set -l old_cursor (commandline -C)
  commandline -C 0
  commandline -i "$prepend "
  commandline -C (math $old_cursor + (echo $prepend | wc -c))
end


################################################
# `bobthefish` Theme Specific Settings
################################################

# Number of chars to show in abbreviated path. 0=show full path
set -g fish_prompt_pwd_dir_length 3

# For the path rel to project root
set -g theme_project_dir_length 0

# The impl needs some work. => For Minikube it should only show when in a kubenetes project folder.
# If fixed, you can set this back to yes.
set -g theme_display_k8s_context no

set -g theme_display_ruby no
set -g theme_display_virtualenv yes
set -g theme_display_vagrant yes
set -g theme_display_docker_machine no

set -g theme_color_scheme dark
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_title_display_process no
set -g theme_newline_cursor no




