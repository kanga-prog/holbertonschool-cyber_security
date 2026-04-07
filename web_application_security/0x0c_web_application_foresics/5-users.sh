#!/bin/bash
grep 'new user:' $1 | sed -E 's/.*name=([^,]+).*/\1/' | sort -u | paste -sd,
