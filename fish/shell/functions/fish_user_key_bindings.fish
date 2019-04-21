# TODO move to ./fish but first must move those files there now into a
# subfolder and also change the approp code
function fish_user_key_bindings

  bind -M insert \cl 'clear; commandline -f repaint'

  # === imports ===
  shell-search.keybindings
end
