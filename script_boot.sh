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
#stat . is used to display detailed information about the current directory, such as its size, permissions, owner, inode, and access or modification dates.
stat .
#Creates the full directory path at once, including any parent folders that do not already exist.
mkdir -p /tmp/prueba/sub1/tmp/prueba/sub2
#Shows detailed information about the /tmp/prueba directory, such as permissions, owner, size, inode, and timestamps
stat /tmp/prueba
#manual
man mkdir
#Shows the full path of the current working directory.
pwd
#Displays the name of the current logged-in user.
whoami
#Lists the files and folders in the current directory.
ls 
#Lists files and folders in long format, showing details like permissions, owner, size, and date.
ls -l
#Lists all files and folders in long format, including hidden files.
ls -la
#Lists files and folders in long format, but shows sizes in a human-readable way like KB or MB.
ls -lh
#Lists the contents of the root directory.
ls /
#Shows the first 20 entries inside the /etc directory.
ls /etc |head -20
#Shows the first 20 entries inside the /dev directory.
ls /dev |head -20
#Lists all files and folders in the current directory in long format, including hidden files.
ls -la
#
git clone --depth 1 https://github.com/torvalds/linux 
#
cd linux
#
make menuconfig
#
make -j2