#!/bin/bash
FILENAME="flow_control_with_if.txt"
if [[ -f "${FILENAME}" ]]; then
echo "${FILENAME} already exists."
exit 1
else
touch "${FILENAME}"
fi
VARIABLE_ONE="nostarch"
VARIABLE_TWO="nostarch"
if [[ "${VARIABLE_ONE}" == "${VARIABLE_TWO}" ]]; then
echo "They are equal!"
else
echo "They are not equal!"
fi