#!/bin/bash

# Store the name of the file we are looking for
SIGNAL_TO_STOP_FILE="stoploop"

# Start a while loop that runs as long as the file does NOT exist
# -f checks if the file exists, ! negates the condition
while [[ ! -f "${SIGNAL_TO_STOP_FILE}" ]]; do

    # Print a message indicating the file has not been found yet
    echo "The file ${SIGNAL_TO_STOP_FILE} does not yet exist..."

    # Print a message indicating we will check again
    echo "Checking again in 2 seconds..."

    # Wait 2 seconds before checking again
    sleep 2

# End of the while loop
done

# Once the file is found the loop exits and this message is printed
echo "File was found! exiting..."