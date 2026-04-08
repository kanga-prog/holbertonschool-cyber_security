# Incident Response and NSE Automation Scripts

This repository section contains Bash scripts created to support two practical cybersecurity workflows:

1. **Web Application Fast Incident Response**
2. **Nmap NSE Post-Port Scan Scripting**

These tasks focus on log analysis, attack identification, and automated service/vulnerability enumeration using Nmap and NSE scripts.

---

## Project Objectives

The goal of these tasks is to strengthen practical skills in:

- identifying malicious activity from web logs
- detecting attack patterns and attacker behavior
- extracting actionable incident response indicators
- using Nmap NSE scripts for enumeration and vulnerability analysis
- saving structured scan results for later investigation

---

# Part 1: Web Application Fast Incident Response

These scripts analyze a web server log file to identify the likely attacker, the targeted endpoint, the attack volume, and the probable client library used.

## Files

- `0-attack_ip.sh`
- `1-endpoint.sh`
- `2-count_attack.sh`
- `3-library.sh`

---

## 0. Identify the Attack Source

### Description
This script identifies the IP address that generated the highest number of requests in the log file.

### Purpose
The IP with the highest request count is assumed to be the attacker or the most suspicious source.

### Usage
```bash
./0-attack_ip.sh logs.txt
