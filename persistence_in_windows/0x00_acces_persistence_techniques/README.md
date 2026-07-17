# Access Persistence Techniques

## Description

This project introduces Windows persistence techniques used by attackers to
maintain access to a compromised system after a reboot or user logon.

The exercises are performed in an authorized Windows laboratory environment.
They focus on identifying, analyzing, and documenting persistence mechanisms
without executing suspicious files.

## Learning Objectives

At the end of this project, I should be able to explain:

- What Windows persistence is.
- Why attackers establish persistence.
- How the Windows Startup folders work.
- How to inspect suspicious startup files.
- How Registry keys and scheduled tasks can provide persistence.
- How to identify persistence mechanisms safely.
- How to calculate file hashes for forensic validation.
- How persistence techniques map to MITRE ATT&CK.

## Environment

- Kali Linux
- Windows 10 laboratory machine
- PowerShell
- Evil-WinRM
- Git

## MITRE ATT&CK Mapping

| Technique | ID | Description |
|---|---|---|
| Boot or Logon Autostart Execution | T1547 | Automatically executes a program during boot or logon |
| Registry Run Keys / Startup Folder | T1547.001 | Executes a referenced program when a user logs in |

## Task 0: Persistence Using Startup Folder

The objective of this task was to inspect both Windows Startup locations:

### User-specific Startup folder

```text
C:\Users\<Username>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
