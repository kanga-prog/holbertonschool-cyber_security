# 0x06. Nmap Advanced Port Scans

## Description

This project introduces advanced port scanning techniques with **Nmap** in a Bash scripting context.

The goal is to understand how to use advanced Nmap scan types in order to identify:
- open ports
- closed ports
- filtered ports
- firewall behavior
- exposed services on a target host

The scripts in this project are designed to run on **Kali Linux** and follow strict formatting and style requirements.

---

## Learning Objectives

At the end of this project, you should be able to explain:

- How to use Nmap for advanced port scans
- What the different types of advanced port scans are
- How advanced Nmap scans work
- What can be detected with advanced port scans
- The use cases and scenarios for advanced port scans
- The main difference between a standard Nmap scan and an advanced port scan
- The differences between a TCP Connect Scan and a SYN Scan
- How an ACK Scan helps in determining firewall rules
- What FIN, NULL, and Xmas scans are
- Why Nmap is useful for securing system ports
- What kind of information advanced port scans can reveal about a network

---

## Requirements

- Allowed editors: `vi`, `vim`, `emacs`
- All scripts are tested on **Kali Linux**
- All scripts must be exactly **two lines long**
- The first line of every script must be exactly:

```bash
#!/bin/bash
