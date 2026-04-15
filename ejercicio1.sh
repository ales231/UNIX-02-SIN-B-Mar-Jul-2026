echo '#!/bin/sh' > hola.sh #Create a file called hello.sh and print the message in quotation marks
echo 'echo "Hola desde mi primer script"' >> hola.sh #appends the line echo "Hola desde mi primer script" to the file hola.sh.
cat hola.sh #shows what the file contains
./hola.sh #permission denied
ls -l hola.sh
chmod +x hola.sh
ls -l hola.sh
./hola.sh #This block first shows the file permissions of hola.sh, then gives it execute permission, shows the updated permissions, and finally runs the script.
ls /etc
touch /etc/prueba.txt #there or updates its timestamp if it already exists.
