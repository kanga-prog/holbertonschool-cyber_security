#!/bin/bash
whois $1 | awk -F': ' '/^(Registrant|Admin|Tech)/ {if ($1 ~ /Street/) $2=$2" "; gsub(/^[ \t]+|[ \t]+$/, "", $2); gsub(/ /,"$", $1); gsub(/ /,"$", $2); print $1 "," $2}' > "$1.csv"
