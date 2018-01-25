

# Installation media setup

Download NixOS minimal iso and copy to USB stick. For example on Mac OSX

$ diskutil list
$ diskutil unmountDisk /dev/disk1 # Make sure you got right device
$ dd if=nixos-minimal-17.09.2378.af7e47921c4-x86_64-linux.iso of=/dev/disk1

# NixOS install

Boot from the USB stick and setup networking. (optionally setup SSH if you want to complete the install from another computer)



## Partitioning

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

```
# fdisk /dev/sda # (or whatever device you want to install on)
# mkfs.ext4 -L nixos /dev/sda1
# mkswap -L swap /dev/sda2
# swapon /dev/sda2
# mount /dev/disk/by-label/nixos /mnt
# nixos-generate-config --root /mnt
# nano /mnt/etc/nixos/configuration.nix
# nixos-install
# reboot
```

#### Create the partitions:

TODO for classified need to use MBR not GPT i think.
MBR vs GPT
BIOS vs EFI/UEFI
I think class can do both GPT and EFI.

> Can also use cgdisk for a curses based install.

[example partioning for: boot grub swap root](https://www.funtoo.org/Partitioning_using_gdisk)


Create a 500MB EFI boot partition, and parition the rest for LVM.

```
$ gdisk /dev/sda # (or whatever device you want to install on)
```

o (create new empty partition table)
n (add partition, default, default, +500M, type ef00 EFI)
n (add partition, remaining space, type 8e00 Linux LVM, Read note below if installing Debian)
w (write partition table and exit)

ef00 EFI System
ef01 MBR partition scheme
ef02 BIOS boot partition (Where GRUB goes)
8200 Linux swap
8e00 Linux LVM
8300 Linux filesystem
fd00 Linux RAID

> Beware, using 8e00 “Linux LVM” for an LUKS-encrypted LVM partition might confuse the Debian
> installer into destroying your partition in certain circumstances!
> In the apparent absence of a dedicated LUKS code, go with 8301 “Linux reserved”.


#### Setup LVM

TODO look into using LVM2

Conventions:
Solid State Drive: sd<drive_letter>
Hard Disk: hd<drive_letter>
NVMe Drive: nvme<drive_number>

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

mkfs.ext4
mkfs.xfs
mkfs.btrfs
[Why ext4](https://www.phoronix.com/scan.php?page=article&item=linux-412-fs&num=2)


PVs are setup for each partition we create with gdisk.

> Sets up 8G of SWAP and uses rest for root.
> TODO setup a seperate HOME volume, but for my servers not important.


```
export PhysicalVolumes='/dev/mapper/nixos'
export PhysicalVolumes='/dev/mapper/crypted-nixos' # Could use this as well.
export PhysicalVolumes='/dev/sda /dev/hda /dev/hdb' # Or even this.

export vg_name=NixVolGroup


$ pvcreate $PhysicalVolumes
$ vgcreate $vg_name $PhysicalVolumes
$ lvcreate --size 8G --name swap $vg_name
$ lvcreate --extents '100%FREE' --name root $vg_name
```

#### Format and mount the partitions:

```
export boot_device=/dev/sda1  # Or with nvme drive /dev/nvme0n1p1
export root_device=/dev/$vg_name/root
export swap_device=/dev/$vg_name/swap

$ mkfs.fat -F 32 $boot_device  # EFI partition requires FAT32
$ mkswap -L swap $swap_device
$ mkfs.ext4 -L root $root_device

$ mount $root_device /mnt
$ mkdir -p /mnt/boot/efi
$ mount $boot_device /mnt/boot/efi
$ swapon $swap_device

```

export home_device=/dev/mapper/crypted-data
export data_device=/dev/mapper/crypted-data

$ mkfs.ext4 -L home $home_device
$ mkfs.ext4 -L data $data_device


Format the partitions and mount

$ mkfs.fat -F 32 /dev/nvme0n1p1
$ mkswap -L swap /dev/vg/swap
$ mkfs.ext4 -L root /dev/vg/root
$ mkfs.ext4 -L data /dev/mapper/crypted-data

$ mount /dev/vg/root /mnt
$ mkdir -p /mnt/boot/efi
$ mount /dev/nvme0n1p1 /mnt/boot/efi
$ swapon /dev/vg/swap






Follow instructions:
https://nixos.org/nixos/manual/index.html#sec-installation
(bring them over here for now, a script can be made of it later if we must redo)



Copy scripts and files over somehow. Curl. Another USB? partition on same usb, is that even posssible?





Config File:
- For UEFI systems there are differences.
https://nixos.org/nixos/manual/index.html#sec-uefi-installation

graphical install is easy but should be avoided for now, for simplicity.
very simple basefile with nvidia and amd drivers.



{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.device = "/dev/sda";

  # Note: setting fileSystems is generally not
  # necessary, since nixos-generate-config figures them out
  # automatically in hardware-configuration.nix.
  #fileSystems."/".device = "/dev/disk/by-label/nixos";

  # Enable the OpenSSH server.
  services.sshd.enable = true;
}














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

Why LVM:
- resizable disk
- snapshot backups - actually more involved, will require scripts.
- make sure to not extend across physical drives bc of failure 1 drive out both are lost.

- since nixos makes it declarative for us to build we just dont need the backup features.
- For a home folder backups do make sense, but likely better to use a tool like rsync or whatever.
  Only benefit of lvm in this case is resizeable disk but only use case i see is when home and swap are on same disk, and we want to change swaps size.



Why gdisk:
- gdisk is newer than fdisk and works on partitions > 2TB.
- UEFI is not a requirement to use gdisk.




# Resources & Thanks

https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134
https://gist.github.com/ladinu/bfebdd90a5afd45dec811296016b2a3f

https://debian-administration.org/article/410/A_simple_introduction_to_working_with_LVM
http://tldp.org/HOWTO/LVM-HOWTO/anatomy.html
http://tldp.org/HOWTO/LVM-HOWTO/commontask.html


People who spend their time telling others what can't be done only annoy those of us out there doing it.

