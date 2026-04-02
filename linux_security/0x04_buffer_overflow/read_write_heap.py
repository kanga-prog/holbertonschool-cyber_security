#!/usr/bin/env python3
"""Diagnostic helper: validate a target PID and inspect its heap mapping safely."""
import os
import sys


def fail(msg: str, code: int = 1) -> None:
    print(f"Error: {msg}", file=sys.stderr)
    sys.exit(code)


if len(sys.argv) != 4:
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)

try:
    pid_ = int(sys.argv[1])
except ValueError:
    fail("PID must be an integer.")

search = sys.argv[2].encode()
replace = sys.argv[3].encode()

proc_dir = f"/proc/{pid_}"
maps_path = f"{proc_dir}/maps"
mem_path = f"{proc_dir}/mem"

if not os.path.isdir(proc_dir):
    fail(f"process {pid_} does not exist.")

if not os.path.exists(maps_path):
    fail(f"{maps_path} does not exist.")

if not os.access(maps_path, os.R_OK):
    fail(f"{maps_path} is not readable.")

try:
    with open(maps_path, "r", encoding="utf-8", errors="replace") as maps_file:
        heap_line = next(
            (line.strip() for line in maps_file if "[heap]" in line and "rw" in line),
            None
        )
except PermissionError:
    fail(f"permission denied while reading {maps_path}.")
except OSError as e:
    fail(f"unable to read {maps_path}: {e}")

if heap_line is None:
    fail("no readable/writable heap region found.")

try:
    addr_range = heap_line.split()[0]
    start_s, end_s = addr_range.split("-")
    start = int(start_s, 16)
    end = int(end_s, 16)
except (IndexError, ValueError) as e:
    fail(f"failed to parse heap mapping: {e}")

print(f"PID           : {pid_}")
print(f"Search string : {search!r}")
print(f"Replace string: {replace!r}")
print(f"Heap mapping  : {heap_line}")
print(f"Heap start    : 0x{start:x}")
print(f"Heap end      : 0x{end:x}")
print(f"Heap size     : {end - start} bytes")

if not os.path.exists(mem_path):
    fail(f"{mem_path} does not exist.")

if not os.access(mem_path, os.R_OK):
    print(f"Warning: {mem_path} is not readable with current privileges.", file=sys.stderr)

print("Validation OK: target process and heap mapping found.")
print("Stopped before any memory read/write.")
