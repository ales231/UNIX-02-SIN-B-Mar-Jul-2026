umask #means: “remove some permissions automatically when creating new files or directories.”
touch archivo1 #Creates an empty file called archivo1. If the file already exists, it only updates its timestamp.
mkdir directorio1 #Creates a new directory called directorio1.
ls -l #Shows the files and directories in long format, including permissions, owner, group, size, and date.
umask 027 #Changes the default permission mask for new files and directories.
touch archivo2 #Creates an empty file called archivo2, but now using the new umask 027, so it will probably have permissions like rw-r-----.
mkdir directorio2 #Creates a new directory called directorio2, also using umask 027, so it will probably have permissions like rwxr-x---.
ls -l #Shows the files and directories in long format, including permissions, owner, group, size, and date.
sudo apt-get update #Updates the local package list from the repositories. It does not install anything; it only refreshes the information about available packages and versions.
sudo apt-get install acl #This package provides commands like setfacl and getfacl, which are used to manage Access Control Lists in Linux.
sudo chown R$(whoami) . #Changes the owner of the current directory and everything inside it to your current user.
sudo setfacl -bnR #Removes extra ACL permissions from the current directory and everything inside it.
umask 077 #Sets a very restrictive default permission mask for new files and directories.
touch secreto.txt #Creates an empty file called secreto.txt.
mkdir privado #Creates a new directory called privado.
ls -l #Shows the files and directories in long format, including permissions, owner, group, size, and date.
sudo useradd -m -s /usr/bin/zsh luna #Creates a new user called luna.
sudo chown luna mi_archivo #Changes the owner of mi_archivo to the user luna.