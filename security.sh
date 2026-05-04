cat /etc/passwd | head -10 ## Shows the first 10 lines of the /etc/passwd file directly.
id # Shows the identity information of the current user, such as user ID, group ID, and group memberships.
groups # Shows the groups that the current logged-in user belongs to.
groups $USER # Shows the groups that the user stored in the $USER variable belongs to. 
id -u #User ID
id -g #Group ID principal
id -G #todos los Groups ID
cat /etc/group # Displays the system group file, showing all groups and the users assigned to each group.
cat /etc/gshadow # Displays the secure group file, which contains protected group password and administrator information; it usually requires root permissions.
mkdir ~/proyecto_unix/ # Creates a new directory called proyecto_unix inside the current user's home directory.
ls -la ~/proyecto_unix/ # Lists all files inside proyecto_unix, including hidden files, with detailed information such as permissions, owner, group, size, and date.