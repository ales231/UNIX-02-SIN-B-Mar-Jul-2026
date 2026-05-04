cat /etc/passwd | head -10 ## Shows the first 10 lines of the /etc/passwd file directly.
id # Shows the identity information of the current user, such as user ID, group ID, and group memberships.
groups # Shows the groups that the current logged-in user belongs to.
groups $USER # Shows the groups that the user stored in the $USER variable belongs to. 