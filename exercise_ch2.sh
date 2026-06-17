#!/bin/bash
# Exercise Chapter 2 — BHB
# Usage: ./exercise_ch2.sh <name> <domain>

# Store the two positional arguments in named variables
# $1 and $2 are the first and second arguments passed to the script
# Using named variables makes the code more readable than using $1/$2 everywhere
NAME=$1
DOMAIN=$2

# Name of the CSV file where results will be saved
OUTPUT_FILE="results.csv"
# Check that both arguments were provided
# If either is missing, print an error message and exit with code 1
# Exit code 1 means "general error" — the script cannot continue (exit codes — BHB Ch.1)
if [[ -z "$NAME" || -z "$DOMAIN" ]]; then
    echo "[ERROR] Two arguments are required: <name> <domain>"
    echo "Usage: $0 <name> <domain>"
    exit 1
fi
# Function to ping the target domain
# ping is blocked in this container, so we use curl as a fallback
# curl flags:
# -s = silent mode, no progress output
# --max-time 3 = wait max 3 seconds for a response
# -o /dev/null = discard the response body, we only care about exit code
# We still call it "ping" conceptually — testing if the host is reachable
# (redirection — BHB Ch.1, functions — BHB Ch.2)
ping_domain() {
    if curl -s --max-time 3 "$DOMAIN" > /dev/null 2>&1; then
        PING_RESULT="success"
        echo "[+] Ping to $DOMAIN: SUCCESS"
    else
        PING_RESULT="failure"
        echo "[-] Ping to $DOMAIN: FAILURE"
    fi
}

# Call the function
ping_domain
# Function to write results to a CSV file
# CSV (Comma-Separated Values) is a plain text format where each field
# is separated by a comma — easy to open in Excel or parse with scripts
write_csv() {
    # If the file doesn't exist yet, write the header row first
    # -f checks if the file exists (file test operators — BHB Ch.2)
    if [[ ! -f "$OUTPUT_FILE" ]]; then
        echo "name,domain,result,datetime" > "$OUTPUT_FILE"
    fi

    # Get the current date and time in a readable format
    # date command with format string: YYYY-MM-DD HH:MM:SS
    DATETIME=$(date "+%Y-%m-%d %H:%M:%S")

    # Append one line to the CSV with all four fields
    # >> appends to the file without overwriting existing content
    # (redirection — BHB Ch.1)
    echo "$NAME,$DOMAIN,$PING_RESULT,$DATETIME" >> "$OUTPUT_FILE"
    echo "[*] Results saved to $OUTPUT_FILE"
}

# Call the function
write_csv
# Loop to keep the script running so we can practice job control
# sleep 1 pauses 1 second each iteration (job control — BHB Ch.2)
echo "[*] Script running... press Ctrl+Z to suspend"
for i in {1..60}; do
    echo "[*] Running... $i/60"
    sleep 1
done