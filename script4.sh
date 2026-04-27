umask #means: “remove some permissions automatically when creating new files or directories.”
touch archivo1 #Creates an empty file called archivo1. If the file already exists, it only updates its timestamp.
mkdir directorio1 #Creates a new directory called directorio1.
ls -l #Shows the files and directories in long format, including permissions, owner, group, size, and date.
umask 027 #Changes the default permission mask for new files and directories.
touch archivo2 #Creates an empty file called archivo2, but now using the new umask 027, so it will probably have permissions like rw-r-----.
mkdir directorio2 #Creates a new directory called directorio2, also using umask 027, so it will probably have permissions like rwxr-x---.
ls -l #Shows the files and directories in long format, including permissions, owner, group, size, and date.
