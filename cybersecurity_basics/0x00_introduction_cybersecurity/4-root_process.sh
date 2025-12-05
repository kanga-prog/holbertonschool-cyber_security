#!/bin/bash
ps -u "$1" -o user,pid,vsz,rss,cmd | grep -v " 0 "
