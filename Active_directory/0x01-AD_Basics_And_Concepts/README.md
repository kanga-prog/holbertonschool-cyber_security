# Active Directory Basics and Concepts

## Project Overview

This project focuses on basic Active Directory enumeration and investigation techniques in a controlled lab environment.  
The goal is to understand how information can be exposed through Active Directory objects, user attributes, group metadata, and Windows system components such as the registry.

All actions were performed from a Kali Linux attacker machine against a Windows Server 2019 Active Directory environment.

## Lab Environment

| Machine | Role | IP Address |
|---|---|---|
| Kali Linux | Attacker machine | 192.168.56.101 |
| Windows Server 2019 | Domain Controller / Active Directory | 192.168.56.20 |
| Windows 11 | Victim workstation / domain client | Lab workstation |

Domain information:

```text
Domain: PENTESTLAB.local
Domain Controller: DC01.PENTESTLAB.local
Base DN: DC=PENTESTLAB,DC=local
Tools Used
Kali Linux
Nmap
ldapsearch
Evil-WinRM
PowerShell
Windows Registry tools
grep / sed / awk
Git
Network Discovery

The first step was to identify the Active Directory Domain Controller on the lab network.

ip a
nmap 192.168.56.0/24

The Domain Controller was identified through typical Active Directory ports:

53    DNS
88    Kerberos
135   MSRPC
139   NetBIOS
389   LDAP
445   SMB
464   Kerberos password change
636   LDAPS
3268  Global Catalog LDAP
3269  Global Catalog LDAPS
5985  WinRM

The target Domain Controller was:

192.168.56.20
LDAP RootDSE Enumeration

To identify the Active Directory naming context, RootDSE was queried:

ldapsearch -x -H ldap://192.168.56.20 -s base -b "" defaultNamingContext dnsHostName rootDomainNamingContext

Result:

rootDomainNamingContext: DC=PENTESTLAB,DC=local
dnsHostName: DC01.PENTESTLAB.local
defaultNamingContext: DC=PENTESTLAB,DC=local

This confirmed the domain structure and allowed further LDAP enumeration.

Task 0 — Domain Reconnaissance
Objective

The goal was to enumerate the root domain object and inspect both standard and non-standard Active Directory attributes.

Methodology

Environment variables were defined for easier command reuse:

DC_IP="192.168.56.20"
BASE_DN="DC=PENTESTLAB,DC=local"
DOMAIN_FQDN="PENTESTLAB.local"
USER="labuser"
PASS='P@ssw0rd123!'

The root domain object was queried with explicit property retrieval:

ldapsearch -LLL -x -H ldap://$DC_IP \
-D "$USER@$DOMAIN_FQDN" \
-w "$PASS" \
-b "$BASE_DN" \
-s base \
"(objectClass=*)" "*" "+" > domain_object_all.ldif

The important part of the command is:

"*" = standard attributes
"+" = operational / extended attributes
-s base = only query the root domain object

Because LDIF output can split long lines, the file was unfolded:

sed ':a;N;$!ba;s/\n //g' domain_object_all.ldif > domain_object_unfolded.ldif

Flags were extracted with:

grep -oE '[A-Z]*FLAG0\{[^}]+\}' domain_object_unfolded.ldif
Key Learning

Default LDAP queries do not always show all attributes.
Explicit property retrieval is required when investigating hidden or non-standard fields.

Task 1 — Service Account Enumeration
Objective

The objective was to enumerate service accounts and inspect their attributes for sensitive data.

Service accounts often use prefixes such as:

svc_backup
svc_sql
svc_web
svc_app
Methodology

Service accounts were identified using the sAMAccountName prefix:

ldapsearch -LLL -x -H ldap://$DC_IP \
-D "$USER@$DOMAIN_FQDN" \
-w "$PASS" \
-b "$BASE_DN" \
"(&(objectCategory=person)(objectClass=user)(sAMAccountName=svc*))" \
cn sAMAccountName distinguishedName

All attributes were then requested:

ldapsearch -LLL -x -H ldap://$DC_IP \
-D "$USER@$DOMAIN_FQDN" \
-w "$PASS" \
-b "$BASE_DN" \
"(&(objectCategory=person)(objectClass=user)(sAMAccountName=svc*))" \
"*" "+" > svc_accounts_all.ldif

The LDIF output was unfolded:

sed ':a;N;$!ba;s/\n //g' svc_accounts_all.ldif > svc_accounts_unfolded.ldif

Flags were extracted:

grep -oE '[A-Z]*FLAG[0-9]*\{[^}]+\}|HBTN\{[^}]+\}' svc_accounts_unfolded.ldif | sort -u
Key Learning

Service accounts are commonly misconfigured.
Sensitive information may be stored in overlooked LDAP attributes such as:

description
info
comment
adminDescription
extensionAttribute
Task 2 — Group Metadata Inspection
Objective

The objective was to inspect Active Directory group metadata, especially privileged security groups.

Groups can contain sensitive data in attributes beyond their member lists.

Methodology

Privileged groups were targeted using the adminCount=1 attribute:

ldapsearch -LLL -x -H ldap://$DC_IP \
-D "$USER@$DOMAIN_FQDN" \
-w "$PASS" \
-b "$BASE_DN" \
"(&(objectClass=group)(adminCount=1))" \
cn sAMAccountName distinguishedName adminCount

Then all group attributes were retrieved:

ldapsearch -LLL -x -H ldap://$DC_IP \
-D "$USER@$DOMAIN_FQDN" \
-w "$PASS" \
-b "$BASE_DN" \
"(&(objectClass=group)(adminCount=1))" \
"*" "+" > privileged_groups_all.ldif

The output was unfolded:

sed ':a;N;$!ba;s/\n //g' privileged_groups_all.ldif > privileged_groups_unfolded.ldif

Flags were searched:

grep -oE '[A-Z]*FLAG[0-9]*\{[^}]+\}|HBTN\{[^}]+\}' privileged_groups_unfolded.ldif | sort -u
Key Learning

Privileged groups should not contain sensitive information in metadata fields.
Fields such as description, info, and adminDescription must be reviewed during an Active Directory audit.

Task 3 — Registry Investigation
Objective

The objective was to search for sensitive information stored outside Active Directory, specifically inside the Windows Registry.

The hint pointed to:

HKEY_LOCAL_MACHINE\SOFTWARE
Methodology

A remote PowerShell session was opened using Evil-WinRM:

evil-winrm -i 192.168.56.20 -u labuser -p 'P@ssw0rd123!'

Inside the Evil-WinRM session, the registry was queried:

reg query "HKLM\SOFTWARE" /s /f "FLAG"

Because the output was too large to inspect manually, it was redirected to a file:

$OutFile="$env:USERPROFILE\Documents\reg_flag_search.txt"

reg query "HKLM\SOFTWARE" /s /f "FLAG" 2>&1 |
Out-File -FilePath $OutFile -Encoding utf8 -Width 4096

Write-Host "[+] Result saved to: $OutFile"

Select-String -Path $OutFile -Pattern '[A-Z]*FLAG3\{[^}]+\}|[A-Z]*FLAG[0-9]+\{[^}]+\}|HBTN\{[^}]+\}' -AllMatches |
ForEach-Object { $_.Matches.Value } |
Sort-Object -Unique
Script Explanation
$OutFile="$env:USERPROFILE\Documents\reg_flag_search.txt"

Defines the output file path.

reg query "HKLM\SOFTWARE" /s /f "FLAG"

Searches recursively under HKLM\SOFTWARE for values containing FLAG.

2>&1

Redirects error output into standard output.

Out-File -FilePath $OutFile -Encoding utf8 -Width 4096

Saves the full result into a file with a wide output width to avoid truncated lines.

Select-String

Searches inside the saved file for flag-like patterns.

Sort-Object -Unique

Removes duplicate findings.

Key Learning

Sensitive information is not always stored in Active Directory.
During Windows security assessments, the registry should also be reviewed, especially locations such as:

HKLM\SOFTWARE
HKCU\SOFTWARE
HKLM\SYSTEM
Task 4 — Hidden User Attribute Discovery
Objective

The objective is to enumerate Active Directory user objects and inspect all available attributes, not only the default ones.

The target account has an unusual role, and the flag is stored in a common attribute.

Methodology

From Kali, all user objects can be queried with explicit property retrieval:

ldapsearch -LLL -x -H ldap://$DC_IP \
-D "$USER@$DOMAIN_FQDN" \
-w "$PASS" \
-b "$BASE_DN" \
"(&(objectCategory=person)(objectClass=user))" \
"*" "+" > users_all.ldif

The LDIF output should be unfolded:

sed ':a;N;$!ba;s/\n //g' users_all.ldif > users_unfolded.ldif

Flags can then be searched:

grep -oE '[A-Z]*FLAG[0-9]*\{[^}]+\}|HBTN\{[^}]+\}' users_unfolded.ldif | sort -u

To identify the exact user and attribute:

awk 'BEGIN{RS="";FS="\n"} /FLAG4|PVFLAG4/ {print}' users_unfolded.ldif | \
grep -iE "dn:|cn:|samaccountname|description|info|title|department|adminDescription|comment|FLAG"
Alternative PowerShell Method

From Evil-WinRM:

Get-ADUser -Filter * -Properties * | ForEach-Object {
    $user = $_
    foreach ($prop in $user.PSObject.Properties) {
        $value = ($prop.Value -join " ")
        if ($value -match "FLAG|HBTN|PVFLAG|BHFLAG") {
            [PSCustomObject]@{
                User = $user.SamAccountName
                DistinguishedName = $user.DistinguishedName
                Attribute = $prop.Name
                Value = $value
            }
        }
    }
} | Format-List
Key Learning

User objects contain many attributes that are not always shown in default enumeration.
Security reviews should include all available user properties, especially for accounts with unusual roles.

Common Mistakes and Lessons Learned
Running Linux Commands in PowerShell

ldapsearch is a Linux/Kali command.
It should be executed from Kali, not inside Evil-WinRM.

Wrong context:

*Evil-WinRM* PS C:\Users\labuser\Documents> ldapsearch ...

Correct context:

┌──(kanga-prog㉿kali)-[~]
└─$ ldapsearch ...
Running PowerShell Commands in Kali

PowerShell commands such as Out-File, Write-Host, Select-String, and Get-ADUser must be executed in Windows PowerShell, usually through Evil-WinRM.

Correct context:

*Evil-WinRM* PS C:\Users\labuser\Documents>
LDIF Line Folding

LDIF files can split long lines.
Lines beginning with a space are continuations of the previous line.

To fix this:

sed ':a;N;$!ba;s/\n //g' input.ldif > output_unfolded.ldif
Flag Format

When a flag appears as:

FLAG0{hash}

the full value must be submitted, including the prefix and braces.
The hash alone is not enough.

Repository Structure
holbertonschool-cyber_security/
└── Active_directory/
    └── 0x01-AD_Basics_And_Concepts/
        ├── 0-flag.txt
        ├── 1-flag.txt
        ├── 2-flag.txt
        ├── 3-flag.txt
        ├── 4-flag.txt
        └── README.md
Git Workflow

After creating or updating a flag file:

git status
git add <flag-file>
git commit -m "Add task flag"
git push

Example:

git add 3-flag.txt
git commit -m "Add task 3 registry flag"
git push
Conclusion

This project demonstrates how Active Directory reconnaissance goes beyond simply listing users, groups, and computers.

Important information may be hidden in:

Domain object attributes
Service account attributes
Group metadata
User attributes
Windows Registry keys

The main lesson is that default enumeration is often incomplete.
A proper assessment requires explicit property retrieval, careful inspection of non-standard fields, and an understanding of where administrators may accidentally store sensitive information.

