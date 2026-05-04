
# ls
# Shows the files and folders in the current directory.
ls


# ls -l
# Shows files and folders in detailed format: permissions, owner, size, and date.
ls -l


# ls -r
# Shows files in reverse order.
ls -r


# ls -lr
# Shows files in detailed format and reverse order.
ls -lr


# pwd
# Shows the full path of the directory where you are currently located.
pwd


# cd
# Changes to the current user's home directory.
cd


# cd /
# Changes to the root directory of the system.
cd /


# cd /sysadmin
# Changes to the sysadmin directory located directly inside the root directory.
# Note: the /sysadmin folder must exist for this command to work.
cd /sysadmin


# cd ..
# Moves one level up in the folder structure.
cd ..


# cd ~
# Changes to the current user's home directory, for example /home/user.
cd ~


# ls -l /var/log/
# Shows detailed information about the files inside /var/log/, where system logs are stored.
ls -l /var/log/


# su -
# Switches to the root user and loads root's full environment.
su -


# su -l
# Does the same as su -, logging in as root with root's full environment.
su -l


# su --login
# Also logs in as root and loads root's full environment.
su --login


# exit
# Exits the current session, for example root, and returns to the previous user.
exit


# ls -l file_name
# Shows detailed information about a specific file.
ls -l file_name


# chmod u+x file_name
# Gives execution permission to the owner of the file.
chmod u+x file_name


# ./file_name
# Executes a file located in the current directory.
./file_name


# sudo chown root file_name
# Changes the owner of the file to root using administrator permissions.
sudo chown root file_name


# cat file_name
# Displays the entire content of a file in the terminal.
cat file_name


# head file_name
# Shows the first 10 lines of a file.
head file_name


# tail file_name
# Shows the last 10 lines of a file.
tail file_name


# head -n 5 file_name
# Shows the first 5 lines of a file.
head -n 5 file_name


# tail -n 5 file_name
# Shows the last 5 lines of a file.
tail -n 5 file_name


# cp file destination
# Copies a file to another location.
cp file destination


# cp /folder/file .
# Copies a file from a folder to the current directory.
# The final dot means "here".
cp /folder/file .


# cp -r folder destination
# Copies a complete folder with all its contents.
cp -r folder destination

