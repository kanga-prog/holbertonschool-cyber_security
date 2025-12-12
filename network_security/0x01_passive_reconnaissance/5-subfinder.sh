#!/bin/bash
subfinder -d $1 -silent | tee /tmp/subs.tmp | xargs -I{} sh -c 'echo "{},$(dig +short {} | head -n1)"' > $1.txt
