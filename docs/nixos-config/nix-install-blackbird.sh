# nix-install-blackbird.sh
#
# This install is meant particularly for the new CLASS
# Which uses UEFI

# After booting from iso
# Download using curl a script that does this:
#
# ifconfig  # to get ip
# TODO somehow insert pw  
# passwd  # to set pass for root
# systemctl start sshd

# TODO  For UEFI systems there are differences.
# https://nixos.org/nixos/manual/index.html#sec-uefi-installation



# This is the one for CLASS that includes the BIOS partition
#
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | gdisk /dev/sda
  o # clear the in memory partition table
  n # new partition
  1 # partition number 1
    # default - start at beginning of disk
  +500M  # 1MB size
  ef00 # EFI Partition
  n # new partition
  2 # partition number 2
    # default - start at beginning of last partition
    # default - expand to end of disk
  8e00 # Linux LVM Partition
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done # TODO might not need this in nixos
EOF


# Can be a space seperated list of partitions and disks
# Do not include EFI partition
export PhysicalVolumes='/dev/sda2'
export vg_name=nix-vg

pvcreate $PhysicalVolumes
vgcreate $vg_name $PhysicalVolumes
lvcreate --size 8G --name swap $vg_name
lvcreate --extents '100%FREE' --name root $vg_name


export boot_device=/dev/sda1  # Or with nvme drive /dev/nvme0n1p1
export root_device=/dev/$vg_name/root
export swap_device=/dev/$vg_name/swap

mkfs.fat -F 32 $boot_device  # EFI partition requires FAT32
mkfs.ext4 -L root $root_device
mkswap -L swap $swap_device

mount $root_device /mnt
mkdir -p /mnt/boot/efi
mount $boot_device /mnt/boot/efi
swapon $swap_device





