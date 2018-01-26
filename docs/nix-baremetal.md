

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

## Partitioning

Machine CLASS:

NAME                 MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda                    8:0    0 119.2G  0 disk
├─sda1                 8:1    0   500M  0 part /mnt/boot/efi
└─sda2                 8:2    0 118.8G  0 part
  ├─NixVolGroup-swap 254:0    0     8G  0 lvm  [SWAP]
  └─NixVolGroup-root 254:1    0 110.8G  0 lvm  /mnt

Machine ??:

NAME             MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda                8:0    0 931.5G  0 disk
└─sda1             8:1    0 931.5G  0 part
  └─crypted-data 254:3    0 931.5G  0 crypt /data
nvme0n1          259:0    0 465.8G  0 disk
├─nvme0n1p1      259:1    0   549M  0 part  /boot/efi
└─nvme0n1p2      259:2    0 465.2G  0 part
  └─root         254:0    0 465.2G  0 crypt
    ├─vg-swap    254:1    0     4G  0 lvm   [SWAP]
    └─vg-root    254:2    0 461.2G  0 lvm   /



#### Create the partitions:

> Can also use cgdisk for a curses based install.
> Can find out extra fs types using option L in gdisk.

```
lsblk # Figure out physical disk to partition
$ gdisk /dev/sda # (or whatever device you want to install on)
```

For UEFI Boot Systems:

```
o (create a new empty GUID partition table (GPT))
n (add partition, 1, default, +500M, type ef00 EFI)
n (add partition, 2, default, default, type 8e00 Linux LVM)
p (optionally print partition table)
w (write partition table and exit)
```

Includes BIOS Partition - For use on CLASS
This procedure only on CLASS:

```
o (create a new empty GUID partition table (GPT))
n (add partition, 1, default, +1M,   type ef02 BIOS)
n (add partition, 2, default, +500M, type ef00 EFI)
n (add partition, 3, default, default, type 8e00 Linux LVM)
p (optionally print partition table)
w (write partition table and exit)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048            4095   1024.0 KiB  EF02  BIOS boot partition
   2            4096         1028095   500.0 MiB   EF00  EFI System
   3         1028096       312581774   148.6 GiB   8E00  Linux LVM
```

Some common fs types:
```
ef00 EFI System
ef01 MBR partition scheme
ef02 BIOS boot partition (Where GRUB goes)
8200 Linux swap
8e00 Linux LVM
8300 Linux filesystem
fd00 Linux RAID
```

> If using these instructions on a Debian based install:
> Beware, using 8e00 “Linux LVM” for an LUKS-encrypted LVM partition might confuse the Debian
> installer into destroying your partition in certain circumstances!
> In the apparent absence of a dedicated LUKS code, go with 8301 “Linux reserved”.

##### If you mess up:
1. Delete partitions using gdisk and option `d`, then write with `w` and reboot.
2. Use `vgdisplay` to see the names of all LVM volume groups.  Then delete each one with `vgremove <vg-name>` (Might have to umount some disks)


[example partioning for: boot grub swap root](https://www.funtoo.org/Partitioning_using_gdisk)


#### Setup LVM

TODO look into using LVM2

Conventions:
Solid State Drive: sd<drive_letter>
Hard Disk: hd<drive_letter>
NVMe Drive: nvme<drive_number>

[Why ext4](https://www.phoronix.com/scan.php?page=article&item=linux-412-fs&num=2)

Another way to look at is this:
```
    sda1   sdb2      (PV:s on partitions or whole disks)
       \   /
        \ /
       diskvg        (VG)
       /  |  \
      /   |   \
  homelv rootlv varlv (LV:s)
    |      |     |
 ext4  ext4  xfs (filesystems)
```

PVs are setup for each partition we create with gdisk.

> Sets up 8G of SWAP and uses rest for root.
> TODO setup a seperate HOME volume, but for my servers not important.


```
lsblk   # to verify the partitions just created.  Those are added to the volumes below.

export PhysicalVolumes='/dev/sda3' # Note we do not include the bios or efi partition
export PhysicalVolumes='/dev/mapper/crypted-nixos' # mapper is used when dealing with encrypted partitions. additional setup required. TODO should i just delete this?

export vg_name=nix-vg

$ pvcreate $PhysicalVolumes
$ vgcreate $vg_name $PhysicalVolumes
$ lvcreate --size 8G --name swap $vg_name
$ lvcreate --extents '100%FREE' --name root $vg_name
```

#### Format and mount the partitions:

boot_device is the EFI Partition, never the BIOS partition

```
export boot_device=/dev/sda2  # Or with nvme drive /dev/nvme0n1p1
export root_device=/dev/$vg_name/root
export swap_device=/dev/$vg_name/swap

$ mkfs.fat -F 32 $boot_device  # EFI partition requires FAT32
$ mkfs.ext4 -L root $root_device
$ mkswap -L swap $swap_device

$ mount $root_device /mnt
$ mkdir -p /mnt/boot/efi
$ mount $boot_device /mnt/boot/efi
$ swapon $swap_device

```

export home_device=/dev/$vg_name/home   #mapper/crypted-data
export data_device=/dev/$vg_name/data   #mapper/crypted-data

$ mkfs.ext4 -L home $home_device
$ mkfs.ext4 -L data $data_device

Not sure if this line is needed
$ mount $data_device /mnt/home


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

TODO add to file below: to fix vim cant moe cursor:
export TERM=xterm

TODO The left right keys still dont work in bash.  May have to set keybindings for it. Or just use fish!

{ config, pkgs, ... }:
{

  # This fixes some keyboard issues.
  environment.variables.TERM = "xterm";

  # Boot settings.
  boot = {
    loader.efi.efiSysMountPoint = "/boot/efi";
    loader.grub = {
      enable = true;
      version = 2;
      efiSupport = true;
      # Drive to install GRUB on.
      device = "/dev/sda"; # or "nodev" for UEFI only
    };
  };

  networking.hostname = "classified";

  # enable sshd on boot
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    # TODO This was for before i have this file being copied. remove it bc user logs in with keypair.
    permitRootLogin = "yes";
  };

  users.extraUsers.bryan = {
    name = "bryan";
    group = "users";
    extraGroups = [
      "wheel" "disk" "audio" "video"
      "networkmanager" "systemd-journal"
    ];
    createHome = true;
    uid = 1000;
    home = "/home/bryan";
    shell = "/run/current-system/sw/bin/bash";
    # TODO use a file instead. reference guest.nix
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDa9ZfwADEW6fmUs+1IQb8/kmi9winuu+zsFPV90P2igrWvq/lN2MvNHdTicrsjKgIwWzpHNxAVh0/HS8mQH2CXg40XA5vGZjpWKQ9RUxCs6mUKk93kHlSkYluIyyRVtiPH+4gAEMaQDdkKjpUqW6dUAJklymtZs8mU48DtM2DcE+JkLdvyr5WzDZaHLiHGdlwWvTZ4l+Vx2gNmNuzQS3cKoFCnZlYTXHnNCtB50sHj1k8KIOp58T+3GF9mwDH3DbiPpVVvxDbsz5qkDK1Rz6hCO6W6tYY/sXGslxt67LnFGhLJLU7T+6atNHHtOLRrPTEAM0EBgYD5QBGW6lbp2ZL7uf7Yeuboe5WYCUfo/4CPGfmQA+LbZT1imchEqWfksp770OdbYtEAqYYsbDgLawDGCXnXHWkxEUsyOC0GkklkZ5y9cIrjAe50LPYvx7v7+pxmcI6npgy1/xY4YFYLI85GQsbEFvnFrI1UUJttp5pjeKJbpGaVIn9lOMkgfFMM2O84qFGPtdED1hLnbCxYW5I2OpAr5Amj+abXNSV4nlW/M/o2hgIWA4v0KiqsK9GrCiEzxNViHSWdWPeM5n6+zn2y57WTj8YQ3j7S0ieoOZpWzmG4wdfqnINU7CWgvau49p9rNUr0SYEGkXfYdI8hEpErUqr2oYTqoVSt/Qiy4ArUlw== bryan@Bryans-Air"
    ];
  };

}



# Updating NixOS

[Upgrade Docs](https://nixos.org/nixos/manual/index.html#sec-upgrading)
[Auto Upgrade Docs](https://nixos.org/nixos/manual/index.html#idm140737316801280)

```
# nix-channel --add https://nixos.org/channels/nixos-17.09 nixos
# nix-channel --add https://nixos.org/channels/nixos-17.09-small nixos
# nix-channel --add https://nixos.org/channels/nixos-unstable nixos

# nixos-rebuild switch --upgrade
```


TODO If doing a UEFI system this guide must be modified

Config File:
- For UEFI systems there are differences.
https://nixos.org/nixos/manual/index.html#sec-uefi-installation

graphical install is easy but should be avoided for now, for simplicity.
very simple basefile with nvidia and amd drivers.








#### Encryption

If you want encrypted disks we set that up first:

> If you want system to boot on restart without entering pw you need to setup a keyfile.

These guys put it quite well:
https://unix.stackexchange.com/questions/342927/where-should-i-store-encryption-keyfiles

Full disk encryption with the keyfiles residing locally is useless.  Steal the disk with keys and your pwned.  So either:
1. type pw at boot everytime
1. use a usb key (don't leave it lying around!)
1. pull keys from a secure network device on boot (if disk was known to be compromised you could pull the key, or restrict access from outside network) would require a custom script and server.
1. similar to previous but less work, maybe. only encrypt data storage drives, mount them when in userland using a pw fetched from secure network server.
1. dont use luks, instead use a layer of encryption inside the system which also prevents in-system software based attacks.


Generate keys for single password unlock
```
$ dd if=/dev/urandom of=./keyfile0.bin bs=1024 count=4
$ dd if=/dev/urandom of=./keyfile1.bin bs=1024 count=4
```

Setup LUKS and add the keys
```
$ cryptsetup luksFormat -c aes-xts-plain64 -s 256 -h sha512 /dev/nvme0n1p2
$ cryptsetup luksAddKey /dev/nvme0n1p2 keyfile0.bin
$ cryptsetup luksOpen /dev/nvme0n1p2 crypted-nixos

$ cryptsetup luksFormat -c aes-xts-plain64 -s 256 -h sha512 /dev/sda1
$ cryptsetup luksAddKey /dev/sda1 keyfile1.bin
$ cryptsetup luksOpen /dev/sda1 crypted-data
```

Without keys, must enter pw every boot:

$ cryptsetup luksFormat /dev/sda2
$ cryptsetup luksOpen /dev/sda2 enc-pv



If encryption with keyfiles was setup then we must create an initrd that contains them.
Do this after creating partitions and mounting (as it requires /mnt/boot to be available)
Create an initrd which only contain the key files

TODO we wouldnt write to an initrd as explained above, just have code here for future use.

```
$ find keyfile*.bin -print0 | sort -z | cpio -o -H newc -R +0:+0 --reproducible --null | gzip -9 > /mnt/boot/initrd.keys.gz
$ chmod 000 /mnt/boot/initrd.keys.gz
```




# Notes

### Why gdisk:
- gdisk is newer than fdisk and works on partitions > 2TB.
- UEFI is not a requirement to use gdisk.

### Why LVM:
- resizable disk
- snapshot backups - actually more involved, will require scripts.
- make sure to not extend across physical drives bc of failure 1 drive out both are lost.

- since nixos makes it declarative for us to build we just dont need the backup features.
- For a home folder backups do make sense, but likely better to use a tool like rsync or whatever.
  Only benefit of lvm in this case is resizeable disk but only use case i see is when home and swap are on same disk, and we want to change swaps size.

### Why "no" encryption
- Because I need the server to restart gracefully when I am not physically present and power outages are a problem.
- Because I don't have time to write the secure network key server and install scripts.
- Because its better to have userland encryption as that tends to protect against more attack types.


# Resources & Thanks

https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134
https://gist.github.com/ladinu/bfebdd90a5afd45dec811296016b2a3f

https://debian-administration.org/article/410/A_simple_introduction_to_working_with_LVM
http://tldp.org/HOWTO/LVM-HOWTO/anatomy.html
http://tldp.org/HOWTO/LVM-HOWTO/commontask.html


People who spend their time telling others what can't be done only annoy those of us out there doing it.

