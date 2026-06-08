#!/bin/bash
echo "What is your first name?"
read -r firstname
echo "What is your last name?"
read -r lastname
echo "Your first name is ${firstname} and your last name is ${lastname}"
ls -l > /dev/null
echo "The status code of the ls command was: $?"
lzl 2> /dev/null
echo "The status code of the non-existing lzl command was: $?"
echo "Exiting with status code: 223"
exit 223