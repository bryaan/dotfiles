# Resources

!!! README - Nix guide
[ebzzry guide to nix](https://ebzzry.io/en/nix/#environments)


# Reference

## nix-shell
-p <package> looks up package in the Nix search path.
-I nixpkgs=<url> can set lookup path to custom nixpkgs revision.

### With a default.nix in project root: ###
nix-shell --command 'env HOME=/tmp/foo fish'


## nix-env
-q --query
-i --install
-e --uninstall
-P   add this to find out package 'attribute path' (normally shows 'symbolic name')

To rollback
nix-env --rollback

### List all installed packages ###
nix-env -q --installed

### Search for all versions of python 3 ###
nox python | rg 'python3-([0-9]+([.][0-9]+)+)'
nix-env -qa | rg 'python3-([0-9]+([.][0-9]+)+)'
nox python | rg python3-3.5

Will match
	python3-3.4.7
	python3-3.4
Wont match
	python3-3
	python3
	python3.4-arelle-2017-08-24-2017-08-24
	python3.6-3to2-1.1.1

TODO Should match
	python3
	python3-3  Maybe?


# Define an env entry in ~/.nixpkgs/config.nix

Demo the environment:
nix-shell -p workEnv

Install with:
nix-env -iA nixos.workEnv
nix-env -iA nixpkgs.workEnv
nix-env -f "<nixpkgs>" -iA workEnv

You can figure out what the prefix should be by running `nix-env -qaP coreutils` and observing its prefixes.  worstcase you can add the -f flag:
nix-env -f "<nixpkgs>" -iA workEnv
But generally it should be 'nixpkgs' if not on nixos and 'nixos' if on nixos.


### A check/verify/fix command for the nix store
nix-store --verify --check-contents --repair


--------------------------------------------------------------------------------

TODO create system env; add these packages
nix-env -i nox

TODO Bring python into virtualenv so we can install pip packages.
Should do this for the systemenv and for jupyter but not dotfiles.


TODO The system's current PATH is being copied to the nix-shell.  Readmore in pathfile

TODO nix package search website must not be working on master.
Run search for yarn, click on link to nixpkgs file on github and look at branch isnt master, and version is older.  master is on most recent at 1.3.2


TODO some kind of indication that we are in a nix-shell
- prob not needed since realizing we won't be interacting much with shell directly.
also if its possible to be in a nix-env show that too.
look at bobthefish theme docker python etc examples.


TODO bring in 
They have nix specific imports.
/etc/profile   (sh shell)
/etc/bashrc
/etc/zshrc
is there a fish one?


TODO check resolution
https://github.com/NixOS/nixpkgs/issues/34165


https://github.com/NixOS/nixpkgs/issues/5623

Track this on supporting fish/zsh
https://github.com/NixOS/nix/issues/498
https://github.com/NixOS/nix/pull/545


nix-env -i nixpkgs.python35
nix-env -i nixpkgs.python35Full
nix-shell -p pythonPackages.django


Can pass rcfile and history options to the shells to further customize.
nix-shell '<nixpkgs>' -A hello --command "exec zsh; return"
nix-shell '<nixpkgs>' -A hello --command "exec fish; return"
nix-shell -p workEnv --command "exec fish; return"
nix-shell -p workEnv --command fish



### Regex to match semantic versioning  x.x and x.x.x ###
```bash
echo $xxx | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/')
```

### To use fish shell with same config as user in nix-shell ###
- Since there is no way to change fish's config file pointer, we reset the HOME instead.
```bash
nix-shell --command 'env HOME=/tmp/foo fish'
```

### Using nix-shell as an interpreter to download script reqs. ###
```
#! /usr/bin/env nix-shell
#! nix-shell -i <real-interpreter> -p <packages>

#! /usr/bin/env nix-shell
#! nix-shell -i python3 -p jinja2 setuptools
```



# To 'install' or use python pakcages can:
1. declartively specify which packages to use in a nix config
with key python.buildEnv google search it.
2. use nix-env to find and install the python package.
3. use nix-shell to create a python env with everything required.





