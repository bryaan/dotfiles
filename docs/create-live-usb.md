


> Because linux live ISOs from websites are usually meant for DVDs (iso9660 format) we can't put it on a particular partition bc the pc doesnt know how to handle iso9660 when seen as a partition. So iso9660s must be written to the full USB. TODO full USB or just first partition?
And then is it possible that its GRUB could load linux on other partitions?


# Wipe partitions from usb to prevent trouble (may not be required)

```
lsblk
gdisk /dev/sdX
o (create a new empty GUID partition table (GPT))
w (write partition table and exit)
```

# Write to USB (Linux)
```
dd bs=4M if='~/Desktop/CentOS-7-x86_64-Minimal-1708.iso' of=/dev/sdb conv=fsync
```

# Write to USB (Mac)
```
dd bs=4m if='~/Desktop/CentOS-7-x86_64-Minimal-1708.iso' of=/dev/sdb
```




TODO this is about partitioning, move there, and particularly for BIOS systems insted of UEFI

1. fat32 small boot space partition. copy from nix script
2. partition for linux
3..N data and other os partitions.


What I think happens: TODO confirm

1. Motherboard BIOS loads itself onto first FAT32 partition.
2. The BIOS code looks for the second partition containing the GRUB bootloader.
3. GRUB sees and boots installs on any other partitions.
