#!/bin/bash
awk '{print $1,$2,$3}' log.txt
awk '{print $1,$NF}' log.txt
awk -F',' '{print $1}' example_csv.txt
awk 'NR < 10' log.txt
grep "42.236.10.117" log.txt | awk '{print $7}'
sed 's/Mozilla/Godzilla/g' log.txt
grep "Mozilla" log.txt #Using grep with quotation marks, filter for the word "mozilla" I also verify that it was replaced

