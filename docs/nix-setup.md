
## Install Nix and Fish (RHEL 7)

TODO These instructions are out of date!

```
curl https://nixos.org/nix/install | sh
source /home/bryan/.nix-profile/etc/profile.d/nix.sh

nix-env -i fish
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fish
set PATH ~/.nix-profile/bin $PATH
fisher install
chsh -s (which fish)
```

> None of these commands were neccessary. First install didn't seem to work, but deleting all nix folders in root and home dirs and reinstall worked.  Make sure to use bash shell.

nix-channel --add https://nixos.org/channels/nixos-17.09 nixos
nix-channel --update


## To install from unstable while running stable

> Shouldnt need to do this, even on non nix host.
> First check you have unfree packages enabled.
> Then just add the unstable channel the normal way.

git clone https://github.com/NixOS/nixpkgs.git ~/.nixpkgs/channels/unstable
nix-env -iA nixos.firefox -f ~/nixpkgs-unstable
nix-env -iA nixos.slack -f ~/.nixpkgs/channels/unstable

To instead download without the git repo, by specifying a Nixpkgs/NixOS channel:
$ nix-env -f https://github.com/NixOS/nixpkgs-channels/archive/nixos-14.12.tar.gz -iA firefox


## COMMANDS

nix-env -i ...  # Install
nix-env -e ...  # Uninstall
nix-env -q --installed # List Installed
nox ...         # Search
