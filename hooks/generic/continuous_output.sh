#!/bin/bash
# Create file: continuous-output-hook.sh

echo "Starting 10-minute continuous logging test..."
start_time=$(date +%s)
counter=1

while true; do
    current_time=$(date +%s)
    elapsed=$((current_time - start_time))
    
    if [ $elapsed -ge 600 ]; then  # 10 minutes = 600 seconds
        echo "Test completed after 10 minutes"
        break
    fi
    
    echo "[$counter] Continuous logging test - elapsed: ${elapsed}s - $(date)"
    counter=$((counter + 1))
    sleep 1
done