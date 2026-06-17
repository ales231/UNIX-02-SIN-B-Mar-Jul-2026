#!/bin/bash
awk '{print $1,$2,$3}' log.txt
awk '{print $1,$NF}' log.txt
awk -F',' '{print $1}' example_csv.txt
awk 'NR < 10' log.txt
grep "42.236.10.117" log.txt | awk '{print $7}'
sed 's/Mozilla/Godzilla/g' log.txt
grep "Mozilla" log.txt #Using grep with quotation marks, filter for the word "mozilla" I also verify that it was replaced
sed 's/Mozilla/Godzilla/g' log.txt > newlog.txt
sed '1d' newlog1.txt
sed '$d' newlog1.txt
sed '$d' newlog1.txt > newlogL.txt
sed -n '2,15 p' log.txt
sleep 100 &
#[1] 19774   Background job #1 started with PID 19774

ps -ef | grep sleep
root           1       0  0 12:20 ?        00:00:00 /bin/sh -c echo Container started trap "exit 0" 15  exec "$@" while sleep 1 & wait $!; do :; done -
root       19774    1171  0 13:11 pts/0    00:00:00 sleep 100
root       20100       1  0 13:12 ?        00:00:00 sleep 1
root       20123    1171  0 13:12 pts/0    00:00:00 grep sleep   #Shows all processes containing "sleep": the container keepalive (sleep 1), your job (sleep 100), and the grep itself
jobs 
[1]+  Ejecutando                 sleep 100 &  #Job #1 is still running in the background
fg %1
sleep 1000
bg %1
[1]+ sleep 100 &
nohup ./exercise2.sh &