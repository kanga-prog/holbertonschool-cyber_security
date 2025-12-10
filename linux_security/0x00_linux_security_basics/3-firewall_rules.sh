#!/bin/bash
iptables -t security -L -n -v # List all rules in security table with verbose output
