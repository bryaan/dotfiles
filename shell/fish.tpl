# This file is for settings related to fish and fish utilities.

# brew manages fzf on macos.
# But might want to define the FZF_HOME on mac anyway for future scripts.
{% if os.linux %}
  set -x FZF_HOME "$HOME/.fzf"
  append_path $FZF_HOME/bin
{% endif %}


# https://github.com/fish-shell/fish-shell/issues/4677
function func
  funced --editor nvim $argv
end
# abbr -a funced funced --editor $EDITOR


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


####################################################
# fzf
####################################################

# Check this file for keybindings:
# nvim /Users/bryan/.config/fish/functions/fish_user_key_bindings.fish
# TODO Bring them over here so don't need to run:
# eval (brew --prefix)/opt/fzf/install

# This cmd is included with the fisherman plugin, but not the omf one.
# Determines if we are in a tmux session and should use its modified fzf.
function __fzfcmd
  set -q FZF_TMUX; or set -l FZF_TMUX 0
  if test "$FZF_TMUX" -eq 1
    set -q FZF_TMUX_HEIGHT; or set -l FZF_TMUX_HEIGHT 40%
    fzf-tmux -d$FZF_TMUX_HEIGHT $argv
  else
    fzf $argv
  end
end

function fzf-bcd-widget -d 'cd backwards'
  pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tac | eval (__fzfcmd) +m --select-1 --exit-0 $FZF_BCD_OPTS | read -l result
  [ "$result" ]; and cd $result
  commandline -f repaint
end

function fzf-cdhist-widget -d 'cd to one of the previously visited locations'
  # Clear non-existent folders from cdhist.
  set -l buf
  for i in (seq 1 (count $dirprev))
    set -l dir $dirprev[$i]
    if test -d $dir
      set buf $buf $dir
    end
  end
  set dirprev $buf
  string join \n $dirprev | tac | sed 1d | eval (__fzfcmd) +m --tiebreak=index --toggle-sort=ctrl-r $FZF_CDHIST_OPTS | read -l result
  [ "$result" ]; and cd $result
  commandline -f repaint
end

# Dont really know how this helps.
# fzf-select over pacman -Qlq fzf
function fzf-select -d 'fzf commandline job and print unescaped selection back to commandline'
  set -l cmd (commandline -j)
  [ "$cmd" ]; or return
  eval $cmd | eval (__fzfcmd) -m --tiebreak=index --select-1 --exit-0 | string join ' ' | read -l result
  [ "$result" ]; and commandline -j -- $result
  commandline -f repaint
end

# Set default FZF input to ripgrep.  Can also do ag.
# Default is `find`.
# The git ls-tree is to improve lookup speed in large repos.
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --smartcase: Makes ripgrep search case-insensitively if the pattern is all lowercase, however if there is a capital the search becomes case-sensitive.
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
# TODO add --smartcase but it doesnt work in ~ folder for some reason.
# TODO --hidden
# TODO Ctrl-T should show sorted order.
# function _fzf_rg_lookup
#   rg --files --follow --glob "!.git/*" --glob "!Library/"
# end
# function _fzf_git_lookup
#   git ls-tree -r --name-only HEAD
# end
# set -x FZF_DEFAULT_COMMAND '_fzf_git_lookup or _fzf_rg_lookup'
function _bar_fzf_default_command
  # set -l git_res (git ls-tree -r --name-only HEAD ^/dev/null)
  # set -l rg_res (rg --files --follow --glob "!.git/*" --glob "!Library/" ^/dev/null)
  # # set IFS "" # https://stackoverflow.com/questions/29512897/how-to-capture-newlines-from-command-substitution-output-in-fish-shell
  # for var in $rg_res
  #   echo $var
  # end
  # printf $rg_res >&1
  # Here we pipe both errors streams to null.
  sh -c 'git ls-tree -r --name-only HEAD 2>/dev/null || \
    rg --files --follow --glob "!.git/*" --glob "!Library/" 2>/dev/null'
end
set -x FZF_DEFAULT_COMMAND '_bar_fzf_default_command'


# Add a file preview, with syntax highlighting.
# consider adding --reverse
# set -x FZF_DEFAULT_OPTS '--preview "[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi -l {} || coderay {} || rougify {} || cat {})  2> /dev/null | head -500"'
set -x FZF_DEFAULT_OPTS ''

# TODO It is displaying long paths, show relative path only. Not an rg thing it seems.
# Apply to Ctrl-T command as well
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

set -x FZF_CTRL_R_COMMAND 'rg --files'

function _bar_fzf_alt_c_command
  command ag --ignore ".git" --ignore "node_modules/" -g .
end

# rg can't search directories so use ag or bfs
# set -x  FZF_ALT_C_COMMAND "cd ~/; bfs -type d -nohidden | sed s/^\./~/"
set -x FZF_ALT_C_COMMAND '_bar_fzf_alt_c_command'
# set -gx FZF_ALT_C_OPTS "--preview 'tree -C {} | head -200'"

####################################################
# `bobthefish` Theme Specific Settings
####################################################

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




