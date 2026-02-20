#!/bin/bash
bash -c 'john --wordlist=/usr/share/wordlists/rockyou.txt --format=nt "$0" 2>/dev/null; cat ~/.john/john.pot 2>/dev/null | grep -v "^$" | cut -d: -f2 > 5-password.txt' "$1"
