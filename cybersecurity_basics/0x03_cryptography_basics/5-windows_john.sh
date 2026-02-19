#!/bin/bash
john --wordlist=/usr/share/wordlists/rockyou.txt --format=nt "$1" 2>/dev/null && john --show --format=nt "$1" 2>/dev/null | grep ":" | cut -d: -f2 > 5-password.txt
