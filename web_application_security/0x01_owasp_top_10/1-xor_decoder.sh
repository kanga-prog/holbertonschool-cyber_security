#!/bin/bash

# Check argument
if [ -z "$1" ]
then
  exit 1
fi

# Remove {xor}
encoded=$(echo "$1" | sed 's/{xor}//')

# Base64 decode
decoded=$(echo "$encoded" | base64 -d 2>/dev/null)

key=95
result=""

for byte in $(printf "%s" "$decoded" | od -An -tu1)
do
  result="$result$(printf "\\$(printf '%03o' $((byte ^ key)))")"
done

printf "%s\n" "$result"
