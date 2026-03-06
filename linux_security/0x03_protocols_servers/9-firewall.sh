#!/bin/bash
iptables -P INPUT -j DROP && iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
