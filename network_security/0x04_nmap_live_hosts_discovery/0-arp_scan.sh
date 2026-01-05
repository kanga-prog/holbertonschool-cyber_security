#!/bin/bash

# Check if a subnetwork is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <subnetwork>"
    exit 1
fi

# Run ARP scan using nmap (host discovery only, no port scan)
sudo nmap -sn -PR "$1"
