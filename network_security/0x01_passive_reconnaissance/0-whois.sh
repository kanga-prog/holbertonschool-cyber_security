#!/bin/bash
whois $1 | awk -F': ' '/^Registrant |^Admin |^Tech /{gsub(/Street$/,"Street ");print $1 "," $2} /^Phone Ext/ {print "Phone Ext:,"} /^Fax Ext/ {print "Fax Ext:,"}'
