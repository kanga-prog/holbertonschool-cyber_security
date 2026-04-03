#!/bin/bash
awk '
{
    count[$1]++
}
END {
    max = 0
    for (ip in count) {
        if (count[ip] > max) {
            max = count[ip]
        }
    }
    print max
}' $1
