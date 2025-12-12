#!/bin/bash
whois $1 | awk -F': ' '/^(Registrant|Admin|Tech)/ { k=$1; v=$2; gsub(/^ +| +$/,"",v); if(k ~ /Street/) v=v" "; if(k ~ /Ext$/) printf("%s:,%s\n",k,""); else printf("%s,%s\n",k,v) }' > $1.csv
