#!/bin/bash
tr -cs '[:alnum:]_().:-' '\n' < ./*.log 2>/dev/null | sort | uniq -c | sort -nr
