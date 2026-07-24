# ELF Header Information Extractor

## Description

This project is part of the **Holberton School Reverse Engineering** curriculum.

The goal is to create a Bash script capable of reading the header of an ELF (Executable and Linkable Format) binary and displaying essential information using the `readelf` utility.

The script validates the input file, verifies that it is a valid ELF executable, extracts selected header fields, and displays them through a separate message formatting script.

---

## Project Structure

```
re_fundamentals/
│
├── get_entry_point.sh     # Main script
├── messages.sh            # Output formatting functions
└── README.md
```

---

## Features

- Checks that exactly one argument is provided.
- Verifies that the file exists.
- Verifies that the file is readable.
- Confirms that the file is a valid ELF executable.
- Extracts:
  - Magic Number
  - ELF Class
  - Byte Order (Endianness)
  - Entry Point Address
- Uses `messages.sh` for displaying the results.
- Works independently of the system language by forcing `readelf` output to English (`LC_ALL=C`).

---

## Requirements

- Linux operating system
- Bash
- GNU Binutils (`readelf`)

Check that `readelf` is installed:

```bash
which readelf
```

Expected output:

```text
/usr/bin/readelf
```

---

## Usage

```bash
./get_entry_point.sh <elf_file>
```

Example:

```bash
./get_entry_point.sh target_binary
```

Output:

```text
ELF Header Information for 'target_binary':
----------------------------------------
Magic Number: 7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
Class: ELF64
Byte Order: 2's complement, little endian
Entry Point Address: 0x1060
```

---

## Error Handling

### Missing argument

```bash
./get_entry_point.sh
```

Output:

```text
Usage: ./get_entry_point.sh <elf_file>
```

---

### File does not exist

```bash
./get_entry_point.sh unknown_file
```

Output:

```text
Error: File 'unknown_file' does not exist.
```

---

### Invalid ELF file

```bash
echo "Hello" > test.txt
./get_entry_point.sh test.txt
```

Output:

```text
Error: File 'test.txt' is not a valid ELF file.
```

---

## Technologies Used

- Bash
- GNU readelf
- awk
- Shell scripting

---

## Learning Objectives

Through this project, the following concepts are practiced:

- Bash scripting
- File validation
- Command-line argument handling
- Parsing command output
- Understanding the ELF format
- Reverse Engineering fundamentals
- Linux command-line tools

---

## Author

**Brice Kanga**

Holberton School – Cyber Security Specialization
