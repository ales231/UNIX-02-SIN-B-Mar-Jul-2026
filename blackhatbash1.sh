#!/bin/bash
set -x

shebang 
#!/bin/bash -x   IT shows every single comain in real time
#bash -r blackhatbash1.sh  #Limit dangerous commands within the script
bash version
env
echo ${SHELL}
echo ${RANDOM}
echo ${UID}
echo ${OSTYPE}
ps -e -f
ps -ef
df --human-readable
#bash -n blackhatbash1.sh
set +x