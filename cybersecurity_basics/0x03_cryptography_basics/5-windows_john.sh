#!/bin/bash
john --wordlist=/usr/share/wordlists/rockyou.txt --format=nt "$1" 2>/dev/null
cut -d: -f2 ~/.john/john.pot > 5-password.txt
