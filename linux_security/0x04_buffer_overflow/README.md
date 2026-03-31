# 0x04. Buffer Overflow

## Description

This project introduces the basics of buffer overflow and Linux process memory inspection.

The goal of task `0. Hack the VM` is to write a Python script that finds a string in the **heap** of a running process and replaces it, without stopping the process.

The script works by reading the process memory layout from `/proc/<pid>/maps`, locating the `[heap]` segment, then reading and modifying the corresponding memory through `/proc/<pid>/mem`.

---

## Learning Objectives

At the end of this project, you should be able to explain:

- What a buffer is
- What a buffer overflow is
- What a buffer overflow attack is
- What causes buffer overflow attacks
- How attackers orchestrate buffer overflow attacks
- The different types of buffer overflow attacks
- How to detect buffer overflow
- The consequences of buffer overflow
- How to prevent and mitigate buffer overflow attacks

---

## Requirements

### Python Scripts

- Allowed editors: `vi`, `vim`, `emacs`
- All files will be interpreted/compiled on **Ubuntu 14.04 LTS** using **Python 3.4.3**
- All files should end with a new line
- The first line of all files should be exactly:

```python
#!/usr/bin/python3
