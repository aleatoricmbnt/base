#!/bin/bash

# Function to report the waiting time
report_waiting() {
    local seconds=0
    while true; do
        echo "Waiting for signal: ${seconds}s"
        sleep 1
        ((seconds++))
    done
}

# Start reporting in the background
report_waiting &

# Function to clean up before exiting
cleanup() {
    echo "Received SIGTERM signal."
    # You can perform any cleanup actions here if needed
    # The script will keep running after cleanup
}

# Trap the SIGTERM signal and call the cleanup function
trap 'cleanup' SIGTERM

# Keep the script running
while true; do
    sleep 1
done