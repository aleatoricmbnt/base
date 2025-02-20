#!/bin/bash

set -e

# Generate a random value (1 or 0)
export ALLOW_RUN=$((RANDOM % 2))

echo "Pre-plan hook: Setting ALLOW_RUN=$ALLOW_RUN"

echo "Calling ./export_env_vars_to_file.sh..."
./export_env_vars_to_file.sh