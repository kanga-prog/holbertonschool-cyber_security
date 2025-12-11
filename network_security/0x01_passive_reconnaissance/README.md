# 0x01 – Passive Reconnaissance

This project focuses on **passive information gathering techniques**, essential in cybersecurity and ethical hacking.  
Passive reconnaissance is the act of collecting information **without directly interacting** with the target systems, making detection almost impossible.

## Learning Objectives

At the end of this project, you should be able to explain:

- What information can be learned about a server
- What a DNS server is
- What happens when entering a URL in a browser (DNS resolution sequence)
- How to find owner information for a domain (WHOIS)
- The purpose of the tools **dig** and **nslookup**
- The different types of DNS records (A, MX, CNAME, TXT…)
- What **DNSDumpster** is and how it is used to gather publicly exposed DNS data
- What **Shodan.io** is and how it indexes devices on the internet
- How subdomains can be discovered
- What **subfinder** is
- The difference between **active** and **passive** reconnaissance

## Tools Used

- `whois` – domain ownership information
- `dig` – DNS queries
- `nslookup` – DNS lookups
- `subfinder` – subdomain enumeration
- `host` – basic DNS queries
- OSINT platforms: **DNSDumpster**, **Shodan**, etc.

## Tasks Summary

### **0. Who is it?**
Write a Bash script that:
- Runs a WHOIS scan on a domain
- Extracts Registrant, Admin, and Tech contact information
- Outputs formatted CSV fields using `awk` (`Field,Value`)
- Ensures a space after Street fields
- Includes `Ext:` fields
- Produces no extra newline at end of file

Output example:

