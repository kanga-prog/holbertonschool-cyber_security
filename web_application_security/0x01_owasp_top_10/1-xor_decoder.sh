#!/bin/bash

if [ -z "$1" ]
then
  exit 1
fi

key="WebSphere"

encoded=$(printf "%s" "$1" | sed 's/{xor}//')
decoded=$(printf "%s" "$encoded" | base64 -d 2>/dev/null)

i=0
len=${#key}
result=""

for byte in $(printf "%s" "$decoded" | od -An -tu1 -v)
do
  k=$(printf "%d" "'${key:$((i % len)):1}")
  result="$result$(printf "\\$(printf '%03o' $((byte ^ k)))")"
  i=$((i + 1))
done

printf "%s\n" "$result"
