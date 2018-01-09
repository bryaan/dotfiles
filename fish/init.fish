############################################################
#
############################################################

# Reload Fish Config
# source ~/.config/omf/init.fish


set -x DOTFILES_ROOT ~/src/dotfiles

# source $DOTFILES_ROOT/shell/index

############################################################
# bobthefish theme specific
############################################################

# Number of chars to show in abbreviated path. 0=show full path
set -g fish_prompt_pwd_dir_length 3

# For the path rel to project root
set -g theme_project_dir_length 0

set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_title_display_process no
set -g theme_display_vagrant yes
set -g theme_display_docker_machine no
set -g theme_display_virtualenv yes
set -g theme_color_scheme dark
set -g theme_display_ruby no
set -g theme_newline_cursor no
