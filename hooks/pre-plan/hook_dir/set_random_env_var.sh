#!/bin/bash

set -e

chmod -R +x $SCALR_HOOK_DIR

# Generate a random value (1 or 0)
export ALLOW_RUN=$((RANDOM % 2))

echo "Pre-plan hook: Setting ALLOW_RUN=$ALLOW_RUN"

echo "Calling $SCALR_HOOK_DIR/export_env_vars_to_file.sh..."
"$SCALR_HOOK_DIR/export_env_vars_to_files.sh"