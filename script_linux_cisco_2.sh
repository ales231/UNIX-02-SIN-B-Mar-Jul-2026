
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