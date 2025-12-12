#!/bin/bash

whois "$1" | awk -F': ' '
/^(Registrant|Admin|Tech)/ {
    key=$1; value=$2;

    # Add space after Street values
    if (key ~ /Street$/) value=value" ";

    # Trim value
    gsub(/^[ \t]+|[ \t]+$/, "", value);

    # KEEP “Phone Ext:” and “Fax Ext:” EXACT
    if (key !~ /Ext:$/) gsub(/ /, "$", key);

    gsub(/ /, "$", value);

    print key "," value
}
' > "$1.csv"
