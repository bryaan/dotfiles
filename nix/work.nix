#  !  /usr/bin/env nix-exec
with import <nixpkgs> {};

python36.withPackages (ps: with ps; [
  jinja2
])



# { pkgs ? import <nixpkgs> {} }:

# with pkgs;
# stdenv.mkDerivation {
#   name = "shell";
#   buildInputs = [ hello emem ];
# }

# Install with:
# nix-env -if ~/.nixpkgs/work.nix

# Actually more appropriate to use this as only a dev-env => nix-shell
# $ nix-shell -p ~/.nixpkgs/work.nix
# nix-shell '<nixpkgs>' --command fish -p ~/.nixpkgs/work.nix


# $ nix-shell --packages hello --pure --run hello


# nix-shell -p ~/.nixpkgs/work.nix  --command fish
# nix-shell -p ~/.nixpkgs/work.nix --command "exec fish; return"
