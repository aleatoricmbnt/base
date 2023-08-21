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

# Trap the SIGTERM signal and call the cleanup function
trap SIGTERM

# Keep the script running
while true; do
    sleep 1
done