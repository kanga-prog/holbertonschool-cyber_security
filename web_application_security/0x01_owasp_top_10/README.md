# OWASP Top 10 – Web Application Security (2021)

## 📌 Project Overview

This project focuses on understanding and practicing **web application security** based on the **OWASP Top 10 (2021)**. Through theory and hands-on labs, the goal is to identify, exploit, and understand common web vulnerabilities, then learn how they can be prevented.

The environment used for this project is **Kali Linux 2023.2**, and the target machine is **Cyber - WebSec 0x01**.

---

## 📚 Resources

### Read or Watch

* OWASP Top 10:2021
* Explaining the OWASP Top 10
* Understanding the OWASP Top 10 with Examples
* OWASP Top 10: The Big Picture
* OWASP Top 10 Risks – Mitigation Strategies
* How to Choose a Password

### References

* OWASP Official Website
* OWASP Top 10 – Wikipedia
* OWASP Top 10 Proactive Controls
* OWASP Cheat Sheet Series
* OWASP ZAP – Web Application Penetration Testing Tool
* OWASP Amass – Subdomain Enumeration Tool
* OWASP Juice Shop – Vulnerable Web Application
* OWASP Dependency-Check – Software Composition Analysis Tool

---

## 🎯 Learning Objectives

By the end of this project, you should be able to explain **without using Google**:

* What is the OWASP Top 10?
* Why is injection dangerous?
* How does XSS affect web applications?
* What is the risk of broken authentication?
* What is sensitive data exposure?
* What is a security misconfiguration?
* What is XML External Entity (XXE)?
* How do broken access controls impact security?
* What are common web application security flaws?
* How to prevent insecure deserialization?
* Why security logging and monitoring are important?
* What are the risks of using components with known vulnerabilities?
* How APIs can increase security risks?

---

## 🔐 OWASP Top 10 (2021) Summary

1. **Broken Access Control** – Users can access unauthorized resources.
2. **Cryptographic Failures** – Sensitive data is exposed due to weak or missing encryption.
3. **Injection** – Untrusted input is interpreted as commands or queries.
4. **Insecure Design** – Lack of secure architecture and threat modeling.
5. **Security Misconfiguration** – Default settings, open permissions, or verbose errors.
6. **Vulnerable and Outdated Components** – Using libraries with known vulnerabilities.
7. **Identification and Authentication Failures** – Weak login and session handling.
8. **Software and Data Integrity Failures** – Insecure CI/CD pipelines or updates.
9. **Security Logging and Monitoring Failures** – Attacks go undetected.
10. **Server-Side Request Forgery (SSRF)** – Server makes unauthorized internal requests.

---

## 🛠️ Tools Used

* **Kali Linux 2023.2**
* **curl** – HTTP requests and testing
* **Burp Suite / Browser DevTools** – Traffic inspection
* **OWASP ZAP** – Web application scanning
* **Custom Bash scripts** – Exploitation and decoding

---

## ⚙️ Requirements

### General

* All scripts run on **Kali Linux 2023.2**
* Allowed editors: `vi`, `vim`, `emacs`
* The first line of all scripts must be:

  ```bash
  #!/bin/bash
  ```
* All files must end with a new line
* You must substitute the IP range for `$1`
* Forbidden operators:

  * backticks `` ` ``
  * `&&`
  * `||`
  * `;`
* Code must follow **Betty style**

  * Checked with `betty-style.pl` and `betty-doc.pl`

---

## 📂 Repository Structure

```text
holbertonschool-cyber_security/
└── web_application_security/
    └── 0x01_owasp_top_10/
        ├── README.md
        ├── 1-xor_decoder.sh
        ├── 2-flag.txt
        └── ...
```

---

## 🧠 Key Takeaway

This project demonstrates that:

* Encoding is **not** encryption
* Client-side controls are **not** security
* Weak cryptography leads to data leaks
* Observing HTTP traffic is often enough to break applications

Understanding the OWASP Top 10 is essential for anyone working in **web development**, **DevSecOps**, or **cybersecurity**.

---

## ✍️ Author

KANGA Kouakou Brice

