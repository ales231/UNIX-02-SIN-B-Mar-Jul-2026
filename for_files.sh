#!/bin/bash
# Start a for loop that iterates over all files starting with "example_file"
# The * wildcard expands to match example_file1, example_file2, example_file3
for file in example_file*; do

    # Check if the current file is exactly "example_file1"
    if [[ "${file}" == "example_file1" ]]; then

        # Print a message indicating we are skipping this file
        echo "Skipping the first file."

        # Skip to the next iteration of the loop
        # example_file1 will remain empty
        continue

    fi

    # For every file that is NOT example_file1
    # Generate a random number and write it into the file
    # $RANDOM generates a number between 0 and 32767
    echo "${RANDOM}" > "${file}"

# End of the for loop
done