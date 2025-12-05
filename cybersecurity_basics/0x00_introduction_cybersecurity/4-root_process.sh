#!/bin/bash
ps -u "$1" -o user,pid,%cpu,%mem,vsz,rss,tty,stat,start,time,cmd | awk '$5 != 0 || $6 != 0'
