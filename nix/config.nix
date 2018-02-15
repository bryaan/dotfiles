# .nixpkgs/config.nix
# nixpkgs/config.nix site:github.com
# https://github.com/kamilchm/.nixpkgs
#
# nix-env -iA nixpkgs.workEnv
# nix-env -iA nixpkgs.userEnv
# For more info and examples check out `nix-env --help`
#
# Error Package Overwrite: should be solvable by:
# 1. Remove pacakge from its env, then install that env again and it shoudl remove symlinks.
# 2. If that fails then remove it:  nix-env -e /nix/store/y3cgx0xj1p4iv9x0pnnmdhr8iyg741vk-gcc-3.4.3
#
{
  allowUnfree = true;

  # TODO Define custom packages
  #foo = import ~/.nix-defexpr/foo;
  #bar = import ~/.nix-defexpr/bar;
  # there is also: https://github.com/kamilchm/.nixpkgs/blob/master/config.nix

  packageOverrides = pkgs: with pkgs; {

    userEnv = pkgs.buildEnv {
      name = "user-env";
      paths = [
        # === communication ===
        slack
        signal-desktop
      ];
    };

    # TODO check out packages here
    # https://gist.github.com/spinus/c9ab55a02d557245cc5d2d83be606eaa

    # TODO secondary installs
    # vimpager - from github compile
    # yarn global add gulp tern

    # # TODO add to config.nix
    # syncthing
    # syncthing-inotify
    # borgbackup
    # encfs
    # gnupg
    # gitAndTools.git-annex
    # sl
    # sshfsFuse

    # TODO https://github.com/herrbischoff/awesome-command-line-apps
    # jq httpie ranger clog-cli

    # TODO add hub
    # https://hub.github.com/

    systemTools = pkgs.buildEnv {
      name = "system-tools";
      paths = [
        fish
        git
        # === file-tools ===
        exa ripgrep ag fd
        # TODO cargo install skim
        axel
        # === perf-tools ===
        iftop iotop
        # pip install glances
        # === system-tools ===
        dtrx # archive swiss knife
        cargo
        tmux
        # file # this is basic sys command, does nix come with it? if not move these very basic ones to a nix only env.
        sqlite-interactive
        # tcpdump
        # telnet
        # tree
        # unrar
        # unzip
        # pigz
        # traceroute
      ];
    };

    # This one is for use on any linux. not mac.
    linuxEnv = pkgs.buildEnv {
      name = "linux-env";
      paths = [
        gnome3.dconf-editor
        enlightenment.terminology
        patchelf
        xsel xclip
        #;; binutils - i think linux/nix only
        #enlightenment.efl # needed to build terminologoy-themes-git
        mc # Midnight Commander File Browser
      ];
    };

    devEnv = with pkgs; buildEnv {
      name = "dev-env";
      paths = [
        # Nox should only be used for searching packages. TODO proxy command?
        nox
        #
        gcc
        cmake
        # gnumake
        yarn
        sublime
        #rustc
        #;; rustBeta.cargo
        # === emacs ===
        emacs
        mu
        offlineimap
        ctags
        # === vim ===
        vim
        vimPlugins.vundle
        # gtk-config
        # termite-config
        # qtile-config
        # bash-config
        # elixir-config
        # TODO these should go in funops/devenv
        vim
        vimPlugins.vundle
      ];
    };

    # jupyterEnv = python36.withPackages (ps: [
    #   ps.setuptools
    #   ps.numpy
    #   ps.scipy
    #   ps.ipython
    # ]);

    # # New improved way to do it:
    # # https://github.com/NixOS/nixpkgs/pull/15804
    # # https://github.com/NixOS/nixpkgs/issues/15801
    # # https://github.com/NixOS/nixpkgs/issues/5623
    # # python36 python35Full python27
    # # workEnv = python36.withPackages (ps: [
    # #   ps.setuptools
    # #   ps.jinja2
    # # ]);

    # # https://github.com/st4nson/nixfiles/blob/7a64212409d81a39e1385112d4e030e7b289b695/nixpkgs-config.nix
    # workEnv = pkgs.buildEnv {
    #   name = "work-env";
    #   paths = [
    #     (python27.withPackages(ps: with ps; [

    #     ]))
    #     (python36.withPackages(ps: with ps; [
    #       setuptools
    #       jinja2
    #     ]))
    #   ];
    # };

  };
}

# # https://github.com/NixOS/nixpkgs/issues/10597#issuecomment-159274900
# packageOverrides = pkgs: with pkgs; {
#     workEnv = pkgs.myEnvFun {
#         name = "work";
#         buildInputs = [
            # python34
            # python34Packages.ipython
            # python34Packages.numpy
            # python34Packages.scipy
            # python34Packages.matplotlib
            # python34Packages.pandas
#         ];
#     };

# # custom python environment with python packages embedded
# # nixos isolates each language specific dependency, they are not automatically exposed to the interpreter
# # note that this should not be used for development
# # only for IDE integration and experiments
# pythonEnv = with pkgs; buildEnv {
#   name = "pythonEnv";
#   paths = [
#     (with python27Packages; python.buildEnv.override {
#         extraLibs = [
#           setuptools
#           numpy
#         ];
#     })
#     (with python35Packages; python.buildEnv.override {
#         extraLibs = [
#           setuptools
#           jedi
#           flake8
#           numpy
#           isort
#           yapf
#           pytest
#         ];
#     })
#   ];
# };

