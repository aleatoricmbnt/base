#!/bin/bash
# data.external: stdout must be only a single JSON object. Progress goes to stderr.
on_term() {
  echo '{"result":"BOOM","reason":"signal"}'
  exit 0
}
trap on_term TERM SIGTERM
i=1
while true; do
  echo "Waiting for signal: ${i}s" >&2
  i=$((i + 1))
  sleep 1
done
