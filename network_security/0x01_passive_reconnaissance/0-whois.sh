#!/bin/bash
# 0-whois.sh
# Usage: ./0-whois.sh domain.com

whois $1 | awk '
BEGIN { OFS="," }
# Registrant fields
/^Registrant Name:/ {print "Registrant Name",$2}
/^Registrant Organization:/ {print "Registrant Organization",$2}
/^Registrant Street:/ {print "Registrant Street",$2" "}
# Admin fields
/^Admin Name:/ {print "Admin Name",$2}
/^Admin Organization:/ {print "Admin Organization",$2}
/^Admin Street:/ {print "Admin Street",$2" "}
# Tech fields
/^Tech Name:/ {print "Tech Name",$2}
/^Tech Organization:/ {print "Tech Organization",$2}
/^Tech Street:/ {print "Tech Street",$2" "}
# Common fields
/^City:/ {print $1,$2}
/^State\/Province:/ {print $1,$2}
/^Postal Code:/ {print $1,$2}
/^Country:/ {print $1,$2}
/^Phone:/ {print $1,$2}
/^Phone Ext:/ {print $1","}   # Always include colon
/^Fax:/ {print $1","}
/^Fax Ext:/ {print $1","}
/^Email:/ {print $1,$2}
' | sed '$!s/$/\n/' > "$1.csv"
