# Structured Environment Summary

## Organization Overview

MedDefense Health Systems is a regional healthcare organization operating three sites with approximately 2,000 employees across clinical, administrative, executive, and IT functions.

### Sites

| Site | Location Type | Function | Approximate Headcount | Physical Notes |
|---|---|---|---:|---|
| MedDefense Central Hospital | Downtown acute care hospital | 350-bed hospital providing Emergency, Surgery, Cardiology, Radiology, Oncology, Pediatrics, Maternity, Pharmacy, Laboratory, and Administration services | 1,400 clinical and support staff | 6 floors plus basement mechanical/server room; underground staff garage; surface visitor lot |
| Westside Clinic | Suburban outpatient facility, 12 minutes from Central | Primary care, diagnostic imaging, blood work, minor procedures, and physical therapy | 180 staff | 2-story medical office complex; shared parking with adjacent retail plaza; has a local server closet for basic needs |
| Corporate HQ | Administrative offices in Greenfield Business Park, 15 minutes from Central | Finance, HR, Legal, Marketing, Executive Leadership, and IT | 220 staff | Leased office space on the 3rd floor of a 5-story commercial building |

### Departments Relevant to Security

The Central Hospital includes clinical and support departments: Emergency, Surgery, Cardiology, Radiology, Oncology, Pediatrics, Maternity, Pharmacy, Laboratory, and Administration. Westside Clinic supports outpatient care, diagnostic imaging, blood work, minor procedures, and physical therapy. Corporate HQ hosts Finance, HR, Legal, Marketing, Executive Leadership, and IT.

### Security-Relevant Reporting Structure

The organization is led by CEO Dr. Patricia Morales. Robert Kim is CFO, Angela Torres is COO, and David Park is General Counsel. The CISO role is vacant. James Chen is Deputy CISO and is acting as the security leader. The Security Analyst role reports to James Chen.

Sarah Park is the IT Director. Her team includes three system administrators, two network technicians, one database administrator, two helpdesk analysts including Mike Torres as lead, two desktop support technicians, and one vacant IT intern role.

James Chen and Sarah Park are peers. James has authority over security policy but not over IT operations. This creates a governance gap because security decisions may depend on IT implementation without direct operational authority.

## IT Infrastructure Identified

### Central Hospital Servers

| Asset | Type / Platform | Function | Location | Technical Details |
|---|---|---|---|---|
| ehr-srv-01 | Server / Ubuntu 20.04 LTS | EHR application server | MedDefense Central | Linux server supporting electronic health record application services |
| ehr-db-01 | Server / Ubuntu 20.04 LTS | EHR database | MedDefense Central | PostgreSQL database; Marcus noted it is reachable from the full 10.10.0.0/16 range |
| pacs-srv-01 | Server / Windows Server 2016 | PACS imaging server | MedDefense Central | Supports medical imaging workflows |
| billing-srv-01 | Server / Ubuntu 18.04 LTS | Billing and claims processing | MedDefense Central | Marcus reported repeated performance issues and stated that IT restarts it instead of resolving the underlying issue |
| ad-dc-01 | Server / Windows Server 2019 | Primary Domain Controller | MedDefense Central | Provides Active Directory authentication services |
| ad-dc-02 | Server / Windows Server 2019 | Secondary Domain Controller | MedDefense Central | Provides redundant Active Directory authentication services |
| file-srv-01 | Server / Windows Server 2016 | Department file shares | MedDefense Central | Stores shared departmental files |
| print-srv-01 | Server / Windows Server 2012 R2 | Print server | MedDefense Central | Marked unverified; Marcus noted Windows Server 2012 R2 reached end of support in October 2023 |
| backup-srv-01 | Server / Ubuntu 22.04 LTS | Backup server | MedDefense Central | Uses Veeam agent; backups go to a local NAS in the same server room, rack, and network |
| web-srv-01 | Server / Ubuntu 20.04 LTS | Public website and patient portal | Central DMZ | Internet-facing service placed in the DMZ behind the FortiGate firewall |

### Westside Clinic Servers

| Asset | Type / Platform | Function | Location | Technical Details |
|---|---|---|---|---|
| ws-srv-01 | Server / Windows Server 2016 | Local file server and scheduling | Westside Clinic | Supports local file and scheduling needs |
| Unconfirmed server | Unknown | Unknown | Westside server closet | Mike Torres mentioned another server may exist, but Marcus did not confirm it |

### Corporate HQ Servers

Corporate HQ has no documented on-premise servers. HQ staff use cloud services and connect to Central infrastructure through a site-to-site VPN.

### Network Equipment and Connectivity

| Asset / Component | Function | Location | Technical Details |
|---|---|---|---|
| Fortinet FortiGate 100F | Firewall, DMZ, and VPN termination | MedDefense Central | Connects the internet, the DMZ containing web-srv-01, Central internal network, Westside VPN, and HQ VPN |
| Cisco core switch | Core switching | MedDefense Central | Model unknown |
| Cisco access switches | Floor access switching | MedDefense Central | Two Cisco access switches per floor |
| Ubiquiti UniFi APs | Wireless access | MedDefense Central | 12 units; UniFi controller license is free |
| Guest WiFi | Guest wireless access | MedDefense Central | Separate SSID exists, but Marcus was not convinced it is properly isolated |
| Unmanaged switch | Local switching | Westside Clinic | Brand unknown |
| Netgear Nighthawk consumer router | Internet access and VPN | Westside Clinic | Provides direct ISP connectivity and site-to-site VPN to Central; Marcus noted this is unacceptable for a medical facility |
| Building-managed network | Network and internet service | Corporate HQ | Managed by Greenfield Building Management; MedDefense has its own VLAN |
| Site-to-site VPN | Inter-site connectivity | Westside to Central | IPSec VPN from Westside through the Netgear router to the FortiGate |
| Site-to-site VPN | Inter-site connectivity | HQ to Central | VPN through building-managed network to the FortiGate |
| Central network | Internal network | MedDefense Central | Documented as 10.10.0.0/16 with no VLANs configured; servers, workstations, thin clients, access points, and medical devices share the same flat network |

### Endpoint Categories

| Endpoint Category | Location | Approximate Count | Technical Details |
|---|---|---:|---|
| Windows 10 workstations | MedDefense Central | 320 | Count comes from an Active Directory report that was 8 months old |
| Thin clients | Central clinical areas | 60 | Used in clinical areas |
| Windows 10 workstations | Westside Clinic | 45 | Count comes from incomplete endpoint records |
| Windows 10/11 workstations | Corporate HQ | 120 | Used by administrative and business staff |
| Laptops | Corporate HQ | 30 | Remote-capable laptops |
| iPads | Used by physicians during rounds | 25 | Management status is unclear |

### Medical Devices and IoT

| Asset | Function | Location | Technical Details |
|---|---|---|---|
| Philips IntelliVue patient monitors | Connected patient monitoring | MedDefense Central | Approximately 80 units; on the same network as other systems according to Marcus |
| BD Alaris infusion pumps | Network-connected dosage updates | MedDefense Central | Approximately 120 units; Marcus noted they are reachable if someone gets onto the network |
| Siemens MAGNETOM MRI scanner | MRI imaging | Radiology department, Central | Marcus marked it critical and noted it runs Windows XP |
| GE Revolution CT scanner | CT imaging | MedDefense Central | Operating system unknown |
| IP-based nurse call system | Nurse call communication | MedDefense Central | Integrated with the phone system |
| HID Global badge/access system | Physical access control | MedDefense facilities | Connected to Active Directory for some doors |

### Cloud, Security, and Service Contracts

| Vendor / Service | Function | Annual Cost | Renewal / Notes |
|---|---|---:|---|
| Sophos Endpoint Protection | Endpoint security | $18,000 | Renews in January; coverage and update status are not fully confirmed |
| Veeam Backup Software | Backup software | $8,500 | Renews in March; backups run nightly to a local NAS |
| Fortinet FortiGate Support | Firewall support | $4,200 | Renews in June |
| Microsoft O365 E3 | Email, productivity, and collaboration | $432,000 | Organization-wide; renews in September |
| Ubiquiti UniFi controller | Wireless controller | $0 | Free license |
| Greenfield Building Management | HQ network and internet | Included in lease | HQ network is landlord-managed; MedDefense has its own VLAN |
| ClearView Security | Guard service at Central | $96,000 | One guard at main entrance, Monday-Friday 7 AM-7 PM; no weekend/night coverage and no guard at Westside or HQ |
| MedTech Solutions | EHR maintenance | $145,000 | Includes software updates, not hardware; SLA is 4 hours for critical issues and 24 hours for standard issues |

## Data and Services

### Data Types Handled

| Data Type | Description | Users / Stakeholders | Related Systems or Services |
|---|---|---|---|
| Electronic health record data | Patient clinical records used for care delivery | Physicians, nurses, clinical departments, support staff | ehr-srv-01, ehr-db-01 |
| Medical imaging data | Imaging records from PACS, MRI, CT, X-ray, and ultrasound services | Radiology, physicians, clinical teams | pacs-srv-01, Siemens MAGNETOM MRI, GE Revolution CT scanner, Westside imaging services |
| Billing and claims data | Data used for billing, claims processing, and revenue cycle operations | Finance, billing staff, administration | billing-srv-01 |
| Department file share data | Shared operational documents for departments | Clinical and administrative departments | file-srv-01, ws-srv-01 |
| HR data | Employee and staffing information | HR, leadership, administration | Corporate HQ systems and Microsoft O365 |
| Finance data | Financial and administrative business records | Finance, CFO, executive leadership | Corporate HQ systems and Microsoft O365 |
| Legal and compliance data | Legal records, compliance claims, and governance information | General Counsel, leadership, security | Legal department systems and Microsoft O365 |
| Identity and access data | User identities, authentication, and access relationships | All employees, IT, security | ad-dc-01, ad-dc-02, HID Global badge system |
| Patient portal data | Patient-facing portal information | Patients, clinical staff, support staff | web-srv-01 |
| Backup data | Copies of business and system data for recovery | IT, security, business continuity stakeholders | backup-srv-01, local NAS, Veeam |
| Cloud productivity data | Email, documents, and collaboration content | Organization-wide staff | Microsoft O365 E3 |

### Critical IT-Dependent Services

| Service | Why It Is Critical | Users / Stakeholders | Dependent Infrastructure |
|---|---|---|---|
| Electronic Health Record service | Supports patient care documentation and access to clinical information | Clinical departments, physicians, nurses, patients indirectly | ehr-srv-01, ehr-db-01, Active Directory, Central network |
| Billing and claims processing | Supports revenue cycle and claims submission; disruption affects payment and administration | Billing staff, Finance, Administration, leadership | billing-srv-01, Active Directory, Central network |
| PACS and medical imaging | Enables access to diagnostic imaging used for clinical decisions | Radiology, physicians, clinical departments | pacs-srv-01, MRI, CT scanner, imaging devices, Central network |
| Authentication and directory services | Provides identity and access for users and systems | All employees, IT, security | ad-dc-01, ad-dc-02 |
| Department file services | Supports shared business and clinical files | Departments across Central and Westside | file-srv-01, ws-srv-01 |
| Backup and recovery | Supports recovery from data loss, system failure, or ransomware | IT, security, business continuity stakeholders | backup-srv-01, local NAS, Veeam |
| Public website and patient portal | Provides public and patient-facing access | Patients, public users, support staff | web-srv-01, DMZ, FortiGate |
| Site-to-site connectivity | Allows Westside and HQ users to access Central-hosted services | Westside staff, HQ staff, IT | FortiGate, Netgear Nighthawk router, Greenfield network, VPNs |
| Microsoft O365 | Provides email, productivity, and collaboration across the organization | Organization-wide staff | Microsoft O365 E3 cloud service |
| Medical device connectivity | Supports patient monitoring, dosage updates, and clinical workflows | Clinical staff and patients | Philips monitors, BD Alaris pumps, Central network |
| Nurse call system | Supports patient-to-clinical communication | Patients, nurses, clinical staff | IP-based nurse call system, phone system, network |
| Physical access control | Controls access to some physical areas | Staff, facilities, IT, security | HID Global badge system, Active Directory integration |

## Known Unknowns

| Missing, Incomplete, or Contradictory Information | Why It Matters |
|---|---|
| The ServiceDesk asset list is explicitly partial and incomplete | A reliable asset inventory is required to understand what must be protected |
| Some records were added by different people over time, including the previous IT manager, Marcus, and Sarah's team | The inventory may contain outdated, inconsistent, or duplicate entries |
| Assets marked unverified have not been physically confirmed in over a year | These assets may no longer exist or may be unmanaged and insecure |
| print-srv-01 is marked unverified | Its actual existence, configuration, support status, and exposure need confirmation |
| Mike Torres mentioned a possible additional server at Westside, but Marcus never confirmed it | An unknown server could store sensitive data or provide an unmanaged attack path |
| The model of the Central Cisco core switch is unknown | Support status, security capabilities, and configuration risks cannot be fully assessed |
| The Westside unmanaged switch brand is unknown | The organization cannot confirm management capability, security features, or support status |
| Westside WiFi is unknown | Wireless exposure and separation from internal systems cannot be assessed |
| Endpoint counts are based on an Active Directory report from 8 months ago | The current number of workstations, laptops, thin clients, and stale devices may be inaccurate |
| No one has a complete endpoint count | Endpoint protection, patching, monitoring, and incident response coverage cannot be validated |
| iPad management status is unclear | Unmanaged mobile devices used by physicians could expose credentials or patient information |
| The GE Revolution CT scanner operating system is unknown | Unsupported or vulnerable medical device software may exist |
| Marcus noted a separate file for the MRI scanner, but that file is not included in the packet | The full risk details for a critical Windows XP medical device are missing |
| Guest WiFi isolation at Central has not been verified | Guest users may be able to reach internal clinical or server networks if isolation is misconfigured |
| HQ VPN appears properly configured, but ACLs were not audited | HQ users or compromised HQ systems may have broader access to Central infrastructure than intended |
| The network diagram is described as simplified and incomplete | Real topology may include undocumented network paths, devices, or dependencies |
| The real topology is stated to be messier than the draft diagram | Risk analysis based only on the draft may miss actual exposure |
| Central has a flat 10.10.0.0/16 network with no VLANs, but future segmentation is only described as planned | There is no confirmed segmentation protecting servers, workstations, and medical devices from each other |
| PostgreSQL on ehr-db-01 is reachable from the full 10.10.0.0/16 range | Database exposure may be broader than needed, but the exact access controls are not documented |
| Sophos coverage and update status are not confirmed on all endpoints | Endpoint protection may be inconsistent across the environment |
| Cloud service inventory is incomplete | Departments may be using unapproved or unmanaged cloud services outside security visibility |
| HIPAA Security Rule compliance has never been formally assessed | Legal claims of compliance are not supported by evidence in the packet |
| No formal incident response plan exists | Future incidents may be handled inconsistently and with delayed containment |
| The January ransomware incident on billing-srv-01 was handled ad hoc | Lessons learned, root cause, and remediation status are not documented |
| No business continuity plan exists | The organization lacks documented procedures to continue operations during disruption |
| No disaster recovery plan exists | Recovery priorities, recovery time objectives, and recovery procedures are unknown |
| Central UPS capacity is approximately 20 minutes, but there is no procedure beyond that window | Clinical operations may be disrupted during extended power loss |
| Backups are stored on a local NAS in the same room, rack, and network as production systems | Ransomware or physical damage could affect both production and backup copies |
| Offsite or cloud backup was proposed but budget was denied | There is no confirmed recoverable backup copy outside the local environment |
| Server room badge access uses the same generic badge everyone gets | Physical access to critical infrastructure may not be restricted to authorized IT staff |
| There are no cameras near the server room corridor | Unauthorized physical access to IT infrastructure may not be detected or investigated |
| Westside server closet does not lock | Local IT infrastructure at Westside is physically exposed |
| ClearView guard service covers only Central main entrance Monday-Friday 7 AM-7 PM | Physical security coverage is limited and does not cover nights, weekends, Westside, or HQ |
| Radiology uses a shared PACS login | User accountability and access control are weakened |
| MFA exists only on James Chen's personal account | Credential compromise could provide unauthorized access to systems and cloud services |
| SSH password authentication remains enabled on Linux servers | Linux servers remain exposed to password-based authentication attacks |
| Formal vulnerability assessment of all servers has not been completed | Known and unknown technical weaknesses remain unvalidated |
| Threat landscape analysis was started but not completed | Healthcare-specific threats are not fully mapped to MedDefense's environment |
| Medical IoT devices are on the same network as other systems | Patient monitors and infusion pumps may be reachable from compromised workstations or other internal systems |
| James has security policy authority but no authority over IT operations | Security recommendations may not be implemented without IT cooperation or executive support |

