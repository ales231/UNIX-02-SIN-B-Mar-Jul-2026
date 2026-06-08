#!/bin/bash

SCRIPT_NAME="${0}"
TARGET="${1}"

echo "Running the script ${SCRIPT_NAME}..."
echo "Pinging the target: ${TARGET}..."
ping "${TARGET}"
$ chmod u+x ping_with_arguments.sh
$./ping_with_arguments.sh nostarch.com
