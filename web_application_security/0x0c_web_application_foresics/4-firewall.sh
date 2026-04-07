#!/bin/bash
grep -E 'iptables.*(^|[[:space:]])-(A|I)([[:space:]]|$)' $1 | wc -l
