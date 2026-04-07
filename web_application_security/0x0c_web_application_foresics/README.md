web_application_security/0x0c_web_application_foresics.

# Web Application Forensics

## Description
This project focuses on analyzing system and authentication logs to investigate a security incident on a Linux server.  
The objective is to identify how attackers gained access, determine what accounts were compromised, count distinct attackers, review firewall mitigations, enumerate created user accounts, and propose future security improvements.

By examining `auth.log` and `dmesg`, we can reconstruct attacker activity and extract actionable information to improve system security.

## Learning Objectives
At the end of this project, you should be able to:

- Analyze authentication logs to identify attack vectors
- Determine the operating system version of a target machine
- Identify compromised accounts
- Count distinct attacker IP addresses
- Detect firewall mitigation actions in logs
- Extract created user accounts from logs
- Draft an incident report with mitigation and monitoring recommendations

## Requirements
- Allowed editors: `vi`, `vim`, `emacs`
- All scripts are tested on **Kali Linux**
- All files must end with a new line
- The first line of all files must be exactly:

```bash
#!/bin/bash
A README.md file at the root of the project folder is mandatory
You are not allowed to use:
backticks
&&
||
;
Code must follow Betty style
All files must be executable
Ensure that $1 is used without quotes in your scripts
Files Used in This Project
auth.log — authentication and account activity logs
dmesg — kernel boot and system information logs
Project Structure
web_application_security/0x0c_web_application_foresics/
├── README.md
├── auth.log
├── dmesg
├── 0-service.sh
├── 1-operating.sh
├── 2-accounts.sh
├── 3-ips.sh
├── 4-firewall.sh
└── 5-users.sh
Tasks
0. Attacker Service

Identify the service attackers used to gain access to the system.

File concerned: auth.log

Expected finding: attackers used sshd

Example:

./0-service.sh auth.log
1. Operating System

Determine the operating system version of the targeted system.

File concerned: dmesg

Expected output example:

./1-operating.sh dmesg
[    0.000000] Linux version 2.6.24-26-server (buildd@crested) (gcc version 4.2.4 (Ubuntu 4.2.4-1ubuntu3)) #1 SMP Tue Dec 1 18:26:43 UTC 2009 (Ubuntu 2.6.24-26.64-server)
2. Account Compromised

Determine the name of the compromised account.

Tips:

Analyze the last 1000 lines of logs
Check for multiple failed logins followed by a successful one
Look for suspicious activity patterns

File concerned: auth.log

Expected output:

./2-accounts.sh auth.log
root
3. Sum Attack

Count how many distinct attacker IP addresses successfully gained access to the system.

Rule: each unique IP address is considered a different attacker

File concerned: auth.log

Expected output:

./3-ips.sh auth.log
18
4. Mitigation Firewalls

Count how many firewall rules were added after the incident.

File concerned: auth.log

Expected output:

./4-firewall.sh auth.log
6
5. Users Accounts

Identify the user accounts created on the target system.

File concerned: auth.log

Expected output:

./5-users.sh auth.log
Aphelios,Debian-exim,Fido,Jax,Nidalee,Senna,dhg,messagebus,mysql,packet,sshd
6. Future Mitigations

Write an incident report covering:

Introduction
Incident summary and impact
Implementation plan
Monitoring protocol

This task is descriptive and does not require a shell script.

Usage

Make scripts executable:

chmod +x 0-service.sh 1-operating.sh 2-accounts.sh 3-ips.sh 4-firewall.sh 5-users.sh

Run each script with the appropriate file:

./0-service.sh auth.log
./1-operating.sh dmesg
./2-accounts.sh auth.log
./3-ips.sh auth.log
./4-firewall.sh auth.log
./5-users.sh auth.log
Investigation Summary

From the analysis performed:

Attack service: sshd
Operating system: Linux version 2.6.24-26-server
Compromised account: root
Distinct successful attacker IPs: 18
Firewall rules added: 6
Created user accounts: Aphelios, Debian-exim, Fido, Jax, Nidalee, Senna, dhg, messagebus, mysql, packet, sshd
Security Recommendations

Based on the investigation, the following mitigations are recommended:

Disable direct root SSH login
Enforce strong password policies
Prefer SSH keys over password authentication
Restrict SSH access to trusted IPs only
Review and remove suspicious accounts
Audit firewall rules regularly
Upgrade outdated systems and patch vulnerabilities
Enable continuous monitoring of authentication events
Use tools such as Fail2ban for brute-force protection
Author

BRICE KANGA KOUAKOU
