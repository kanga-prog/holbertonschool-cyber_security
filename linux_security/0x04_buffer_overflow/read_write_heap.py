#!/usr/bin/python3
"""Find a string in the heap of a running process and replace it."""

import sys


def usage():
    """Print usage message and exit with status code 1."""
    print("Usage: {} pid search_string replace_string".format(sys.argv[0]))
    sys.exit(1)


def get_heap_range(pid):
    """Return the start and end addresses of the heap."""
    maps_path = "/proc/{}/maps".format(pid)

    with open(maps_path, "r") as maps_file:
        for line in maps_file:
            parts = line.split()
            if parts and parts[-1] == "[heap]":
                start_str, end_str = parts[0].split("-")
                return int(start_str, 16), int(end_str, 16)

    raise ValueError("Heap not found")


def replace_in_heap(pid, search_bytes, replace_bytes):
    """Search and replace a string in the heap of a process."""
    start, end = get_heap_range(pid)
    mem_path = "/proc/{}/mem".format(pid)

    with open(mem_path, "rb+") as mem_file:
        mem_file.seek(start)
        heap_data = mem_file.read(end - start)

        offset = heap_data.find(search_bytes)
        if offset == -1:
            raise ValueError("search_string not found")

        write_addr = start + offset
        mem_file.seek(write_addr)
        mem_file.write(
            replace_bytes + b"\x00" * (len(search_bytes) - len(replace_bytes))
        )

    return write_addr


def main():
    """Program entry point."""
    if len(sys.argv) != 4:
        usage()

    pid_arg = sys.argv[1]
    search_string = sys.argv[2]
    replace_string = sys.argv[3]

    if not pid_arg.isdigit():
        usage()

    try:
        search_bytes = search_string.encode("ascii")
        replace_bytes = replace_string.encode("ascii")
    except UnicodeEncodeError:
        print("Error: strings must be ASCII")
        sys.exit(1)

    if len(replace_bytes) > len(search_bytes):
        print("Error: replace_string must be shorter than or equal to search_string")
        sys.exit(1)

    pid = int(pid_arg)

    try:
        address = replace_in_heap(pid, search_bytes, replace_bytes)
        print("SUCCESS!")
        print("Replaced at address 0x{:x}".format(address))
    except Exception as exc:
        print("Error: {}".format(exc))
        sys.exit(1)


if __name__ == "__main__":
    main()

