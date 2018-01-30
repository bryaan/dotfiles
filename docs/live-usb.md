

```

# Wipe partitions from usb to prevent trouble (may not be required)

lsblk
gdisk /dev/sdX
o (create a new empty GUID partition table (GPT))
w (write partition table and exit)

# Write to USB (Linux)

sudo dd bs=4M if='~/Desktop/CentOS-7-x86_64-Minimal-1708.iso' of=/dev/sdb conv=fsync

# Write to USB (Mac)

dd bs=4m if='~/Desktop/CentOS-7-x86_64-Minimal-1708.iso' of=/dev/sdb

```



!!!!!!!!!!
Because the iso from web is meant for DVDs we can't put it on another partition bc the pc doesnt know how to handle iso9660 when seen as a partition. (only as a disk / full drive)
!!!!!!!!!!

1. fat32 small boot space partition. copy from nix script
2. partition for linux
3..N data and other os partitions.

What should happen:
First linux partition's GRUB is loaded.  GRUB should see the rest of the linux installs on disk.




Instead:

Have to install linux to usb in same way we do to ssd.