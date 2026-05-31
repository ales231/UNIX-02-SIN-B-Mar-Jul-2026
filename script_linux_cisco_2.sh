
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
 
# =============================================================================
# Network Configuration - ifconfig & ping Reference
# =============================================================================
# =============================================================================
# ifconfig – Display or configure network interfaces
# =============================================================================
# DESCRIPTION:
#   ifconfig (interface configuration) shows and temporarily modifies
#   network settings. For wireless interfaces, use iwconfig instead.
#   Syntax: ifconfig [OPTIONS]
# KEY OUTPUT FIELDS:
#   eth0          Primary network interface
#   inet addr     IPv4 address of the interface
#   UP            Interface is active
#   lo            Loopback device (used for internal system communication, 127.0.0.1)
# =============================================================================
# -----------------------------------------------------------------------------
# EXAMPLE – Show all network interfaces
# -----------------------------------------------------------------------------
ifconfig
# =============================================================================
# ping – Test connectivity between two hosts
# =============================================================================
# DESCRIPTION:
#   ping sends packets to another machine and waits for a reply.
#   It uses IP addresses (or hostnames/domains) to identify the target.
#   By default it runs until stopped with Ctrl+C.
#   Syntax: ping [OPTIONS] TARGET
# =============================================================================
# -----------------------------------------------------------------------------
# EXAMPLE 1 – Ping a host with a limited number of packets
# -----------------------------------------------------------------------------
ping -c 4 192.168.1.2              # Send exactly 4 packets to the target IP
# -----------------------------------------------------------------------------
# EXAMPLE 2 – Ping using a hostname or domain (also validates DNS resolution)
# -----------------------------------------------------------------------------
ping -c 4 yahoo.com
# -----------------------------------------------------------------------------
# POSSIBLE OUTCOMES:
#   Success → replies received, 0% packet loss
#   Failure → "Destination Host Unreachable" (host down or blocked)
#
# NOTE: Some hosts/networks block ping requests by design (firewall/security).
#       A failed ping does not always mean the machine is offline.
# -----------------------------------------------------------------------------
# COMMON OPTIONS:
#   -c N   Limit to N packets (instead of running indefinitely)
 
# =============================================================================
# ps Command - Process Viewing Reference
# =============================================================================
# DESCRIPTION:
#   ps lists running processes. Process privileges depend on the user who
#   launched them. Regular users can only control their own processes;
#   root can control any process on the system.
#   Syntax: ps [OPTIONS]
#
# OUTPUT COLUMNS:
#   PID    Process ID – unique identifier for each process
#   TTY    Terminal the process is running on
#   TIME   Total CPU time consumed by the process
#   CMD    Command that started the process
#
# EXTRA COLUMNS (with -f):
#   UID    User who owns the process
#   PPID   Parent Process ID (the process that launched this one)
#   STIME  Start time of the process
# =============================================================================
# -----------------------------------------------------------------------------
# EXAMPLE 1 – Show processes running in the current terminal only
# -----------------------------------------------------------------------------
ps
# -----------------------------------------------------------------------------
# EXAMPLE 2 – Show ALL processes running on the system
# -----------------------------------------------------------------------------
ps -e
# -----------------------------------------------------------------------------
# EXAMPLE 3 – Show all processes with full/detailed output
# -----------------------------------------------------------------------------
ps -ef                               # Includes UID, PPID, STIME and full CMD with arguments
# COMMON OPTIONS:
#   -e   Show every process on the system
#   -f   Full format listing (more detail per process)
 
# =============================================================================
# Package Management - apt-get Reference (Debian/Ubuntu)
# =============================================================================
# DESCRIPTION:
#   Package management allows software to be installed, updated, searched,
#   and removed. On Debian-based systems (Ubuntu), the main tools are:
#     dpkg     – low-level package tool
#     apt-get  – user-friendly front-end for dpkg (recommended)
#
# NOTES:
#   - Most commands require admin privileges (prefix with sudo)
#   - Packages are downloaded from online repositories (65,000+ available)
# =============================================================================
# -----------------------------------------------------------------------------
# SEARCH – Find packages by keyword
# -----------------------------------------------------------------------------
apt-cache search cow                 # Search for packages matching "cow"
# Tip: use multiple keywords for better results (e.g. "web server")
# -----------------------------------------------------------------------------
# INSTALL – Update package list first, then install
# -----------------------------------------------------------------------------
sudo apt-get update                  # Refresh the list of available packages
sudo apt-get install cowsay          # Download and install the package
# -----------------------------------------------------------------------------
# UPDATE ALL – Upgrade every installed package and its dependencies
# -----------------------------------------------------------------------------
sudo apt-get update                  # Step 1: refresh package cache
sudo apt-get upgrade                 # Step 2: upgrade all installed packages
# NOTE: apt-get install also upgrades a package if a newer version exists
# -----------------------------------------------------------------------------
# REMOVE – Uninstall a package
# -----------------------------------------------------------------------------
sudo apt-get remove cowsay           # Remove package but keep config files
sudo apt-get purge cowsay            # Remove package AND all config files
# SUMMARY:
#   apt-cache search [keyword]       Search available packages
#   apt-get update                   Refresh package list
#   apt-get install [package]        Install or upgrade a package
#   apt-get upgrade                  Upgrade all installed packages
#   apt-get remove [package]         Uninstall (keeps config files)
#   apt-get purge [package]          Uninstall + delete config files
 
# =============================================================================
# passwd Command - Password Management Reference
# =============================================================================
# DESCRIPTION:
#   passwd updates a user's password.
#   - Regular users can only change their own password
#   - root can change any user's password
#   Syntax: passwd [OPTIONS] [USER]
# =============================================================================
# -----------------------------------------------------------------------------
# EXAMPLE 1 – Change your own password (prompts for current + new password)
# -----------------------------------------------------------------------------
passwd
# -----------------------------------------------------------------------------
# EXAMPLE 2 – View password status information for a user
# -----------------------------------------------------------------------------
passwd -S sysadmin
# OUTPUT FIELDS (passwd -S):
#   Field           Example     Meaning
#   Username        sysadmin    The user's login name
#   Password status P           P=usable, L=locked, NP=no password
#   Last changed    12/20/2017  Date the password was last updated
#   Minimum         0           Min days before user can change the password again
#   Maximum         99999       Max days before the password expires
#   Warning         7           Days before expiry that the user gets a warning
#   Inactivity      -1          Days after expiry before the account is disabled (-1 = never)
# -----------------------------------------------------------------------------
# EXAMPLE 3 – root changes another user's password (no current password needed)
# -----------------------------------------------------------------------------
# passwd sysadmin
# NOTE: Passwords are never displayed while typing (security measure).
#       Switch to root with: su root | exit to return to regular user.

# =============================================================================
# I/O Redirection - Reference & Examples
# =============================================================================
# DESCRIPTION:
#   I/O redirection sends command output to files instead of the terminal.
#   Syntax: [COMMAND] > [FILE]   (overwrite)
#           [COMMAND] >> [FILE]  (append)
#
# FILE DESCRIPTORS:
#   STDIN  (0)  Standard Input  – what the user types / feeds to a command
#   STDOUT (1)  Standard Output – normal command output displayed on screen
#   STDERR (2)  Standard Error  – error messages from failed commands
#
# NOTE: Redirecting to a file requires write permission on that file.
# =============================================================================
# -----------------------------------------------------------------------------
# EXAMPLE 1 – Redirect STDOUT to a new file (creates or overwrites)
# -----------------------------------------------------------------------------
cat food.txt > newfile1.txt          # Output of cat is saved to newfile1.txt instead of screen
# -----------------------------------------------------------------------------
# EXAMPLE 2 – Overwrite a file using echo
# -----------------------------------------------------------------------------
echo "I like food." > newfile1.txt   # WARNING: replaces all existing content
# -----------------------------------------------------------------------------
# EXAMPLE 3 – Append content to an existing file (does NOT overwrite)
# -----------------------------------------------------------------------------
echo "This food is good." >> newfile1.txt   # Adds a new line at the end
# -----------------------------------------------------------------------------
# SUMMARY:
#   >    Redirect STDOUT – overwrites the file if it already exists
#   >>   Redirect STDOUT – appends to the file, preserving existing content
# -----------------------------------------------------------------------------

# =============================================================================
# vi Text Editor - Reference & Examples
# =============================================================================
# DESCRIPTION:
#   vi (vim) is the universal Linux/UNIX text editor, available on every
#   Linux distribution. Most systems use vim (vi improved), a superset of vi.
#   Open or create a file: vi filename.txt
# THREE MODES:
#   Command Mode  – default on launch; navigate and perform actions (Esc to return)
#   Insert Mode   – type and edit text
#   Ex Mode       – file operations and settings (enter with :)
# =============================================================================
# =============================================================================
# COMMAND MODE – MOVEMENT
# =============================================================================
# [count] motion  →  optional number prefix repeats the motion (e.g. 5h, 3w)
#
#   h   ←  one character left         l   →  one character right
#   j   ↓  next line                  k   ↑  previous line
#   w      one word forward           b      one word backward
#   ^      beginning of line          $      end of line
#   gg     first line                 G      last line
#   5G     go to line 5               Ctrl+G show current line number
# =========================================================================
# COMMAND MODE – ACTIONS  (cut / copy / paste equivalent)
# =============================================================================
# Standard → vi equivalent:  cut=d (delete)  copy=y (yank)  paste=p/P (put)
# Format: action [count] motion  OR  [count] action motion
#
# DELETE (cut to buffer):
#   dd     delete current line        3dd    delete next 3 lines
#   dw     delete current word        d3w    delete next 3 words
#
# CHANGE (delete + enter Insert Mode):
#   cc     change current line        cw     change current word
#   c3w    change next 3 words
#
# YANK (copy to buffer, no deletion):
#   yy     yank current line          3yy    yank next 3 lines
#   yw     yank current word          y$     yank to end of line
#
# PUT (paste from buffer):
#   p      paste AFTER cursor         P      paste BEFORE cursor
# =============================================================================
# COMMAND MODE – SEARCH
# =============================================================================
#   /pattern   search forward   (n = next match, N = previous match)
#   ?pattern   search backward
# =============================================================================
# INSERT MODE – Enter text  (press Esc to return to Command Mode)
# =============================================================================
#   a   insert after cursor           A   insert at end of line
#   i   insert before cursor          I   insert at beginning of line
#   o   new line below cursor         O   new line above cursor
# =============================================================================
# EX MODE – File operations  (enter with : from Command Mode)
# =============================================================================
#   :w              Save (write) the file
#   :w filename     Save a copy under a new name
#   :w!             Force save
#   :q              Quit (only if no unsaved changes)
#   :q!             Quit WITHOUT saving (discard changes)
#   :wq  or  ZZ     Save and quit
#   :e filename     Open another file
#   :1  or  :N      Jump to line N
#
# TIP: ! forces the operation — e.g. :q fails with unsaved changes, :q! does not.
 