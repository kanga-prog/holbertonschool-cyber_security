#!/bin/bash

# Check if the argument is provided
if [ -z "$1" ]; then
  echo "Usage: ./1-xor_decoder.sh {xor}encoded_string"
  exit 1
fi

# Remove the {xor} prefix
encoded=$(echo "$1" | sed 's/{xor}//')

# Base64 decode the input
decoded=$(echo "$encoded" | base64 -d 2>/dev/null)

# Check if base64 decoding succeeded
if [ $? -ne 0 ]; then
  echo "Error: Invalid Base64 input."
  exit 1
fi
