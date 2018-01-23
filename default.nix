with import <nixpkgs> {};
stdenv.mkDerivation rec {
  name = "env";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = [
    nodejs-slim-8_x
    yarn
    python3
    python36Packages.virtualenv
    python36Packages.pip
    python36Packages.jinja2
    go_1_9
  ];
}

# buildInputs
# - must use the package attribute name.

# nix-env -i python3-3.6.4
# nix-env -i python3.6-pip-9.0.1
# nix-env -i python3.6-Jinja2-2.9.6
# python3   python3Full   python36Full

# To run:
# cd $DOTFILES_ROOT
# nix-shell --command 'env HOME=/tmp/foo fish'
#
# To start fish with a new rc file so it doesnt inherit sys path.
# Or what if we make fish the default shell of this env? is that possible?
# actually if we install fish, here it might just work.
# 'env HOME=/tmp/foo fish'