# .nixpkgs/config.nix
# nix-env -iA nixpkgs.workEnv
{
  packageOverrides = pkgs: with pkgs; {

    # New improved way to do it:
    # https://github.com/NixOS/nixpkgs/pull/15804
    # https://github.com/NixOS/nixpkgs/issues/15801
    # https://github.com/NixOS/nixpkgs/issues/5623
    # workEnv = python36.withPackages (ps: [
    #   ps.setuptools
    #   ps.jinja2
    # ]);
    # workEnv2 = python35Full.withPackages (ps: [
    #   ps.setuptools
    #   ps.json
    # ]);

    jupyterEnv = python36.withPackages (ps: [
      ps.setuptools
      ps.numpy
      ps.scipy
      ps.ipython
    ]);

    # https://github.com/st4nson/nixfiles/blob/7a64212409d81a39e1385112d4e030e7b289b695/nixpkgs-config.nix
    workEnv = pkgs.buildEnv {
      name = "workEnv";
      paths = [
        (python27.withPackages(ps: with ps; [

        ]))
        (python36.withPackages(ps: with ps; [
          setuptools
          jinja2
        ]))
      ];
    };

    # Idea is we use a single command to start a shell
    # with python and node.  In this shell we can call gulp.
    # Now we should have all deps required on any system to build dotfiles.
    dotfilesEnv = pkgs.buildEnv {
      name = "dotfilesEnv";
      paths = [
        (python36.withPackages(ps: with ps; [
          setuptools
          jinja2
        ]))
      ];
    };

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

