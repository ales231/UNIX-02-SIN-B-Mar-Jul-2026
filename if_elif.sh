#!/bin/bash
USER_INPUT="${1}"                                      # Assign first argument to variable
if [[ -z "${USER_INPUT}" ]]; then                     # Check if variable is empty
    echo "you must provide an argument!"              # Print error message
    exit 1                                            # Exit with error code 1
fi
if [[ -f "${USER_INPUT}" ]]; then                     # Check if path is a regular file
    echo "${USER_INPUT} is a file"                    # Print: it's a file
elif [[ -d "${USER_INPUT}" ]]; then                   # Check if path is a directory
    echo "${USER_INPUT} is a directory"               # Print: it's a directory
else
    echo "${USER_INPUT} is not a file or a directory" # Print: neither file nor directory
fi
