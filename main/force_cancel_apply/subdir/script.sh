#!/bin/bash
i=1; trap "echo BOOM" TERM SIGTERM; while true; do  echo "Waiting for signal: ${i}s"; i=$((i + 1)); sleep 1; done