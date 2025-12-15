# 0x02 – Active Reconnaissance

## 📌 Project Overview

This project focuses on **Active Reconnaissance**, a critical phase in cyber security and penetration testing.  
Active reconnaissance involves **direct interaction with a target system** in order to gather technical information about its infrastructure, services, and potential attack surfaces.

The target of this project is:

- **Target:** `cyber_netsec_0x02`

All reconnaissance activities are performed in a controlled learning environment using **Kali Linux**.

---

## 🎯 Learning Objectives

By the end of this project, you should be able to explain, without using Google:

- What **active reconnaissance** is
- Why **active reconnaissance is important** in cyber security
- How **Wappalyzer** can be used for active reconnaissance
- What **DNS enumeration** is
- How to enumerate **SMTP services** using command-line tools
- How to perform **OS fingerprinting**
- What **sqlmap** is and how to use it

---

## 🔍 What is Active Reconnaissance?

Active reconnaissance is the process of **actively sending packets or requests to a target system** to gather information such as:
- Live hosts
- Open ports
- Running services
- Operating systems
- Web technologies
- Database vulnerabilities

Unlike passive reconnaissance, active reconnaissance **can be detected** by the target.

---

## 🧰 Tools & Techniques Used

### Network & Host Discovery
- `ping`
- `traceroute`
- `nmap`

### Service Interaction
- `telnet`
- `netcat`

### Web Technology Fingerprinting
- **Wappalyzer**

### Database Exploitation
- `sqlmap`

---

## 📚 Resources

### Read or Watch
- What is a ping?
- What does Traceroute Do?
- Top 8 Nmap Commands
- How Hackers Use Reconnaissance?
- SQLMap Cheat Sheet

### References
- `ping`
- `traceroute`
- `telnet`
- `netcat`
- `Wappalyzer`

---

## 🧪 OS Fingerprinting

Operating System fingerprinting is performed using tools such as:
- `nmap -O`
- TCP/IP stack analysis
- Service response behavior

This allows identification of the target operating system and kernel characteristics.

---

## 🗄️ DNS & SMTP Enumeration

- **DNS enumeration** helps discover subdomains, mail servers, and infrastructure layout.
- **SMTP enumeration** can be done using `nmap`, `telnet`, or `netcat` to identify valid users and mail services.

---

## 💉 SQLMap

`sqlmap` is an automated SQL injection tool used to:
- Detect SQL injection vulnerabilities
- Enumerate databases
- Extract data
- Execute commands (when permitted)

---

## ⚙️ Requirements

### General
- Allowed editors: `vi`, `vim`, `emacs`
- All scripts must be tested on **Kali Linux**
- Each script must be **exactly one line long**
- All files must end with a **new line**
- A `README.md` file is mandatory at the root of the project folder

---

## ⚠️ Disclaimer

This project is for **educational purposes only**.  
All actions are performed on an authorized training target.  
Unauthorized reconnaissance or attacks on real systems are illegal.

---

## ✍️ Author

- **Student:** Holberton School
- **Project:** 0x02_active_reconnaissance

