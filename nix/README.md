# Nix on non-nixos Hosts

~/.nixpkgs/config.nix

is used on non-nix host systems to imperatively describe
environemnts

# TODO configs to adapt
https://github.com/kamilchm/.nixpkgs/blob/master/config.nix


# Common Tasks

## Install everything in config.nix

> Must define an 'all' entry under packageOverrides that includes all envs.

```
nix-env -iA nixpkgs.all
```

## Install a pariticular env in config.nix
```
nix-env -iA nixpkgs.workEnv
nix-env -iA nixpkgs.userEnv
```

## To get desktop apps in gnome search

Symlink the icons from your nix-profile to the gnome icons search path.

```bash
ln -sf ~/.nix-profile/share/applications/* ~/.local/share/applications/
```
