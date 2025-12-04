#!/bin/bash
# Usage: ./1-gen_password.sh 20
< /dev/urandom tr -dc '[:alnum:]' | head -c "$1"; echo
