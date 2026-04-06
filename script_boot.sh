#Changes your current directory to your home directory by default.
cd
# Takes you to the root directory of the whole Linux file system.
cd /
#Moves you directly to the folder named codespace inside /home.
cd /home/codespace
#Takes you to your home directory, because ~ is a shortcut for home.
cd ~
#Also takes you to your home directory, because $HOME is the environment variable that stores the path of your home folder.
cd $HOME 
#ls -lai shows the inode, permissions, links, owner, group, size, date, and name of . (the current directory) and .. (the parent directory).
total 12
925545 drwxr-xr-x 2 codespace codespace 4096 Apr  6 12:33 .
918515 drwxr-x--- 1 codespace codespace 4096 Apr  6 12:33 ..