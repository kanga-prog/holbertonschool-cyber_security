#!/bin/bash
bash -c "iptables -P INPUT DROP; iptables -A INPUT -p tcp --dport 80 -j ACCEPT; echo Rules updated; ip6tables -P INPUT DROP; ip6tables -A INPUT -p tcp --dport 80 -j ACCEPT; echo Rules updated \(v6\)"

