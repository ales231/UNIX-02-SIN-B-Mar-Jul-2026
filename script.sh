ls -a
ls --all #is the same
ls -a / #is used to list all files and directories in the root directory of the system (/), including hidden ones.
ls -l -a -h
ls -l -ah
ls -lah #All three do the same thing, but it's a way to shorten the command and list all files.
mkdir -- -rf #Creates a directory literally named -rf by stopping option parsing with --.
rm -- -rf #Removes a file literally named -rf by treating it as a filename, not as options.
rmdir -- -rf #Removes an empty directory literally named -rf by treating it as a name, not as flags.
ls --help  #Give me an explanation of the ls 
man ls #This a manual for ls
--depth # Create a shallow clone with a history truncated to the specified number of commits. Implies --single-branch unless
           #--no-single-branch is given to fetch the histories near the tips of all branches. If you want to clone submodules shallowly,
           #also pass --shallow-submodules.

chmod u+rw,go-rwx script.sh #Gives the owner read and write permissions, and removes all permissions from group and others on script.sh.
chmod +x script.sh #Adds execute permission to script.sh for everyone who already has access to the file.
 chmod u+x script.sh #Adds execute permission only for the file owner on script.sh.
 chmod o-r script.sh #Removes read permission from others on script.sh.
 sudo echo "hola" > /etc/archivo_protegido #It's not worth it because sweat doesn't lift the "etc".
 echo "hola" | sudo tee /etc/archivo_protegido 
 echo "hola" | sudo tee /etc/archivo_protegido > /dev/null #echo "hola" | sudo tee /etc/archivo_protegido writes "hola" into the protected file as administrator and also prints it to the terminal, while echo "hola" | sudo tee /etc/archivo_protegido > /dev/null writes it to the file but hides the terminal output.
 sudo sh -c 'echo "chao" >> /etc/archivo_protegido' #runs a root shell that appends the text "chao" to the protected file /etc/archivo_protegido.
 sudo su - #sudo su - switches to a full root login shell, giving you administrator access with root’s environment and home directory.
 
