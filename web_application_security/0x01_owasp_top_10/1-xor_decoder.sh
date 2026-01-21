#!/bin/bash
#
# XOR WebSphere decoder
#

key="WebSphere"

input=$(echo "$1" | sed 's/^{xor}//')
decoded=$(echo "$input" | base64 -d)

i=0
len=${#key}
result=""

for c in $(echo "$decoded" | od -An -tu1); do
    k=$(printf "%d" "'${key:$((i % len)):1}")
    result="$result$(printf "\\$(printf '%03o' $((c ^ k)))")"
    i=$((i + 1))
done

printf "%s\n" "$result"
