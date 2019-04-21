# # TODO need to add symlink stuff for the sublime files.
# # Pull section from readme.
# # Only runs if sublime is installed.
# setup_sublime() {
#   info 'setting up sublime'
#   # TODO Update with chnages
#   # # This just links the subl binary to ~/.local/bin/
#   # # Only needed on mac.
#   # if [[ "$platform" == 'macos' ]]; then
#   #   local subl_app_path="/Applications/Sublime Text.app"
#   #   local subl_bin_path=$subl_app_path/Contents/SharedSupport/bin/subl
#   #   if [ -d "$subl_app_path" ]; then
#   #     ln -sf $subl_bin_path $HOME/.local/bin/
#   #   else
#   #     warn_not_installed "Sublime Text"
#   #   fi
#   # fi
#   success 'sublime setup complete!'
# }