#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <elf_file>" >&2
    exit 1
fi

file_name="$1"

if [ ! -f "$file_name" ]; then
    echo "Error: File '$file_name' does not exist." >&2
    exit 1
fi

if [ ! -r "$file_name" ]; then
    echo "Error: File '$file_name' is not readable." >&2
    exit 1
fi

elf_header="$(LC_ALL=C readelf -h "$file_name" 2>/dev/null)"

if [ "$?" -ne 0 ]; then
    echo "Error: File '$file_name' is not a valid ELF file." >&2
    exit 1
fi

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
messages_file="$script_directory/messages.sh"

if [ ! -f "$messages_file" ]; then
    echo "Error: messages.sh was not found." >&2
    exit 1
fi

source "$messages_file"

magic_number="$(
    printf '%s\n' "$elf_header" |
    awk -F: '/^[[:space:]]*Magic:/ {
        sub(/^[[:space:]]+/, "", $2)
        print $2
    }'
)"

class="$(
    printf '%s\n' "$elf_header" |
    awk -F: '/^[[:space:]]*Class:/ {
        sub(/^[[:space:]]+/, "", $2)
        print $2
    }'
)"

byte_order="$(
    printf '%s\n' "$elf_header" |
    awk -F: '/^[[:space:]]*Data:/ {
        sub(/^[[:space:]]+/, "", $2)
        print $2
    }'
)"

entry_point_address="$(
    printf '%s\n' "$elf_header" |
    awk -F: '/^[[:space:]]*Entry point address:/ {
        sub(/^[[:space:]]+/, "", $2)
        print $2
    }'
)"

display_elf_header_info
