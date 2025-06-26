#!/bin/sh

if [ $# -eq 0 ]; then
  # If no parameters, use the local file at /script.sh
  if [ -f /script.sh ]; then
    sh /script.sh
  else
    echo "No parameters provided and /script.sh does not exist."
    echo "Usage: docker run pre-install-toolbox [URL|SCRIPT_STRING]"
    exit 1
  fi
else
  # Check if the first argument is a URL or a script string
  FIRST_ARG=$1
  shift

  # Check if it's a URL (starts with http:// or https://)
  case "$FIRST_ARG" in
    http://*|https://*)
      # It's a URL - download and execute
      echo "Downloading and executing script from URL: $FIRST_ARG"
      if command -v curl > /dev/null 2>&1; then
        curl -s "$FIRST_ARG" | sh -s "$@"
      else
        wget -O - "$FIRST_ARG" | sh -s "$@"
      fi
      ;;
    *)
      # It's a script string - execute directly
      echo "Executing provided script string"
      echo "$FIRST_ARG" | sh -s "$@"
      ;;
  esac
fi