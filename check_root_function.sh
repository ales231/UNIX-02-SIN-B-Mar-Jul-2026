#!/bin/bash
#!/bin/bash

# Define a function called check_if_root
check_if_root(){

    # Check if the effective user ID is equal to 0 (root)
    if [[ "${EUID}" -eq "0" ]]; then

    # Return 0 means success - user IS root
        return 0

    else

# Return 1 means failure - user is NOT root
return 1

fi
}

# Call the function and store the returned value in is_root
is_root=$(check_if_root)

# Compare is_root value against 0
if [[ "${is_root}" -eq "0" ]]; then

    # If equal to 0, user is root
    echo "user is root!"

else

    # If not equal to 0, user is not root
    echo "user is not root!"

fi

adduser saka #add user
su saka #change