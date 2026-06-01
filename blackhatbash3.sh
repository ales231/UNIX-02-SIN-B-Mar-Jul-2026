#!/bin/bash
book="black hat bash"
echo "This book's name is ${book}"

echo "This book's nmae is $book" 

root_directory=$(ls -ld /)
echo "${root_directory}"
book="Black hat bash"
unset book
echo "${book}"