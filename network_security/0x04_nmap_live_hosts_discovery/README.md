0x04 – Nmap Live Hosts Discovery
📌 Project Overview

This project focuses on host discovery techniques using Nmap. The goal is to understand how Nmap identifies live hosts on a network without performing full port scans, using multiple discovery methods such as ARP, ICMP, TCP, and UDP ping scans.

All scripts are written in Bash, executed on Kali Linux, and strictly follow Holberton School constraints.

📚 Resources

Read or watch:

Nmap Documentation

Nmap Description

Nmap Options Summary

Target Specification

Host Discovery

Official references:

https://nmap.org/book/man-host-discovery.html

🎯 Learning Objectives

At the end of this project, you should be able to explain without Google:

What is Nmap

How to use Nmap

How Nmap scanning works internally

What subnetworks are

How to enumerate scan targets

What an ARP Scan is

What an ICMP Echo Scan is

What an ICMP Timestamp Scan is

What an ICMP Address Mask Scan is

What a TCP SYN Ping Scan is

What a TCP ACK Ping Scan is

What a UDP Ping Scan is

What Nmap can detect

How to scan an IP address with Nmap

How to scan ports with Nmap

⚙️ Requirements
General

Allowed editors: vi, vim, emacs

OS: Kali Linux

All scripts must be exactly 2 lines long

All scripts must be executable

First line must be:

#!/bin/bash

$1 must be used without quotes

Do NOT use: ;, &&, ||, backticks

All files must end with a new line

Must follow Betty style (betty-style.pl & betty-doc.pl)

A README.md file is mandatory

🧠 Host Discovery Techniques
1️⃣ ARP Scan

Uses ARP requests

Works only inside the local network

Fast and very reliable

nmap -sn -PR $1
2️⃣ ICMP Echo Scan (Ping)

Uses ICMP Echo Request

Often blocked by firewalls

nmap -sn -PE $1
3️⃣ ICMP Timestamp Scan

Uses ICMP Timestamp Request

Rarely allowed by hosts

nmap -sn -PP $1
4️⃣ ICMP Address Mask Scan

Uses ICMP Address Mask Request

Mostly obsolete

nmap -sn -PM $1
5️⃣ TCP SYN Ping Scan

Sends TCP SYN packets

Host is alive if SYN/ACK or RST is received

nmap -sn -PS22,80,443 $1
6️⃣ TCP ACK Ping Scan

Sends TCP ACK packets

Useful to bypass firewalls

nmap -sn -PA22,80,443 $1
7️⃣ UDP Ping Scan

Sends empty UDP packets

Host responds with ICMP Port Unreachable

nmap -sn -PU53,161,162 $1
🗂️ Project Files
File	Description
0-arp_scan.sh	ARP-based live host discovery
1-icmp_echo_scan.sh	ICMP Echo discovery
2-icmp_timestamp_scan.sh	ICMP Timestamp discovery
3-icmp_address_mask_scan.sh	ICMP Address Mask discovery
4-tcp_syn_ping.sh	TCP SYN Ping discovery
5-tcp_ack_ping.sh	TCP ACK Ping discovery
6-udp_ping_scan.sh	UDP Ping discovery
100-flag.txt	Captured flag from UDP service scan
🚩 Flag Challenge

The flag was hidden in the UDP service version between ports 200–300.

Scan command used:

sudo nmap -sU -sV -p200-300 <TARGET_IP>

The flag was found inside the service version banner.

✅ Key Takeaways

Host discovery is different from port scanning

ARP is the most reliable method on local networks

ICMP methods are often blocked

TCP and UDP ping scans help bypass firewalls

Nmap provides multiple discovery techniques for different scenarios

👤 Author

Holberton School – Kanga Kouakou Brice
