with import <nixpkgs> {};
with python35Packages;

python.buildEnv.override rec {

  extraLibs = [ numpy scipy ipython ];
}

# Create an isolated env with:
# Install to profile with:  nix-env -i -f build.nix
