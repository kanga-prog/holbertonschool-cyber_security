#!/bin/bash
subfinder -d $1 -silent | while read host; do echo "$host,$(dig +short $host | head -n1)"; done > "$1.txt"
