###
# Here we source init.pathfile and all fish files in the /shell directory.
#

# Make sure this function only runs once per shell reload.
# TODO Why was this needed?
set -l SHOULD_INIT 1

if set -q BRYDOTS_IS_NIXSH_ENV
  set -e SHOULD_INIT
end

if set -q SHOULD_INIT

  set -x __BRYDOTS_DO_ONE_SHOT_SETUP 0

  function _should_do_one_shot_setup
    [ $__BRYDOTS_DO_ONE_SHOT_SETUP = 1 ]
  end

  # TODO Verify this is running. Or just remove bc what does it do?
  # After all I do believe this file only runs once per shell negating the need for this.
  function one_shot_setup -d "set system defaults from dotfiles"
    echo "Performing one_shot_setup..."
    set -x __BRYDOTS_DO_ONE_SHOT_SETUP 1

    echo "one_shot_setup --- load_all_files ..."
    load_all_files

    # Removed bc sometimes these fall out of sync. It's best to do manually, 
    # if at all beyond the first time.
    # echo "one_shot_setup --- sh set-defaults.sh ..."
    # if [ $__BRYDOTS_ENV_PLATFORM = "linux" ]
    #   sh ./os_linux/gnome-set-defaults.sh
    # else if [ $__BRYDOTS_ENV_PLATFORM = "macos" ]
    #   sh ./os_macos/set-defaults.sh
    # end

    echo "one_shot_setup complete!"
    set -x __BRYDOTS_DO_ONE_SHOT_SETUP 0
  end

  # if [ $__BRYDOTS_ENV_PLATFORM = "macos" ]
  # if [ $__BRYDOTS_ENV_PLATFORM = "linux" ]
  switch (uname -a)
    case "*Darwin*"
      setenv __BRYDOTS_ENV_PLATFORM "macos"
    case "*Linux*"
      setenv __BRYDOTS_ENV_PLATFORM "linux"
    case '*'
      # no need to fail if unkown, if some fun somewhere does if unkn,
      # fail there but nor here.
      echo '[WARN](shell/index.tpl) Unknown Host OS:' (uname -a)
      setenv __BRYDOTS_ENV_PLATFORM 'linux'
  end

  ###################
  # Set Workstation-specific env vars
  # These are used to optionally enable/disable or change
  # behaviour of functions throughout.
  ###################
  # TODO You should be able to write a grep on a config file and do this with less code.
  switch (hostname)
    case 'dev-ncl*'
      setenv __BRYDOTS_ENV_GEO 'work'
    # case "*Linux*"
    # TODO fix with home hosts
    case '*'
      setenv __BRYDOTS_ENV_GEO 'home'
    case '*'
      # no need to fail if unkown, if some fun somewhere does if unkn,
      # fail there but nor here.
      echo '[WARN](dotfiles/shell/index.tpl) Unknown Hostname:' (hostname)
      setenv __BRYDOTS_ENV_GEO '???'
  end

  function load_all_files

    # === Source Fish Functions ===
    # First source helper functions as they are dependencies of rest.
    # TODO These should actually be on the PATH, that way they don't need to
    # source other helper function dependencies from within a function that uses one.
    set -l files (command rg --files \
      --glob "*.fish" \
      $DOTFILES/shell/functions)

    # === Source Fish Files ===
    # Sources all *.fish files in shell/*
    # - Don't include index.fish (infinite import loop) or functions/ folder.
    set -l files $files (command rg --files \
      --glob "*.fish" \
      --glob "!index.fish" \
      --glob "!functions/*" \
      $DOTFILES/shell)

    for file in $files
      # echo \n\n [DEBUG] $file \n $PATH
      source $file
    end

    # === Source Explicit ===
    # Explicitly source all *.fish files outside of ./shell
    source $DOTFILES/bootstrap/dotfiles.fish
    source $DOTFILES/development/ncl.fish
    source $DOTFILES/git/git.fish
    source $DOTFILES/nix/nix.fish
  end

  # === Load pathfile ===
  source $DOTFILES/shell/init.pathfile

  # === Load Fish Files ===
  load_all_files

end
