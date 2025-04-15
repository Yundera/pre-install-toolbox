#!/bin/sh

if [ $# -eq 0 ]; then
  # If no parameters, use the local file at /script.sh
  if [ -f /script.sh ]; then
    sh /script.sh
  else
    echo "No parameters provided and /script.sh does not exist."
    echo "Usage: docker run pre-install-toolbox [https://example.com/script.sh]"
    exit 1
  fi
else
  # Use the provided URL
  URL=$1
  shift

  if command -v curl > /dev/null 2>&1; then
    curl -s "$URL" | sh "$@"
  else
    wget -O - "$URL" | sh "$@"
  fi
fi