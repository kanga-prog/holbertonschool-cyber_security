#!/bin/bash
bash -c 'hashcat -m 0 -a 0 "$0" /usr/share/wordlists/rockyou.txt --quiet 2>/dev/null; hashcat --show -m 0 "$0" 2>/dev/null | cut -d: -f2 > 7-password.txt' "$1"
