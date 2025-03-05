#!/bin/bash

export PATH="$HOME:$PATH"

# Get the yq version
YQ_VERSION=$(yq --version 2>/dev/null)

# Check if yq is installed
if [[ -z "$YQ_VERSION" ]]; then
    echo "{\"error\": \"yq not found\"}"
    exit 1
fi

# Output valid JSON
echo "{\"yq_version\": \"$YQ_VERSION\"}"