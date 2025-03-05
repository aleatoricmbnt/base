#!/bin/bash

set -e  # Exit on error

# Ensure required environment variables are set
if [[ -z "$SCALR_HOSTNAME" || -z "$SCALR_WORKSPACE_ID" || -z "$SCALR_TOKEN" ]]; then
    echo "Error: SCALR_HOSTNAME, SCALR_WORKSPACE_ID, and SCALR_TOKEN must be set."
    exit 1
fi

# Check if jq is installed, install if missing
if ! command -v jq &> /dev/null; then
    echo "jq not found. Installing..."
    
    if [[ "$(uname -s)" == "Linux" ]]; then
        sudo apt-get update && sudo apt-get install -y jq
    elif [[ "$(uname -s)" == "Darwin" ]]; then
        brew install jq
    else
        echo "Unsupported OS. Please install jq manually."
        exit 1
    fi
fi

# Define API URL
API_URL="https://${SCALR_HOSTNAME}/api/iacp/v3/workspaces/${SCALR_WORKSPACE_ID}"

# Perform GET request
echo "Fetching workspace details from $API_URL..."
RESPONSE=$(curl -s -H "Authorization: Bearer $SCALR_TOKEN" "$API_URL")

# Extract "updated-by-email" field
UPDATED_BY_EMAIL=$(echo "$RESPONSE" | jq -r '.data.attributes."updated-by-email"')

# Check if field exists
if [[ "$UPDATED_BY_EMAIL" == "null" || -z "$CREATED_BY_EMAIL" ]]; then
    echo "Error: 'updated-by-email' field not found in response."
    exit 1
fi

# Output result
echo "Workspace updated by: $UPDATED_BY_EMAIL"
