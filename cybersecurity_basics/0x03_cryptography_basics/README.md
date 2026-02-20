# 0x03 – Cryptography Basics

## Description

This project introduces the fundamentals of cryptography used in cybersecurity.
It covers password hashing, secure password storage, and password cracking using
industry-standard tools such as **John the Ripper** and **Hashcat**.

Each task is independent in execution but follows a logical learning progression:
from hashing passwords, to understanding how weak hashes can be cracked, and finally
to more advanced cracking techniques.

All scripts are written in **bash** and tested on **Kali Linux**.

---

## Learning Objectives

By the end of this project, you should be able to:

- Understand the difference between hashing and encryption
- Generate hashes using common algorithms (SHA1, SHA256, MD5, SHA512)
- Understand the concept of salt and why it is important
- Identify different hash formats (MD5, Raw-SHA256, NTLM)
- Use John the Ripper and Hashcat for password cracking
- Understand why weak hashes and weak passwords are insecure

---

## Tasks Overview

### Task 0 – SHA1
**Objective:**  
Hash a password using the SHA-1 algorithm.

**Concept:**  
SHA1 is a fast but outdated hashing algorithm. It is no longer considered secure
against modern attacks.

---

### Task 1 – SHA256
**Objective:**  
Hash a password using the SHA-256 algorithm.

**Concept:**  
SHA256 is part of the SHA-2 family and is significantly stronger than SHA1.
It is commonly used in modern systems.

---

### Task 2 – MD5
**Objective:**  
Hash a password using the MD5 algorithm.

**Concept:**  
MD5 is very fast and cryptographically broken.  
It is included here to demonstrate why weak hashes are easy to crack.

---

### Task 3 – Secure Password Hash (Salt + SHA512)
**Objective:**  
Combine a password with a random value (salt) and hash it using SHA-512 via OpenSSL.

**Concept:**  
Adding a salt prevents rainbow table attacks.
SHA512 is a strong hash, and salting makes precomputed attacks ineffective.

---

### Task 4 – Wordlist Mode (John the Ripper)
**Objective:**  
Crack password hashes using John the Ripper with a wordlist.

**Concept:**  
This task demonstrates dictionary attacks and why users should avoid common passwords.

---

### Task 5 – Windows Authentication Cracking (NTLM)
**Objective:**  
Crack Windows NTLM (NThash) passwords using John the Ripper.

**Concept:**  
NTLM is based on MD4 and is still found in Windows environments.
This task shows why NTLM hashes are vulnerable when weak passwords are used.

---

### Task 6 – John Cracking (Raw-SHA256)
**Objective:**  
Crack Raw-SHA256 hashes using John the Ripper.

**Concept:**  
Even strong hash algorithms can be compromised if passwords are weak
and not salted.

---

### Task 7 – Hashcat Straight Attack
**Objective:**  
Crack a hash using Hashcat in straight (dictionary) attack mode.

**Concept:**  
Hashcat is a high-performance password recovery tool.
This task introduces GPU/CPU accelerated cracking.

---

### Task 8 – Hashcat Combination
**Objective:**  
Generate new passwords by combining two wordlists using Hashcat.

**Concept:**  
Combination attacks are useful when users concatenate words
(e.g., `password123`).

---

### Task 9 – Hashcat Combination Attack
**Objective:**  
Crack a hash using a combined wordlist generated from Task 8.

**Concept:**  
This task demonstrates how attackers adapt their strategies
when simple dictionary attacks fail.

---

## Important Notes

- All scripts must be exactly **two lines long**
- The first line must be `#!/bin/bash`
- No use of `;`, `&&`, `||`, or backticks
- All scripts must be executable
- Hash algorithms must be written in **lowercase**
- Output files must end with a newline

---

## Tools Used

- `sha1sum`, `sha256sum`, `md5sum`
- `openssl`
- `john` (John the Ripper)
- `hashcat`
- `rockyou.txt` wordlist

---

## Conclusion

This project demonstrates that:
- Strong algorithms alone are not enough
- Weak passwords are always the weakest link
- Salting and proper hashing are essential
- Password cracking tools are powerful and realistic attack vectors

Understanding these concepts is critical for building secure systems.


