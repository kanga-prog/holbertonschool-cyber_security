#!/bin/bash
bash -c 'hashcat -m 0 -a 1 "$0" wordlist1.txt wordlist2.txt --quiet 2>/dev/null; hashcat --show -m 0 "$0" 2>/dev/null | cut -d: -f2 > 9-password.txt' "$1"
