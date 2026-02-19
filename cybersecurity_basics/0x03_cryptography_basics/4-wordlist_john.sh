#!/bin/bash
john --wordlist=/usr/share/wordlists/rockyou.txt --format=raw-md5 $1 2>/dev/null && cat ~/.john/john.pot | cut -d: -f2 > 4-password.txt
