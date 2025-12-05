#!/bin/bash
ps aux | awk -v user="$1" '$1 == user && $5 > 0 && $6 > 0'
