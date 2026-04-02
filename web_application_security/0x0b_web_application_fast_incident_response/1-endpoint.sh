#!/bin/bash
awk -F'"' '{print $2}' $1 | awk '{print $2}' | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'
