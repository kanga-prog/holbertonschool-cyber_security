# 0x00 Introduction to Cybersecurity

This directory contains the introductory exercises for **Cybersecurity Basics**.

## Tasks

### 0. Strong Password Generator
- Create a Bash script that generates a strong random password
- Requirements:
  - Accept password length as an argument
  - Use `/dev/urandom` and `[:alnum:]` character class
  - Less than 3 lines
  - No `printf`, backticks, `&&`, `||`, or `;`
  - Must follow Betty style

### 1. Verify the Integrity of a File
- Create a Bash script that validates the integrity of a file
- Requirements:
  - Accept a file and its SHA256 hash as arguments
  - Less than 3 lines
  - You **can** use `echo`
  - Must follow Betty style

## Learning Objectives

By completing this module, you will be able to:

- Understand basic cybersecurity concepts
- Generate strong passwords
- Verify file integrity using SHA256
- Apply good Bash scripting practices following Betty style
- Understand the importance of file security and verification

## Example Usage

### Strong Password Script

```bash
./1-gen_password.sh 20
# Output: a random 20-character alphanumeric password

