#!/bin/bash
#
# XOR WebSphere decoder
#

if [ "$#" -ne 1 ]
then
    exit 0
fi

encoded=$(printf "%s" "$1" | sed 's/{xor}//')
decoded=$(printf "%s" "$encoded" | base64 -d)

key="_"
key_len=${#key}
i=0
result=""

for byte in $(printf "%s" "$decoded" | od -An -tu1)
do
    k=$(printf "%d" "'${key:$((i % key_len)):1}")
    result="$result$(printf "\\$(printf '%03o' $((byte ^ k)))")"
    i=$((i + 1))
done

printf "%s\n" "$result"
