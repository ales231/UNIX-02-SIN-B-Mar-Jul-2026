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