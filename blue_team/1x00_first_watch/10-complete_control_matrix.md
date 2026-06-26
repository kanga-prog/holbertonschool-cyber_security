# Complete Control Matrix

## Purpose

This document consolidates all security controls identified throughout the MedDefense Health Systems assessment. It integrates the original control inventory, physical security observations, compensating controls proposed for the legacy MRI workstation, incident-related controls, data protection findings, and the asset criticality assessment.

The matrix is intended to serve as the authoritative reference for answering the Board-level question: **What security controls does MedDefense currently have, how effective are they, and which critical assets do they protect?**

## Effectiveness Rating

| Rating | Definition |
|---|---|
| Strong | Properly configured, covering the right scope, and actively maintained. |
| Adequate | In place, but with limitations such as incomplete scope, unverified configuration, or dependency on other controls. |
| Weak | Exists on paper or in limited form, but is poorly implemented, easily bypassed, or does not adequately cover the relevant risk. |

## Part 1: Updated Control Registry

| Control ID | Control Name | Category | Function | Asset(s) Protected | Effectiveness | Evidence/Source |
|---|---|---|---|---|---|---|
| C-001 | FortiGate 100F Perimeter Firewall | Technical | Preventive | Central Internet edge, DMZ, VPN termination, internal network boundary | Adequate | Onboarding packet, service contracts, network diagram, network scan |
| C-002 | DMZ Placement for `web-srv-01` | Technical | Preventive | Public website, patient portal, internal server network | Weak | Network diagram places `web-srv-01` in DMZ, but the scan lists it in the Central server subnet, requiring validation |
| C-003 | Westside IPSec VPN | Technical | Preventive | Westside Clinic connectivity to Central | Weak | Network diagram and scan confirm IPSec VPN, but it runs through a consumer Netgear router with no proper firewall |
| C-004 | Corporate HQ Site-to-Site VPN | Technical | Preventive | Corporate HQ connectivity to Central infrastructure | Adequate | Onboarding packet and scan confirm HQ site-to-site VPN; ACLs have not been audited |
| C-005 | Corporate HQ Dedicated VLAN | Technical | Compensating | HQ workstations, laptops, and traffic in the landlord-managed building network | Adequate | Onboarding packet and service contract indicate MedDefense has its own VLAN in the building-managed network |
| C-006 | Active Directory Domain Authentication | Technical | Preventive | User accounts, workstations, servers, applications, some physical badge integrations | Adequate | `ad-dc-01` and `ad-dc-02` documented and confirmed by scan |
| C-007 | Password Policy | Administrative | Preventive | User accounts and domain-authenticated services | Weak | Marcus documented 8-character minimum, 90-day rotation, and complexity; no MFA is broadly deployed |
| C-008 | Limited MFA for Deputy CISO Account | Technical | Preventive | James Chen's account | Weak | Marcus notes MFA exists only on James Chen's personal account |
| C-009 | SSH Key-Only Access on `ehr-srv-01` | Technical | Preventive | `ehr-srv-01` | Adequate | Marcus notes SSH hardening was completed only for `ehr-srv-01` |
| C-010 | Sophos Endpoint Protection | Technical | Detective | Workstations, laptops, and managed endpoints | Weak | Sophos contract exists, but Marcus could not confirm endpoint coverage or currency |
| C-011 | Veeam Nightly Backup Jobs | Technical | Corrective | Servers, applications, and recoverable data | Weak | Veeam backups exist, but prior ransomware recovery used a backup that was three weeks old |
| C-012 | Local NAS Backup Repository (`NAS-01`) | Technical | Corrective | Backup copies of server and application data | Weak | NAS exists, but is in the same rack, same room, and same network as the backup server; scan shows management interface exposed internally |
| C-013 | MedTech Solutions EHR Maintenance Contract | Administrative | Corrective | EHR application and clinical operations dependent on EHR | Adequate | Service contract provides EHR maintenance and SLA response commitments |
| C-014 | Fortinet Support Contract | Administrative | Corrective | FortiGate firewall, VPN services, perimeter security | Adequate | Service contract identifies Fortinet support renewal |
| C-015 | Microsoft O365 E3 Service Contract | Technical | Preventive | Email, collaboration, and cloud productivity data | Adequate | O365 E3 is contracted organization-wide, but MFA and full cloud inventory are not confirmed |
| C-016 | Ubiquiti UniFi Wireless Infrastructure | Technical | Preventive | Central wireless access infrastructure | Weak | 12 UniFi APs are documented and scan-confirmed, but guest isolation is unverified |
| C-017 | Central Guest WiFi SSID | Technical | Preventive | Guest wireless users and internal wireless separation | Weak | Marcus confirmed guest WiFi exists but was not convinced it is isolated |
| C-018 | HID Badge Access System | Physical | Preventive | Selected physical doors and restricted areas | Weak | HID system exists and scan identifies badge readers, but server room access uses generic badges |
| C-019 | ClearView Security Guard Service | Physical | Deterrent | Central main entrance and public access area | Weak | Service contract provides one guard Monday-Friday 7AM-7PM only, with no night/weekend coverage and no Westside/HQ guard |
| C-020 | Parking Garage and ER Entrance Cameras | Physical | Detective | Parking garage and ER entrance | Weak | Cameras exist only in limited areas; no camera covers the server room corridor |
| C-021 | Central UPS Short-Term Power Support | Physical | Corrective | Central operations during short power interruptions | Weak | Marcus notes UPS covers approximately 20 minutes; no documented procedure exists beyond that |
| C-022 | Staff Security Training Records | Administrative | Preventive | Workforce behavior, user handling of sensitive data, security awareness | Weak | Training records are referenced, but scope, frequency, completion, and effectiveness are not evidenced |
| C-023 | EHR Vendor Critical Response SLA | Administrative | Corrective | EHR service availability and vendor-assisted restoration | Adequate | MedTech Solutions SLA provides 4-hour response for critical issues |
| C-024 | Website Backup Restoration | Technical | Corrective | Public website content and availability | Adequate | April website defacement was restored from backup within 2 hours |
| C-025 | MRI Dedicated Network Segmentation | Technical | Compensating | MRI workstation, PACS, Radiology systems, Central network | Strong | Proposed compensating control from Task 6 to isolate the Windows XP MRI workstation without modifying the certified OS |
| C-026 | MRI-to-PACS Firewall Allowlist | Technical | Preventive | MRI workstation and PACS communication path | Strong | Proposed compensating control from Task 6 allowing only required MRI-to-PACS traffic |
| C-027 | Passive MRI Network Monitoring | Technical | Detective | MRI workstation traffic and Radiology network behavior | Adequate | Proposed detective compensating control from Task 6 |
| C-028 | Radiology Legacy Device Operating Procedure | Administrative | Preventive | MRI workstation operations and Radiology staff behavior | Adequate | Proposed administrative control from Task 6 |
| C-029 | Restricted Physical Access to MRI Control Workstation | Physical | Preventive | MRI console, workstation, and Radiology control area | Adequate | Proposed physical control from Task 6 |
| C-030 | MRI Risk Exception and Periodic Review | Administrative | Compensating | MRI workstation risk governance and executive visibility | Adequate | Proposed administrative compensating control from Task 6 |
| C-031 | Active Directory Integration for Some Badge Readers | Technical | Preventive | Badge-controlled doors and identity-linked physical access | Weak | Badge/access system is connected to AD for some doors, but scope is incomplete |
| C-032 | Site Service Contracts and Vendor Support Tracking | Administrative | Corrective | Fortinet, Veeam, Sophos, O365, EHR support continuity | Adequate | Finance service contract summary documents renewals and support relationships |

## Part 2: Updated Control Summary Matrix

Average effectiveness is shown as a qualitative result based on the controls in each cell. Where a cell contains only proposed controls, this is marked in the notes by the presence of Task 6 controls.

| Category | Preventive | Detective | Corrective | Compensating | Deterrent |
|---|---|---|---|---|---|
| Technical | 12 controls / Average: Adequate | 2 controls / Average: Weak-to-Adequate | 4 controls / Average: Weak-to-Adequate | 2 controls / Average: Strong-to-Adequate | 0 controls / None |
| Administrative | 3 controls / Average: Weak-to-Adequate | 0 controls / None | 5 controls / Average: Adequate | 1 control / Average: Adequate | 0 controls / None |
| Physical | 3 controls / Average: Weak-to-Adequate | 1 control / Average: Weak | 1 control / Average: Weak | 0 controls / None | 1 control / Average: Weak |

### Matrix Interpretation

MedDefense has more preventive and corrective controls than detective controls. The strongest controls are either perimeter-oriented, vendor-supported, or proposed compensating controls for the MRI workstation. The weakest areas are internal detection, physical monitoring near critical infrastructure, backup resilience, and controls that exist only in a limited or unverified scope.

## Part 3: Control Coverage Map for Top 5 Critical Assets

| Critical Asset | Preventive | Detective | Corrective | Compensating | Coverage Assessment |
|---|---|---|---|---|---|
| EHR System (`ehr-srv-01`, `ehr-db-01`) | C-001, C-006, C-007, C-009, C-015 | C-010 | C-011, C-012, C-013, C-023 | None identified | Under-Protected |
| Network Core and Site Connectivity | C-001, C-003, C-004, C-005, C-016, C-017, C-031 | C-020 | C-014, C-021, C-032 | C-005 | Partially Protected |
| Medical IoT and Nurse Call Systems | C-001, C-006 where authentication applies indirectly | None identified | C-011 and C-012 where backups apply to supporting systems | None broadly implemented | Under-Protected |
| PACS, Imaging, and Radiology Systems | C-001, C-006, C-007, C-026, C-028, C-029 | C-010, C-027 | C-011, C-012 | C-025, C-030 | Partially Protected |
| Identity and Access Infrastructure (`ad-dc-01`, `ad-dc-02`, badge integration) | C-006, C-007, C-008, C-018, C-031 | C-010, C-020 for limited physical areas | C-011, C-012 | None identified | Under-Protected |

### Coverage Assessment Details

#### EHR System

The EHR system has authentication, backups, vendor maintenance, and limited SSH hardening on `ehr-srv-01`, but it remains under-protected because `ehr-db-01` is reachable from the entire internal network and there is no strong internal network detection. A system with Critical confidentiality, integrity, and availability requirements should have restricted database access, MFA, segmentation, centralized logging, tested recovery, and monitored administrative access.

#### Network Core and Site Connectivity

The network core is partially protected because MedDefense has a FortiGate firewall, VPN connectivity, core switching, wireless infrastructure, and vendor support. However, the scan confirmed that all internal subnets are reachable from HQ without access restrictions, meaning the network core does not enforce meaningful internal segmentation. This makes the network dependent on perimeter prevention while leaving weak internal containment and detection.

#### Medical IoT and Nurse Call Systems

Medical IoT is under-protected. The scan confirmed that Philips monitors, BD Alaris pumps, and other medical devices expose HTTP/HTTPS management interfaces to the entire internal network, and the BD Alaris firmware has known CVEs with network isolation recommended but not implemented. Because these devices are linked to patient monitoring and clinical workflows, the lack of segmentation, monitoring, and compensating controls creates a critical gap.

#### PACS, Imaging, and Radiology Systems

PACS and Radiology systems are partially protected only if the proposed MRI compensating controls are implemented. Current controls include domain authentication and backup coverage, but the MRI control workstation remains end-of-life and on the same network as hospital workstations. The proposed controls, especially segmentation, MRI-to-PACS allowlisting, and passive monitoring, significantly improve the posture but do not eliminate the residual risk of a certified legacy device.

#### Identity and Access Infrastructure

Identity infrastructure is under-protected because Active Directory exists, but MFA is limited to one account and shared accounts are still used in Radiology. The badge system also integrates with AD for some doors, but generic badge access to the server room weakens physical identity assurance. A compromise of Active Directory would affect servers, endpoints, clinical applications, and some physical access controls, making stronger preventive and detective coverage necessary.

## Executive Summary

MedDefense has several important controls in place, including a perimeter firewall, site-to-site VPNs, Active Directory, endpoint protection, backups, vendor maintenance contracts, badge access, and limited physical security. However, the control landscape is uneven and heavily prevention-oriented. The most serious gaps are weak internal segmentation, limited detective controls, incomplete MFA, weak physical monitoring around IT infrastructure, and fragile backup recovery architecture. For the Board, the key message is that MedDefense has security controls, but they do not yet provide reliable defense-in-depth for the most critical clinical and patient-data systems.


