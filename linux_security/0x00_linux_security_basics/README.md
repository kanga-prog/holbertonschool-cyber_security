# 0x00 Linux Security Basics

This project introduces the foundational concepts of Linux security, including system monitoring, file protection, networking, and firewall management.  
It is part of the **Holberton School Cyber Security specialization**.

## 📚 Learning Objectives

By the end of this project, you should be able to explain:

### 🔹 Linux & Filesystem
- What Linux is
- What a Linux command is
- The structure of the Linux operating system
- What the FHS (Filesystem Hierarchy Standard) is and why it matters
- The purpose of each main directory in the Linux file system

### 🔹 Security & Protection
- How to protect files and directories
- How to monitor and investigate system activity
- How to securely transfer files (SCP)
- How to configure and manage a firewall (UFW, iptables)
- How to identify and terminate malicious processes

### 🔹 Networking & Monitoring Commands
- Using `ps` and `kill` to manage processes
- Using `netstat` and `ss` to inspect network activity
- Using `nmap`, `lynis`, and `tcpdump` for auditing and traffic analysis
- Managing firewall rules using `iptables` and `ufw`

## 🛡️ Requirements

All scripts in this project must follow these rules:

- Must run on **Kali Linux**
- Exactly **2 lines** per script (verified using `wc -l`)
- The first line must be exactly:  
  `#!/bin/bash`
- Must substitute the IP range using `$1`
- No backticks, no `&&`, no `||`, no `;`
- Must follow Betty style (`betty-style.pl`, `betty-doc.pl`)
- All files must end with a new line
- All scripts must be executable

## 📝 Tasks

### **0. What secrets hold**
Write a Bash script that displays the last **five login sessions** of users, with their corresponding dates and times.

- Must be executed as a privileged user (`root` or sudo)
- Output will vary depending on your system

Example:


