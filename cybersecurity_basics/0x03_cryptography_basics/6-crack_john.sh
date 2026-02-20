#!/bin/bash
john --wordlist=/usr/share/wordlists/rockyou.txt --format=raw-sha256 "$1" 2>/dev/null && john --show --format=raw-sha256 "$1" 2>/dev/null | cut -d: -f2 > 6-password.txt
