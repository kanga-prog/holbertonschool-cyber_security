# Security Control Inventory

## Purpose

This document inventories the security controls currently identified for MedDefense Health Systems and classifies each control using two dimensions:

- **Category**: Technical, Administrative, or Physical.
- **Function**: Preventive, Detective, Corrective, Compensating, or Deterrent.

Only controls supported by the provided MedDefense documentation are included. Where a control appears limited, incomplete, or potentially misconfigured, it is still documented as an existing control, but the limitation is stated in the description.

## Control Inventory

### Control ID: C-001
**Control Name:** FortiGate Perimeter Firewall  
**Description:** A Fortinet FortiGate 100F firewall is deployed at MedDefense Central between the Internet, the DMZ, and the internal network. It provides perimeter traffic control for the Central site and supports VPN connectivity from remote sites.  
**Category:** Technical  
**Function:** Preventive  
**Asset(s) Protected:** MedDefense Central internal network, DMZ, web-srv-01, site-to-site VPN connections  
**Source:** Network equipment inventory and network diagram

### Control ID: C-002
**Control Name:** DMZ Placement for Public Web Services  
**Description:** The public website and patient portal server, web-srv-01, is placed in a DMZ connected to the FortiGate firewall rather than being shown directly inside the server network. This reduces direct exposure of internal systems to Internet-originated traffic.  
**Category:** Technical  
**Function:** Preventive  
**Asset(s) Protected:** Internal server network, public website, patient portal, web-srv-01  
**Source:** Network diagram

### Control ID: C-003
**Control Name:** Westside Site-to-Site VPN  
**Description:** Westside Clinic connects to MedDefense Central through an IPSec site-to-site VPN. This provides encrypted connectivity between the clinic and Central infrastructure.  
**Category:** Technical  
**Function:** Preventive  
**Asset(s) Protected:** Westside Clinic traffic, Central infrastructure accessed by Westside users  
**Source:** Network diagram and network equipment inventory

### Control ID: C-004
**Control Name:** Corporate HQ Site-to-Site VPN  
**Description:** Corporate HQ connects to MedDefense Central through a site-to-site VPN over the building-managed network. This provides controlled connectivity between HQ users and Central infrastructure.  
**Category:** Technical  
**Function:** Preventive  
**Asset(s) Protected:** Corporate HQ workstations and laptops, Central infrastructure accessed by HQ users  
**Source:** Network diagram and HR onboarding guide

### Control ID: C-005
**Control Name:** Dedicated HQ VLAN  
**Description:** Corporate HQ uses a building-managed network where MedDefense has its own VLAN. This provides logical separation from other tenants in the leased office building, even though the broader network is managed by the landlord.  
**Category:** Technical  
**Function:** Compensating  
**Asset(s) Protected:** Corporate HQ workstations, laptops, administrative users, HQ network traffic  
**Source:** Network equipment inventory and IT service contracts summary

### Control ID: C-006
**Control Name:** Active Directory Domain Authentication  
**Description:** MedDefense operates two Windows Server 2019 domain controllers, ad-dc-01 and ad-dc-02. These servers provide centralized authentication and identity services for the organization.  
**Category:** Technical  
**Function:** Preventive  
**Asset(s) Protected:** Domain user accounts, workstations, servers, access-controlled systems  
**Source:** IT asset list

### Control ID: C-007
**Control Name:** Password Policy  
**Description:** The documented password policy requires a minimum length of 8 characters, 90-day rotation, and complexity enabled. This provides a baseline authentication requirement for user accounts.  
**Category:** Administrative  
**Function:** Preventive  
**Asset(s) Protected:** User accounts, domain authentication, business applications  
**Source:** Marcus Webb's authentication notes

### Control ID: C-008
**Control Name:** Multi-Factor Authentication for Deputy CISO Account  
**Description:** Multi-factor authentication is enabled on James Chen's personal account. The control is limited in scope because the documentation states that MFA is not deployed elsewhere.  
**Category:** Technical  
**Function:** Preventive  
**Asset(s) Protected:** James Chen's account and associated security administration access  
**Source:** Marcus Webb's authentication notes

### Control ID: C-009
**Control Name:** SSH Key-Only Access on ehr-srv-01  
**Description:** SSH hardening was started and completed for ehr-srv-01, where password authentication was migrated toward key-only access. This reduces exposure to password guessing on that server.  
**Category:** Technical  
**Function:** Preventive  
**Asset(s) Protected:** ehr-srv-01  
**Source:** Marcus Webb's authentication notes

### Control ID: C-010
**Control Name:** Sophos Endpoint Protection  
**Description:** MedDefense has a Sophos endpoint protection contract. This provides endpoint security capability for malware prevention and detection, although the documentation does not confirm that all endpoints are current or covered.  
**Category:** Technical  
**Function:** Detective  
**Asset(s) Protected:** Workstations, laptops, and other managed endpoints  
**Source:** IT service contracts summary and Marcus Webb's endpoint security notes

### Control ID: C-011
**Control Name:** Veeam Nightly Backup Jobs  
**Description:** Veeam runs nightly backups for MedDefense systems. This control supports recovery after data loss, ransomware, or system failure. The backup design is limited because the local NAS is in the same server room, on the same network, and in the same rack.  
**Category:** Technical  
**Function:** Corrective  
**Asset(s) Protected:** Servers, business applications, operational data  
**Source:** Marcus Webb's server notes and IT service contracts summary

### Control ID: C-012
**Control Name:** Local NAS Backup Repository  
**Description:** Backup data is stored on a local NAS used by the backup server. This provides a recovery target for backup operations, but it does not provide offsite resilience.  
**Category:** Technical  
**Function:** Corrective  
**Asset(s) Protected:** Backup data and recoverable server data  
**Source:** Marcus Webb's server notes and network diagram

### Control ID: C-013
**Control Name:** MedTech Solutions EHR Maintenance Contract  
**Description:** MedTech Solutions provides EHR maintenance, including software updates and a documented response SLA of 4 hours for critical issues and 24 hours for standard issues. This supports restoration and vendor-assisted correction of EHR issues.  
**Category:** Administrative  
**Function:** Corrective  
**Asset(s) Protected:** EHR application and clinical operations dependent on the EHR  
**Source:** IT service contracts summary

### Control ID: C-014
**Control Name:** ClearView Security Guard Service  
**Description:** ClearView Security provides one guard at the MedDefense Central main entrance from Monday to Friday, 7 AM to 7 PM. This discourages unauthorized access during staffed hours, although it does not cover nights, weekends, Westside, or HQ.  
**Category:** Physical  
**Function:** Deterrent  
**Asset(s) Protected:** MedDefense Central main entrance, staff, visitors, public access areas  
**Source:** IT service contracts summary

### Control ID: C-015
**Control Name:** HID Badge Access System  
**Description:** MedDefense uses a HID Global badge/access system connected to Active Directory for some doors. This provides physical access control for selected areas.  
**Category:** Physical  
**Function:** Preventive  
**Asset(s) Protected:** Badge-controlled doors and restricted physical areas  
**Source:** IT asset list

### Control ID: C-016
**Control Name:** Parking Garage and ER Entrance Cameras  
**Description:** Cameras are installed in the parking garage and at the emergency room entrance. These cameras can support detection and post-incident review for activity in those areas, although the documentation states that there are no cameras near the server room corridor.  
**Category:** Physical  
**Function:** Detective  
**Asset(s) Protected:** Parking garage, ER entrance, physical safety and access monitoring  
**Source:** Marcus Webb's physical security notes

### Control ID: C-017
**Control Name:** Staff Security Training Records  
**Description:** Staff training records exist as part of the provided control artifacts. Security awareness training is an administrative control intended to reduce risky user behavior and improve recognition of security responsibilities.  
**Category:** Administrative  
**Function:** Preventive  
**Asset(s) Protected:** Workforce behavior, patient data, user accounts, business processes  
**Source:** Staff training records

### Control ID: C-018
**Control Name:** Fortinet Support Contract  
**Description:** MedDefense maintains Fortinet support for the FortiGate firewall. This enables vendor support for firewall issues, updates, and troubleshooting.  
**Category:** Administrative  
**Function:** Corrective  
**Asset(s) Protected:** FortiGate 100F firewall, perimeter security, VPN connectivity  
**Source:** IT service contracts summary

## Control Summary Matrix

| Category | Preventive | Detective | Corrective | Compensating | Deterrent |
|---|---|---|---|---|---|
| Technical | C-001, C-002, C-003, C-004, C-006, C-008, C-009 | C-010 | C-011, C-012 | C-005 |  |
| Administrative | C-007, C-017 |  | C-013, C-018 |  |  |
| Physical | C-015 | C-016 |  |  | C-014 |

## Observed Control Coverage Notes

The current control landscape includes technical, administrative, and physical controls, but coverage is uneven. Technical preventive controls exist at the perimeter and for some authentication functions, but the Central internal network remains flat and several systems lack strong isolation. Corrective capability exists through backups and vendor support, but the backup design is vulnerable because the NAS is local and on the same network as protected assets.

Administrative controls are limited. A password policy and some staff training records exist, but the documentation also indicates that there is no formal incident response plan, no business continuity plan, no disaster recovery plan, and no formal HIPAA Security Rule assessment.

Physical controls exist at selected locations, including the main entrance guard service, badge access system, and cameras in some public areas. However, the documentation shows major physical control gaps near IT infrastructure, including generic server room badge access, lack of camera coverage near the server room corridor, and weak Westside server closet security.


