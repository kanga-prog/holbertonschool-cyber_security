#!/bin/bash
nmap -sn -PA22,80,443 $1
