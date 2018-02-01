################################################
# lsblk - Block Devices
################################################

# --all Include empty devices.
# --fs  Output info about filesystems.
abbr -a lsblk 'lsblk --all --fs'

################################################
# df, du - File System Structure & Size
################################################

abbr -a df 'df -H -T'
abbr -a du 'du -ch'

# List all files and folders in current directory with size.
abbr -a du.all 'du -shc .??* *'

################################################
# Disk Mounting
################################################

# Make mount command output pretty and human readable format
abbr -a mount 'mount | column -t'

