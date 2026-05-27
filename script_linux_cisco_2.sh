
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
 
# =============================================================================
# grep Command - Reference & Examples
# =============================================================================
# DESCRIPTION:
#   grep filters text by searching lines in input and returning those
#   that match a given pattern.
#   Syntax: grep [OPTIONS] PATTERN [FILE]
# =============================================================================
# -----------------------------------------------------------------------------
# EXAMPLE 1 – Search for a specific user in the passwd file
# -----------------------------------------------------------------------------
# Returns every line in passwd that contains the word "sysadmin"
grep sysadmin passwd
# -----------------------------------------------------------------------------
# EXAMPLE 2 – Case-insensitive search
# -----------------------------------------------------------------------------
grep -i "root" passwd
# -----------------------------------------------------------------------------
# EXAMPLE 3 – Show line numbers of matches
# -----------------------------------------------------------------------------
grep -n "bash" passwd
# -----------------------------------------------------------------------------
# EXAMPLE 4 – Return lines that do NOT match the pattern
# -----------------------------------------------------------------------------
grep -v "nologin" passwd
# -----------------------------------------------------------------------------
# EXAMPLE 5 – Search recursively inside a directory
# -----------------------------------------------------------------------------
grep -r "sysadmin" ~/Documents
# -----------------------------------------------------------------------------
# COMMON OPTIONS:
#   -i   Case-insensitive matching
#   -n   Show line numbers
#   -v   Invert match (return non-matching lines)
#   -r   Recursive search through directories
#   -c   Count the number of matching lines
#   -l   Print only the names of files with matches
# -----------------------------------------------------------------------------
 
# =============================================================================
# Regular Expressions (Regex) - Reference & Examples
# =============================================================================
# DESCRIPTION:
#   Regular expressions are patterns used to match text.
#   Two forms exist: Basic (BRE) and Extended (ERE).
#   - Basic regex: supported by most commands (e.g. grep)
#   - Extended regex: requires egrep or grep -E
# =============================================================================
# -----------------------------------------------------------------------------
# BASIC REGEX CHARACTERS
# -----------------------------------------------------------------------------
#   .     Any single character
#   [ ]   Any one of the specified characters          e.g. [aeiou]
#   [^]   Any character NOT in the specified set       e.g. [^0-9]
#   *     Zero or more of the previous character
#   ^     Pattern must be at the START of the line     e.g. ^root
#   $     Pattern must be at the END of the line       e.g. bash$
# EXAMPLE – Lines starting with "root"
grep "^root" passwd
# EXAMPLE – Lines ending with "bash"
grep "bash$" passwd
# EXAMPLE – Any 3-character sequence
grep "..." passwd
# EXAMPLE – Lines containing a vowel
grep "[aeiou]" passwd
# EXAMPLE – Lines NOT containing a digit
grep "[^0-9]" passwd
# -----------------------------------------------------------------------------
# EXTENDED REGEX CHARACTERS (use egrep or grep -E)
# -----------------------------------------------------------------------------
#   +     One or more of the previous pattern
#   ?     The previous pattern is optional (zero or one)
#   { }   Exact, minimum, or range of matches          e.g. {2,4}
#   |     Logical OR (alternation)                     e.g. cat|dog
#   ( )   Grouping                                     e.g. (ab)+
# EXAMPLE – Lines containing "root" OR "sysadmin"
grep -E "root|sysadmin" passwd
# EXAMPLE – Lines with one or more digits
grep -E "[0-9]+" passwd
# EXAMPLE – Lines where "sys" appears exactly twice
grep -E "(sys){2}" passwd
# EXAMPLE – Lines with an optional "s" before "bin"
grep -E "s?bin" passwd
 
# =============================================================================
# Basic Regex Patterns with grep - Reference & Examples
# =============================================================================
# DESCRIPTION:
#   Regular expressions are patterns interpreted by commands like grep.
#   All patterns should be wrapped in single quotes to avoid shell misinterpretation.
#   Syntax: grep 'PATTERN' FILE
# =============================================================================
# -----------------------------------------------------------------------------
# ANCHOR CHARACTERS
# -----------------------------------------------------------------------------
# ^  Pattern must appear at the START of the line
# $  Pattern must appear at the END of the line
grep '^root' passwd                  # Lines that start with "root"
grep 'r$' alpha-first.txt           # Lines that end with "r"
# -----------------------------------------------------------------------------
# DOT (.) – Matches any single character except newline
# -----------------------------------------------------------------------------
grep 'r..f' red.txt                  # "r" + any 2 chars + "f"  → reef, roof
grep 'r..d' red.txt                  # "r" + any 2 chars + "d"  → reed, read
grep '....' red.txt                  # Any line with at least 4 characters
# -----------------------------------------------------------------------------
# BRACKETS [ ] – Match a single character from a set or range
# -----------------------------------------------------------------------------
grep '[0-9]' profile.txt             # Lines containing at least one digit
grep '[^0-9]' profile.txt            # Lines containing at least one non-digit
grep '[.]' profile.txt               # Lines containing a literal dot (.)
# NOTE: Special regex chars inside [ ] are treated as literals
# -----------------------------------------------------------------------------
# ASTERISK (*) – Zero or more of the preceding character/pattern
# -----------------------------------------------------------------------------
grep 're*d' red.txt                  # "r" + zero or more "e" + "d"  → rd, red, reed, reeed
grep 'r[oe]*d' red.txt              # "r" + zero or more "o" or "e" + "d"
# TIP: * alone is not useful — pair it with another char to be meaningful
grep 'ee*' red.txt                   # Lines with at least one "e" (one "e" + zero or more "e")
# -----------------------------------------------------------------------------
# STDIN – grep without a filename reads from keyboard input
# -----------------------------------------------------------------------------
# grep 'pattern'
# (type input manually, then press Ctrl+D to exit)

# =============================================================================
# shutdown Command - Reference & Examples
# =============================================================================
# DESCRIPTION:
#   shutdown safely powers off the system. Logged-in users are notified
#   and new logins are blocked during the last 5 minutes before shutdown.
#   Syntax: shutdown [OPTIONS] TIME [MESSAGE]
#
# NOTES:
#   - Requires root/administrative access (su -)
#   - TIME argument is mandatory
# =============================================================================
# TIME FORMATS:
#   now       Immediately
#   hh:mm     Specific time of day (24h format, UTC by default)
#   +minutes  Delay in minutes from now
# -----------------------------------------------------------------------------
# EXAMPLE 1 – Shut down immediately
# -----------------------------------------------------------------------------
shutdown now
# -----------------------------------------------------------------------------
# EXAMPLE 2 – Shut down at a specific time
# -----------------------------------------------------------------------------
shutdown 01:51                       # Powers off at 01:51 UTC
# -----------------------------------------------------------------------------
# EXAMPLE 3 – Shut down in N minutes with a broadcast message
# -----------------------------------------------------------------------------
shutdown +1 "Goodbye World!"         # 1-minute warning + custom message to all users
# -----------------------------------------------------------------------------
# TIP – Check current system time before scheduling a shutdown
# -----------------------------------------------------------------------------
# date
# Output format: weekday month day hour:minute:second UTC year
 