

This file is mostly semi-organized notes.  Need to split stuff into mini-howtos.


To install class:
1. copy configuration.nix over as intial config
2. use nix-install-classified.sh script and install
3. scp full config and reinstall


# Installation media setup

Download NixOS minimal iso and copy to USB stick.

Check hash
```
$ pv nixos-minimal.iso | openssl sha256
```

On Mac OSX
```
$ diskutil list
$ diskutil unmountDisk /dev/disk2 # Make sure you got right device
$ dd if=nixos-minimal.iso | pv | dd of=/dev/disk2
```

TODO get file size and replace 2G
dd if=nixos-minimal.iso | pv -s 2G | dd of=/dev/disk2


# NixOS install

Boot from the USB stick and setup networking.

Setup SSH to continue from another computer:
```
ifconfig  # to get ip
passwd    # to set pass for root
systemctl start sshd
```


Copy to host:
```
scp file.txt username@to_host:/remote/directory/

scp -r ~/src/nix-configs/class/ username@to_host:/etc/nixos/
```

Copy from host:
```
scp root@10.0.1.135:file.txt ~/Desktop/
```



# Generate NixOS Config

```
$ nixos-generate-config --root /mnt

TODO This should just be same file as below
$ vim /mnt/etc/nixos/configuration.nix
boot.loader.grub.efiSupport = true;
boot.loader.grub.efiSysMountPoint = "/boot/efi"
boot.loader.grub.device = "/dev/sda"
networking.hostname = "..."
```

# Install NixOS

```
 nixos-install
```

# On First Login

```
# Change root password (if install script was used)
passwd

nixos-generate-config

TODO vim /etc/nixos/configuration.nix

- add user
- enable ssh
- enable graphical?
- add amd and nvidia drivers
- copy start miner script TODO copy from centos

nixos-rebuild switch

# After reboot set the new user's passwd
passwd bryan
```

> Note the configuration.nix from before is erased as it was only for writing things to proper boot locations.

> adding user to "wheel" group gives them access to sudo.




# Updating NixOS

[Upgrade Docs](https://nixos.org/nixos/manual/index.html#sec-upgrading)
[Auto Upgrade Docs](https://nixos.org/nixos/manual/index.html#idm140737316801280)

```
# nix-channel --add https://nixos.org/channels/nixos-17.09 nixos
# nix-channel --add https://nixos.org/channels/nixos-17.09-small nixos
# nix-channel --add https://nixos.org/channels/nixos-unstable nixos

# nixos-rebuild switch --upgrade
```




