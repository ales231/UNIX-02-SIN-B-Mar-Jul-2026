
# =============================================================================
# dd Command - Reference & Examples
# =============================================================================
# DESCRIPTION:
#   dd copies files or entire partitions at the bit level.
#   Syntax: dd [OPTIONS] OPERAND
#
# COMMON USE CASES:
#   - Clone or wipe entire disks/partitions
#   - Copy raw data to USB drives or CD-ROMs
#   - Backup and restore the MBR (Master Boot Record)
#   - Create a swap file filled with binary zeros
# =============================================================================
# KEY ARGUMENTS:
#   if=    Input File  – source to read from
#   of=    Output File – destination to write to
#   bs=    Block Size  – size per block (suffixes: K, M, G, T)
#   count= Count       – number of blocks to read from input
# -----------------------------------------------------------------------------
# EXAMPLE 1 – Create a 50 MB swap file filled with zeros
# -----------------------------------------------------------------------------
# Reads 50 blocks of 1 MB each from /dev/zero and writes them to /tmp/swapex
dd if=/dev/zero of=/tmp/swapex bs=1M count=50
# -----------------------------------------------------------------------------
# EXAMPLE 2 – Clone an entire hard disk to another
# -----------------------------------------------------------------------------
# No bs or count needed when copying whole devices
dd if=/dev/sda of=/dev/sdb
# -----------------------------------------------------------------------------
# EXAMPLE 3 – Backup the MBR (first 512 bytes of a disk)
# -----------------------------------------------------------------------------
dd if=/dev/sda of=/tmp/mbr_backup.img bs=512 count=1
# -----------------------------------------------------------------------------
# EXAMPLE 4 – Restore the MBR from a backup
# -----------------------------------------------------------------------------
dd if=/tmp/mbr_backup.img of=/dev/sda bs=512 count=1
# -----------------------------------------------------------------------------
# EXAMPLE 5 – Wipe a disk by overwriting it with zeros
# -----------------------------------------------------------------------------
dd if=/dev/zero of=/dev/sdb bs=1M

# =============================================================================
# mv Command - Reference & Examples
# =============================================================================
# DESCRIPTION:
#   mv moves a file from one location in the filesystem to another.
#   Syntax: mv SOURCE DESTINATION
#
# NOTES:
#   - Requires at least two arguments: source and destination
#   - Moving within the same directory effectively renames the file
#   - Requires write + execute permissions on both source and destination dirs
# =============================================================================
# -----------------------------------------------------------------------------
# EXAMPLE 1 – Move a single file to a directory
# -----------------------------------------------------------------------------
# people.csv keeps its original name inside Work/
mv people.csv Work
# -----------------------------------------------------------------------------
# EXAMPLE 2 – Move multiple files to a directory
# -----------------------------------------------------------------------------
# The destination must always be the last argument
mv numbers.txt letters.txt alpha.txt School
# -----------------------------------------------------------------------------
# EXAMPLE 3 – Rename a file (move within the same directory)
# -----------------------------------------------------------------------------
mv animals.txt zoo.txt
 
 # =============================================================================
# rm Command - Reference & Examples
# =============================================================================
# DESCRIPTION:
#   rm (remove) deletes files and directories permanently.
#   Unlike desktop OS trash bins, deleted files are NOT recoverable.
#   Syntax: rm [OPTIONS] FILE
#
# NOTES:
#   - Requires write + execute permissions on the parent directory
#   - Regular users can typically only delete files in their home dir
#   - Directories are ignored unless a recursive option is specified
# ============================================================================= 
# -----------------------------------------------------------------------------
# EXAMPLE 1 – Delete a single file
# -----------------------------------------------------------------------------
rm linux.txt 
# -----------------------------------------------------------------------------
# EXAMPLE 2 – Attempt to delete a directory (fails without options)
# -----------------------------------------------------------------------------
# rm Work         # ERROR: rm: cannot remove 'Work': Is a directory 
# -----------------------------------------------------------------------------
# EXAMPLE 3 – Delete a directory and all its contents recursively
# -----------------------------------------------------------------------------
# WARNING: permanently removes the directory and ALL files/subdirectories inside
rm -r Work
# -----------------------------------------------------------------------------
# COMMON OPTIONS:
#   -r / -R   Recursive – required to remove directories
#   -f        Force     – suppress confirmation prompts and ignore missing files
#   -i        Interactive – prompt before every deletion (safer)
# -----------------------------------------------------------------------------
 