#!/bin/bash
# All this script does is create a directory, create a file
# within the directory, and then list the contents of the di rectory. 
set -x
mkdir mydirectory 
touch mydirectory/myfile 
ls -l mydirectory
set +x

#First resul
$ bash -x blackhatbash2.sh
bash -x blackhatbash2.sh
+ set -x
+ mkdir mydirectory
mkdir: cannot create directory ‘mydirectory’: El fichero ya existe
+ touch mydirectory/myfile
+ ls -l mydirectory
total 0
-rw-rw-rw- 1 root root 0 jun  1 13:22 myfile
+ set +x
__set_prompt

#second result
$ bash -n blackhatbash2.sh
bash -n blackhatbash2.sh
__set_prompt

#third result
bash blackhatbash2.sh
+ mkdir mydirectory
mkdir: cannot create directory ‘mydirectory’: El fichero ya existe
+ touch mydirectory/myfile
+ ls -l mydirectory
total 0
-rw-rw-rw- 1 root root 0 jun  1 13:26 myfile
+ set +x
blackhatbash2.sh: línea 11: [Alex: orden no encontrada
blackhatbash2.sh: línea 13: +: orden no encontrada
blackhatbash2.sh: línea 14: +: orden no encontrada
blackhatbash2.sh: línea 15: mkdir:: orden no encontrada
blackhatbash2.sh: línea 16: +: orden no encontrada
blackhatbash2.sh: línea 17: +: orden no encontrada
blackhatbash2.sh: línea 18: total: orden no encontrada
blackhatbash2.sh: línea 19: -rw-rw-rw-: orden no encontrada
blackhatbash2.sh: línea 20: +: orden no encontrada
blackhatbash2.sh: línea 21: __set_prompt: orden no encontrada
blackhatbash2.sh: línea 24: [Alex: orden no encontrada
blackhatbash2.sh: línea 26: __set_prompt: orden no encontrada
__set_prompt