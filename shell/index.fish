####################################################
# Here we source all files in the /shell directory.
####################################################

# SHOULD_INIT is used so the block only runs once.
set -l SHOULD_INIT 1

if set -q BRYDOTS_IS_NIXSH_ENV
  set -e SHOULD_INIT
end

if set -q SHOULD_INIT

  set -x __BRYDOTS_DO_ONE_SHOT_SETUP 0

  function _should_do_one_shot_setup
    [ $__BRYDOTS_DO_ONE_SHOT_SETUP = 1 ]
  end

  function one_shot_setup -d "set system defaults from dotfiles"
    echo "performing one_shot_setup..."
    set -x __BRYDOTS_DO_ONE_SHOT_SETUP 1

    echo "one_shot_setup --- load_all_files ..."
    load_all_files

    echo "one_shot_setup --- sh set-defaults.sh ..."
    if [ $__BRYDOTS_ENV_PLATFORM = "linux" ]
      sh ./linux/gnome-set-defaults.sh
    else if [ $__BRYDOTS_ENV_PLATFORM = "macos" ]
      sh ./macos/set-defaults.sh
    end

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
      echo '[WARN](shell/index.tpl) unknown host OS: (uname -a)'
      setenv __BRYDOTS_ENV_PLATFORM 'linux'
  end

  ###################
  # Set Workstation-specific env vars
  # These are used to optionally enable/disable or change
  # behaviour of functions throughout.
  ###################
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
      echo '[WARN](shell/index.tpl) unknown hostname: (hostname)'
      setenv __BRYDOTS_ENV_GEO '???'
  end

  function load_all_files
    # === source fish functions ===
    # source functions first as they are base level.
    # Every other folder's functions will depend on them.
    # They don't depends on any function, unless they source it themselves.
    set -l functionFiles (command rg --files --glob "functions/*.fish" \
      $DOTFILES_ROOT/shell/functions)

    for file in $functionFiles
      #echo [DEBUG] $file
      source $file
    end

    # === source fish files ===
    # Sources all *.fish files in shell/*
    # - Don't include index.fish (infinite import loop) or functions/ folder.
    set -l files (command rg --files --glob "*.fish" \
      --glob "!*/index.fish" --glob "!functions/*" \
      $DOTFILES_ROOT/shell)

    for file in $files
      source $file
    end

    # === Explicit Imports ===
    # Explicitly source all *.fish files outside of ./shell
    source $DOTFILES_ROOT/bootstrap/dotfiles.fish
    source $DOTFILES_ROOT/development/ncl.fish
    source $DOTFILES_ROOT/git/git.fish
    source $DOTFILES_ROOT/nix/nix.fish
  end

  # === Load pathfile ===
  source $DOTFILES_ROOT/shell/init.pathfile

  # === Load nix ===
  #

  # === Load fish files ===
  load_all_files
end
