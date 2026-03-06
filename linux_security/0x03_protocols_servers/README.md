Network Protocols and Security Fundamentals
Overview

Network protocols are standardized rules that allow devices to communicate over a network. They define how data is transmitted, received, and interpreted between computers, servers, and network devices.

Understanding these protocols is essential in network administration, cybersecurity, and system engineering, because most network vulnerabilities and attacks exploit weaknesses in poorly configured or outdated protocols.

This project explores common network protocols, their functions, and the security considerations associated with them.

Learning Objectives

At the end of this project, you should be able to explain, without the help of Google:

What defines the rules for data exchange in networks

How SMTP is used to send emails

What SNMP reveals about network devices

How SMB allows file sharing between operating systems

The role of LDAP in authentication and authorization

Security risks associated with RDP

Differences between secure and insecure protocols

Why SSH is used for secure remote access

The significance of port numbers in network communication

Differences between encryption protocols

Why network protocols must be updated regularly

Network Protocols
TCP/IP

TCP/IP is the core protocol suite used by the Internet.
It defines how data packets are addressed, transmitted, routed, and received across networks.

The TCP/IP stack consists of four layers:

Application Layer

Transport Layer

Internet Layer

Network Access Layer

TCP ensures reliable data transmission, while IP manages addressing and routing.

SMTP (Simple Mail Transfer Protocol)

SMTP is used for sending email messages between servers and email clients.

Key characteristics:

Used only for sending emails

Works with other protocols such as POP3 or IMAP for receiving mail

Typically operates on ports:

25
587
465 (secure SMTP)
SNMP (Simple Network Management Protocol)

SNMP is used for monitoring and managing network devices.

It provides information such as:

CPU usage

Memory usage

Network traffic

Device uptime

Interface status

SNMP is commonly used in network monitoring systems like:

Nagios

Zabbix

PRTG

Default port:

161

Security risk:
Older versions (SNMPv1 and SNMPv2) transmit community strings in plaintext.

SMB (Server Message Block)

SMB is a protocol used for file and printer sharing over networks, primarily in Windows environments.

Capabilities:

File sharing

Printer sharing

Network resource access

Default port:

445

Security risk:
Misconfigured SMB shares can expose sensitive files or allow unauthorized access.

LDAP (Lightweight Directory Access Protocol)

LDAP is used for directory services, authentication, and authorization.

Organizations use LDAP to manage:

User accounts

Permissions

Groups

Organizational structure

Common implementations:

Microsoft Active Directory

OpenLDAP

Ports:

389
636 (LDAPS - secure)

Security risk:
Unsecured LDAP transmissions may expose credentials.

RDP (Remote Desktop Protocol)

RDP allows users to remotely access and control another computer with a graphical interface.

Commonly used by system administrators to manage servers.

Default port:

3389

Security risks include:

brute-force attacks

credential stuffing

ransomware exploitation

Proper security practices include:

using VPN

enabling multi-factor authentication

restricting IP access

DNS (Domain Name System)

DNS translates human-readable domain names into IP addresses.

Example:

google.com → 142.250.74.14

Without DNS, users would need to remember IP addresses instead of domain names.

Default port:

53
Secure vs Insecure Protocols

Some protocols transmit data unencrypted, while others provide secure encrypted communication.

Insecure Protocol	Secure Alternative
HTTP	HTTPS
FTP	SFTP
Telnet	SSH
SMTP	SMTPS

Secure protocols use encryption methods such as:

TLS

SSH

IPsec

SSH (Secure Shell)

SSH is a protocol used for secure remote administration of systems.

Features:

encrypted communication

secure authentication

remote command execution

file transfer (SCP / SFTP)

Default port:

22

SSH replaces insecure protocols like Telnet.

Port Numbers

A port number identifies a specific service running on a device.

Common ports include:

Protocol	Port
HTTP	80
HTTPS	443
SSH	22
SMTP	25
DNS	53
RDP	3389
SMB	445

Ports allow multiple services to operate on the same machine.

Network Encryption Protocols

Encryption protects data from interception or tampering.

Examples include:

TLS (used in HTTPS)

SSH encryption

IPsec

SMB encryption (SMB3)

Encryption may operate at different layers of the network stack.

Common Network Security Vulnerabilities

Several vulnerabilities arise from misconfigured or outdated network protocols.

Examples include:

SNMP exposing device information when misconfigured

SMB shares allowing unauthorized file access

exposed RDP services vulnerable to brute-force attacks

outdated LDAP implementations allowing unauthorized access

improperly configured firewalls allowing malicious traffic

Proper security measures include:

updating protocols

enforcing strong authentication

restricting network access

encrypting communications

Importance of Updating Network Protocols

Keeping protocols updated is critical for security.

Updates help:

patch vulnerabilities

improve encryption methods

protect against new attack techniques

Example:

SMBv1 was exploited by the WannaCry ransomware attack, highlighting the dangers of outdated protocols.

Conclusion

Network protocols are the foundation of modern communication systems.
Understanding how they function and how they can be secured is essential for protecting networks against cyber threats.

Proper configuration, encryption, monitoring, and regular updates are key to maintaining a secure network infrastructure.
