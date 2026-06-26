# Structured Environment Summary

## 1. Organization Overview

### Organization

MedDefense Health Systems is a regional healthcare organization operating three documented sites: MedDefense Central Hospital, Westside Clinic, and Corporate HQ. The organization has approximately 2,000 employees across clinical, administrative, executive, legal, finance, HR, marketing, and IT functions.

The current security function is immature. A dedicated security program was recently established, but the CISO role is vacant. James Chen, Deputy CISO, is acting as the security leader in practice. The security analyst role was previously held by Marcus Webb and is now being replaced.

### Sites

| Site Name | Location Type | Primary Function | Approximate Headcount | Notes |
|---|---|---:|---:|---|
| MedDefense Central Hospital | Downtown acute care hospital | Main clinical facility with Emergency, Surgery, Cardiology, Radiology, Oncology, Pediatrics, Maternity, Pharmacy, Laboratory, and Administration departments | 1,400 | 350-bed facility with 6 floors and a basement level containing mechanical/server room areas. Underground staff garage and visitor surface lot are present. |
| Westside Clinic | Suburban outpatient facility | Primary care, diagnostic imaging, blood work, minor procedures, and physical therapy | 180 | Located approximately 12 minutes from Central. Two-story medical office complex with shared parking. Shares some IT services with Central and has a local server closet for basic needs. |
| Corporate HQ | Leased administrative office space in Greenfield Business Park | Finance, HR, Legal, Marketing, Executive Leadership, and IT | 220 | Located approximately 15 minutes from Central on the 3rd floor of a 5-story commercial building. IT department is located here. HQ uses cloud services and connects to Central through a site-to-site VPN. |

### Security-Relevant Departments and Reporting Structure

| Role / Department | Person / Group | Security Relevance |
|---|---|---|
| CEO | Dr. Patricia Morales | Executive authority. James Chen reports directly to the CEO in practice because the CISO position is vacant. |
| CFO | Robert Kim | Responsible for financial leadership. Finance also provided the IT service contracts summary. |
| COO | Angela Torres | Oversees clinical directors by department. Clinical operations depend heavily on IT-supported systems. |
| General Counsel | David Park | Responsible for legal oversight. Legal claims HIPAA compliance, but supporting evidence is not documented. |
| CISO | Vacant | Formal security leadership position is unfilled. |
| Deputy CISO | James Chen | Acting security leader. Has authority over security policy but not over IT operations. |
| Security Analyst | New analyst replacing Marcus Webb | Responsible for assisting with security assessment, documentation, and posture improvement. |
| IT Director | Sarah Park | Leads IT operations. Peer of James Chen, not subordinate to him. This creates friction because security policy and IT operations are separated. |
| IT Staff | 3 system administrators, 2 network technicians, 1 database administrator, 2 helpdesk analysts including Mike Torres, 2 desktop support technicians, and 1 vacant IT intern role | Responsible for infrastructure support, operations, endpoints, databases, networking, and helpdesk activities. |

### Governance and Operational Context

Security responsibilities were previously handled informally by IT. The documentation indicates that MedDefense does not have a complete asset inventory, has not formally assessed HIPAA Security Rule compliance, and lacks formal incident response, business continuity, and disaster recovery plans. Security and IT responsibilities appear divided between James Chen and Sarah Park, with James responsible for policy and Sarah responsible for IT operations.

## 2. IT Infrastructure Identified

### Central Hospital Servers

| Asset Name / Type | Function | Location | Technical Details / Notes |
|---|---|---|---|
| ehr-srv-01 | EHR application server | MedDefense Central | Ubuntu 20.04 LTS. SSH password authentication was reportedly migrated to key-only on this server. |
| ehr-db-01 | EHR database server | MedDefense Central | Ubuntu 20.04 LTS. PostgreSQL database. Marcus noted that PostgreSQL is accessible from the entire 10.10.0.0/16 range and should be restricted to ehr-srv-01 only. |
| pacs-srv-01 | PACS imaging server | MedDefense Central | Windows Server 2016. Supports imaging services. Radiology reportedly uses a shared PACS workstation login. |
| billing-srv-01 | Billing and claims processing server | MedDefense Central | Ubuntu 18.04 LTS. Has repeated performance issues and is restarted by IT. Marcus left a note stating something is wrong. A prior ransomware incident affected this server in January. |
| ad-dc-01 | Primary domain controller | MedDefense Central | Windows Server 2019. Supports Active Directory authentication. |
| ad-dc-02 | Secondary domain controller | MedDefense Central | Windows Server 2019. Supports Active Directory authentication. |
| file-srv-01 | Department file shares | MedDefense Central | Windows Server 2016. Provides departmental file sharing. |
| print-srv-01 | Print server | MedDefense Central | Windows Server 2012 R2. Marked unverified in the asset list. Marcus noted that Windows Server 2012 R2 reached end of support in October 2023. |
| backup-srv-01 | Backup server | MedDefense Central | Ubuntu 22.04 LTS. Runs Veeam agent. Performs nightly backups to a local NAS located in the same server room, on the same network, and in the same rack. |
| web-srv-01 | Public website and patient portal | MedDefense Central DMZ | Ubuntu 20.04 LTS. Shown in the DMZ behind the FortiGate firewall. |

### Westside Clinic Servers

| Asset Name / Type | Function | Location | Technical Details / Notes |
|---|---|---|---|
| ws-srv-01 | Local file server and scheduling server | Westside Clinic | Windows Server 2016. Supports local file and scheduling needs at Westside. |
| Possible additional server | Unknown | Westside Clinic server closet | Marcus noted that Mike Torres mentioned another possible server, but Marcus never confirmed it. |

### Corporate HQ Systems

| Asset Name / Type | Function | Location | Technical Details / Notes |
|---|---|---|---|
| Cloud services | Administrative and productivity services | Corporate HQ / organization-wide | HQ has no on-premise servers. Staff use cloud services. Microsoft O365 E3 is licensed organization-wide. |
| HQ site-to-site VPN | Connectivity to Central infrastructure | Corporate HQ to Central | Runs through a building-managed network. MedDefense has its own VLAN. Marcus noted that the VPN appears properly configured but ACLs have not been audited. |

### Network Infrastructure

| Asset Name / Type | Function | Location | Technical Details / Notes |
|---|---|---|---|
| Fortinet FortiGate 100F firewall | Internet edge firewall and VPN termination | MedDefense Central | Supports Central internet edge and VPN connections from Westside and HQ. Fortinet support contract is active with renewal in June. |
| Cisco core switch | Core switching | MedDefense Central | Model unknown. Connected behind the FortiGate. |
| Cisco access switches | Floor access switching | MedDefense Central | Two Cisco access switches per floor are documented. |
| Central network | Internal LAN | MedDefense Central | Documented as a flat 10.10.0.0/16 network with no VLANs configured. Servers, workstations, thin clients, access points, and medical devices appear to share the same broad network. |
| Ubiquiti UniFi access points | Wireless access | MedDefense Central | 12 units documented. Guest WiFi exists as a separate SSID, but isolation is not verified. |
| DMZ | Public-facing service segment | MedDefense Central | Contains web-srv-01. Further DMZ controls are not described. |
| Netgear Nighthawk consumer router | Internet access and VPN for Westside | Westside Clinic | Marcus reported that Westside has no firewall and that the site-to-site VPN to Central runs on this consumer-grade router. |
| Unmanaged switch | Local network switching | Westside Clinic | One unmanaged switch documented. Brand unknown. |
| Westside network | Local clinic network | Westside Clinic | Technical segmentation, firewalling, and wireless details are not documented. |
| Building-managed network | Network and internet service | Corporate HQ | Managed by Greenfield Building Management. MedDefense has its own VLAN. |
| HQ site-to-site VPN | Connectivity between HQ and Central | Corporate HQ to Central | Connects to the FortiGate at Central. ACLs have not been audited. |
| IPSec VPN | Connectivity between Westside and Central | Westside Clinic to Central | Runs from the Netgear consumer router to the FortiGate at Central. |

### Endpoints

| Endpoint Category | Function | Location | Technical Details / Notes |
|---|---|---|---|
| Windows 10 workstations | General clinical and administrative endpoint use | MedDefense Central | Approximately 320 devices, based on an AD report from 8 months ago. |
| Thin clients | Clinical area access terminals | MedDefense Central | Approximately 60 thin clients in clinical areas. |
| Windows 10 workstations | Clinic endpoint use | Westside Clinic | Approximately 45 devices, based on an AD report from 8 months ago. |
| Windows 10/11 workstations | Administrative endpoint use | Corporate HQ | Approximately 120 devices. |
| Laptops | Remote-capable work | Corporate HQ | Approximately 30 laptops. Remote capability is noted, but remote access controls are not detailed. |
| iPads | Physician rounds | Primarily clinical areas | Approximately 25 iPads. Management status is unclear. |
| PACS workstation | Radiology imaging workflow | Radiology / Central | Shared account reportedly used: raduser / radiology1. |

### Medical Devices and Facility Technology

| Asset Name / Type | Function | Location | Technical Details / Notes |
|---|---|---|---|
| Philips IntelliVue patient monitors | Patient monitoring | MedDefense Central | Approximately 80 connected units. Marcus noted they are on the same network as other systems. |
| BD Alaris infusion pumps | Medication infusion and dosage updates | MedDefense Central | Approximately 120 network-connected units. Marcus noted they are reachable from the general network. |
| Siemens MAGNETOM MRI scanner | MRI imaging | Radiology, MedDefense Central | One unit. Marcus noted it is critical and runs Windows XP. A referenced separate file is not included in the packet. |
| GE Revolution CT scanner | CT imaging | MedDefense Central | One unit. Operating system is unknown. |
| IP-based nurse call system | Nurse call and clinical communications | MedDefense Central | Integrated with the phone system. |
| Phone system | Communications and nurse call integration | MedDefense Central / organization | Specific platform and location are not documented. |
| HID Global badge/access system | Physical access control | Organization / some doors | Connected to Active Directory for some doors. Exact door coverage is not documented. |
| Security cameras | Physical monitoring | Central parking garage and ER entrance | Cameras exist in some areas, but Marcus noted no cameras in the server room corridor. |
| Guard service | Physical deterrence and access support | Central main entrance | ClearView Security provides one guard Monday to Friday, 7 AM to 7 PM. No weekend/night guard coverage and no guard at Westside or HQ. |

### Security and IT Services

| Service / Tool | Function | Scope | Technical Details / Notes |
|---|---|---|---|
| Sophos Endpoint Protection | Endpoint security | Organization endpoints | Annual cost $18,000. Marcus did not know whether it is current on all machines. |
| Veeam Backup Software | Backup software | Central backup infrastructure | Annual cost $8,500. Nightly backups go to a local NAS. |
| Microsoft O365 E3 | Cloud productivity and collaboration | Organization-wide | Annual cost $432,000. O365 is the main cloud service, but other departmental cloud services may exist. |
| MedTech Solutions EHR maintenance | EHR support and software updates | EHR environment | Annual cost $145,000. Includes software updates, not hardware. SLA is 4-hour response for critical issues and 24-hour response for standard issues. |
| Ubiquiti UniFi controller | Wireless management | Central WiFi | License cost listed as free. |
| Greenfield Building Management network/internet | HQ network and internet service | Corporate HQ | Included in lease. Building manages HQ network/internet. |

## 3. Data and Services

### Data Types Handled

| Data Type | Where It Appears / Likely Associated Systems | Users / Stakeholders | Sensitivity / Business Relevance |
|---|---|---|---|
| Electronic health record data | ehr-srv-01 and ehr-db-01 | Clinicians, clinical support staff, possibly administrative staff | Critical patient care data. Requires confidentiality, integrity, and availability. |
| Protected health information | EHR, patient portal, clinical systems, imaging systems, billing systems | Clinical, administrative, billing, and patient-facing users | Healthcare data subject to HIPAA Security Rule expectations. |
| Medical imaging data | pacs-srv-01, MRI scanner, CT scanner, diagnostic imaging services | Radiology, physicians, clinical departments | Critical for diagnosis and treatment. Integrity and availability are highly important. |
| Billing and claims data | billing-srv-01 | Billing, finance, administration, insurers or claims workflows | Critical to revenue cycle operations. Disruption can delay claims processing and payment. |
| Patient portal data | web-srv-01 | Patients, clinical or administrative staff managing the portal | Public-facing access to patient-related services. Confidentiality and availability are important. |
| Department file share data | file-srv-01 and ws-srv-01 | Departments across Central and Westside | May include internal, administrative, clinical, or operational data. Exact content is not documented. |
| Scheduling data | ws-srv-01 | Westside Clinic staff and patients indirectly | Supports clinic operations and appointment management. |
| Authentication and identity data | ad-dc-01, ad-dc-02, O365, HID badge system | All employees, IT, security, some physical access workflows | Critical for logical and some physical access control. |
| HR data | Corporate HQ HR department, O365/cloud services | HR and leadership | Sensitive employee information. Exact storage locations are not documented. |
| Financial data | Corporate HQ Finance department, billing systems, O365/cloud services | Finance, CFO, administrative staff | Sensitive business and revenue data. |
| Legal and compliance data | General Counsel, Legal department, O365/cloud services | Legal and leadership | Sensitive business and regulatory data. |
| Endpoint and security telemetry | Sophos, logs, domain controllers, endpoints | IT and security | Needed for monitoring, incident response, and investigations. Completeness is unknown. |
| Backup data | backup-srv-01 and local NAS | IT and recovery stakeholders | Contains copies of critical systems and data. Current design exposes backups to the same physical and network risks as production systems. |
| Physical access data | HID Global badge system | Security, facilities, IT, leadership | Used for access control and possibly audit trails. Door coverage and monitoring are unclear. |

### Critical IT-Dependent Services

| Service | Description | Primary Users / Stakeholders | Dependent Infrastructure |
|---|---|---|---|
| Electronic Health Record service | Core clinical record service supporting patient care | Clinicians, clinical support, administration | ehr-srv-01, ehr-db-01, AD, Central network, endpoints, thin clients, MedTech Solutions support |
| Medical imaging and PACS | Imaging storage and access for radiology and clinical care | Radiology, physicians, clinical departments | pacs-srv-01, MRI scanner, CT scanner, radiology workstations, Central network |
| Billing and claims processing | Supports medical billing and revenue cycle operations | Billing, Finance, Administration | billing-srv-01, AD, Central network, possibly O365 and file shares |
| Public website and patient portal | Provides public-facing website and patient portal access | Patients, public users, administrative or clinical support | web-srv-01, DMZ, FortiGate, internet connectivity |
| Department file sharing | Provides shared files for departments | Central and Westside departments | file-srv-01, ws-srv-01, AD, network connectivity |
| Clinic scheduling | Supports Westside scheduling operations | Westside Clinic staff and patients indirectly | ws-srv-01, Westside local network, VPN to Central as applicable |
| Identity and authentication | Provides domain authentication and access control | All staff and IT-supported systems | ad-dc-01, ad-dc-02, O365, AD-integrated systems, network infrastructure |
| Backup and recovery | Provides nightly backups for recovery | IT, security, business continuity stakeholders | backup-srv-01, Veeam, local NAS, server room, Central network |
| Endpoint computing | Supports clinical, administrative, and remote work | Staff at Central, Westside, and HQ | Workstations, laptops, thin clients, iPads, Sophos, AD, O365 |
| Wireless access | Provides WiFi access for staff and guests | Staff, guests, possibly clinical workflows | Ubiquiti APs at Central, unknown Westside WiFi, network infrastructure |
| Site connectivity | Connects Westside and HQ to Central infrastructure | Westside staff, HQ staff, IT | FortiGate 100F, Westside IPSec VPN, HQ site-to-site VPN, Netgear router, building-managed HQ network |
| Patient monitoring | Network-connected patient monitoring | Clinical departments at Central | Philips IntelliVue monitors, Central network |
| Infusion pump dosage updates | Network-connected medication dosage updates | Clinical departments at Central | BD Alaris infusion pumps, Central network |
| Nurse call and communications | Supports patient-to-nurse communication and phone integration | Patients, nurses, clinical support staff | IP-based nurse call system, phone system, Central network |
| Physical access control | Supports badge-based access to some doors | Staff, security, facilities, IT | HID Global badge system, AD integration, physical door hardware |
| Physical security guard coverage | Provides staffed deterrence and access support | Central staff, visitors, security operations | ClearView guard service at Central main entrance during weekday business hours |

## 4. Known Unknowns

| Gap / Unknown | Why It Matters |
|---|---|
| The packet date is listed as "[Current]" rather than a specific date. | Assessment accuracy depends on knowing how recent the documentation is. |
| The IT asset list is explicitly partial. | A partial inventory prevents complete risk assessment and may hide unmanaged or unsupported systems. |
| Some assets are marked unverified, including print-srv-01. | Unverified assets may no longer exist, may have changed configuration, or may be unmanaged. |
| Site headcounts total approximately 1,800, while the organization-wide total is approximately 2,000. | The difference of approximately 200 employees is not explained and may indicate missing staff categories, contractors, remote workers, or outdated figures. |
| The exact location and physical protection of the Central server room are not fully documented beyond the basement reference and Marcus's notes. | Physical access risks cannot be fully assessed without confirming room location, access controls, camera coverage, and access logs. |
| Westside may have an additional undocumented server. | Unknown servers may contain sensitive data, run unsupported software, or bypass standard controls. |
| The purpose and configuration of Westside's "basic needs" local server closet are unclear. | Local infrastructure may support critical services but appears physically insecure and poorly documented. |
| Westside wireless infrastructure is unknown. | Wireless exposure and segmentation cannot be assessed for the clinic. |
| Westside has a consumer-grade router and no documented firewall, but detailed configuration is unknown. | The risk level depends on exposed services, VPN configuration, firmware, credentials, logging, and network segmentation. |
| The brand and configuration of the Westside unmanaged switch are unknown. | Lack of managed switching may prevent VLANs, monitoring, and access control, but the exact capability is not confirmed. |
| Central core switch model and configuration are unknown. | Network segmentation, logging, redundancy, and access control cannot be validated. |
| The Central network is documented as flat with no VLANs, but the complete topology is described as messier than the draft diagram. | Actual traffic paths, dependencies, and exposure may differ from the simplified diagram. |
| Guest WiFi isolation at Central is not verified. | If guest WiFi is not isolated, public users may have a path toward internal systems or medical devices. |
| HQ VPN ACLs have not been audited. | Misconfigured ACLs could allow excessive access from HQ into Central systems. |
| HQ network details are managed by the building landlord and are not documented. | Third-party network management introduces dependency and visibility risks. |
| The complete endpoint count is unknown. | Endpoint security, licensing, patching, and monitoring coverage cannot be validated. |
| Endpoint numbers are based on an Active Directory report from 8 months ago. | The inventory may be stale and inaccurate. |
| iPad management status is unclear. | Unmanaged tablets used by physicians could expose clinical data or bypass security controls. |
| Sophos deployment currency and coverage are unknown. | Endpoint protection cannot be relied upon until coverage and update status are verified. |
| No formal endpoint security evaluation has been completed. | The organization lacks evidence that endpoint controls are effective. |
| Cloud service inventory is incomplete. | Departments may be using unsanctioned services that store sensitive data outside approved controls. |
| O365 is documented as the main cloud service, but other services are suspected. | Shadow IT may create compliance, access control, and data retention gaps. |
| The CT scanner operating system is unknown. | Unsupported or vulnerable medical device operating systems may create patient safety and security risk. |
| The referenced separate file for the MRI scanner is missing from the packet. | The MRI scanner is described as critical and running Windows XP, but supporting details are unavailable. |
| Medical device segmentation is not implemented according to Marcus's notes, but the complete medical device inventory is unknown. | Risk to patient monitors and infusion pumps may extend beyond the listed devices. |
| The nurse call system platform and architecture are not documented. | Availability and segmentation risks cannot be fully assessed for a clinical communication system. |
| The phone system is referenced but not inventoried. | Because the nurse call system integrates with it, phone system security and resilience are relevant. |
| Badge/access system coverage is described only as "some doors." | It is unclear which doors are AD-integrated, how access is reviewed, and whether critical areas are protected. |
| Server room badge access reportedly uses the same generic badge issued broadly, but access logs and permissions are not documented. | Physical access control effectiveness cannot be assessed without knowing who can enter and whether access is monitored. |
| Camera coverage is incomplete and no server room corridor cameras are documented. | Physical security monitoring for IT infrastructure is limited. |
| Westside's server closet does not lock, but there is no detailed physical security assessment. | Unauthorized physical access to IT equipment is plausible and needs validation. |
| Guard coverage exists only at Central main entrance during weekday daytime hours. | Nights, weekends, Westside, and HQ have no documented guard coverage. |
| No formal HIPAA Security Rule assessment exists. | Compliance posture cannot be proven and Legal's claim of compliance lacks evidence in the packet. |
| No formal incident response plan exists. | Response to future incidents may remain ad hoc and inconsistent. |
| A ransomware incident affected billing-srv-01 in January, but details are missing. | The cause, scope, containment, recovery steps, lessons learned, and residual risk are unknown. |
| No business continuity plan exists. | Clinical operations may be disrupted during major outages. |
| No disaster recovery plan exists. | Recovery priorities, RTOs, RPOs, and responsibilities are undefined. |
| UPS runtime is estimated at approximately 20 minutes, but supported systems and generator dependencies are not documented. | Power-loss resilience cannot be assessed without understanding what remains operational after UPS depletion. |
| Backups are local only based on the packet, but backup scope, restoration testing, retention, and immutability are not documented. | Backup effectiveness against ransomware and disasters cannot be validated. |
| The local NAS used for backups is not inventoried in the asset list with model, OS, capacity, access controls, or patch status. | The NAS is a critical recovery dependency and a likely ransomware target. |
| PostgreSQL on ehr-db-01 is accessible from the entire 10.10.0.0/16 range, but firewall rules and database authentication details are not documented. | Exposure is known, but likelihood and exploitability require configuration review. |
| SSH password authentication is enabled on Linux servers except where partially migrated, but the full migration status is unknown. | Linux server access risk cannot be fully assessed without verifying each server. |
| MFA is absent except for James's personal account, but remote access and privileged access paths are not fully documented. | MFA gaps are especially important for VPN, O365, administrator accounts, and remote-capable laptops. |
| Shared PACS credentials are documented, but the full extent of shared account usage is unknown. | Shared accounts undermine accountability and may indicate broader access control weaknesses. |
| Password policy is documented, but privileged account controls, service accounts, lockout policy, and monitoring are not described. | Authentication risk cannot be fully assessed from password length and rotation alone. |
| DMZ controls for web-srv-01 are not detailed. | Public-facing systems require clear inbound, outbound, patching, logging, and isolation controls. |
| Logging and monitoring coverage are not documented. | Detection capability cannot be assessed without log sources, retention, alerting, and ownership. |
| Vulnerability assessment has not been completed. | The organization does not have a validated view of exploitable weaknesses across servers, endpoints, network devices, or medical devices. |
| Threat landscape analysis was started but not completed. | Priorities may not align with current healthcare threat activity without external threat context. |
| Relationship boundaries between IT operations and security policy are unclear in practice. | James has security policy authority but no authority over IT operations, creating execution risk for remediation. |
| Budget denial for offsite/cloud backup is documented, but current risk acceptance is not formally recorded. | Leadership may be accepting major recovery risk without a documented decision or compensating controls. |

