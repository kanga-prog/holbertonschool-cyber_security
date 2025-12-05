#!/bin/bash
echo "%s  %s\n" "$2" "$1" | sha256sum -c -
