# Asset Registry

## Purpose

This document consolidates MedDefense Health Systems asset information from the onboarding packet, incident analysis, physical walk-through observations, control inventory, compensating control analysis, and the network scan summary. The goal is to create a single working inventory that identifies documented assets, scanned assets, undocumented systems, end-of-life systems, exposed services, and source discrepancies.

## Asset Registry

| Asset ID | Name | Type | Location | Owner (Dept) | OS/Platform | Critical Services | Network Segment | Status | Notes |
|---|---|---|---|---|---|---|---|---|---|
| A-001 | MedDefense Central Hospital | Physical Infrastructure | Downtown location | Operations / Clinical Leadership | Physical site | Acute care, emergency, surgery, radiology, oncology, pharmacy, laboratory, administration | Central internal network | Active | 350-bed hospital with approximately 1,400 staff. |
| A-002 | Westside Clinic | Physical Infrastructure | Suburban outpatient facility | Operations / Clinic Leadership | Physical site | Primary care, diagnostic imaging, blood work, minor procedures, physical therapy | 10.10.10.0/24 via IPSec VPN | Active | Connected to Central through VPN from Netgear router. |
| A-003 | Corporate HQ | Physical Infrastructure | Greenfield Business Park | Executive Leadership / Administration / IT | Leased office space | Finance, HR, Legal, Marketing, Executive Leadership, IT | 10.10.20.0/24 via site-to-site VPN | Active | Scan confirms workstations and laptops but no servers. |
| A-004 | Central Server Room | Physical Infrastructure | MedDefense Central | IT | Physical server room | Hosts Central servers and backup infrastructure | 10.10.2.0/24 server subnet | Active | Physical controls are weak; generic badge access and no camera coverage were documented. |
| A-005 | Second-Floor Network Closet | Physical Infrastructure | MedDefense Central, second floor | IT / Network Team | Physical network closet | Switches and patch panels | Central internal network | Active | Observed unlocked with credentials posted inside. |
| A-006 | Emergency Exit to Administrative Wing | Physical Infrastructure | MedDefense Central | Facilities / Operations | Physical access point | Access path to administrative wing and IT offices | Not applicable | Active | Observed propped open from public waiting area to restricted administrative wing. |
| A-007 | ehr-srv-01 | Server | MedDefense Central | IT / Clinical Systems | Ubuntu 20.04 | EHR application | 10.10.2.10, ports 22/443/8080 | Active | Scan confirms documented EHR application server. |
| A-008 | ehr-db-01 | Data Store | MedDefense Central | IT / Database Administration / Clinical Systems | Ubuntu 20.04, PostgreSQL | EHR database | 10.10.2.11, ports 22/5432 | Active | PostgreSQL is accessible from the entire internal network and should be restricted to ehr-srv-01. |
| A-009 | pacs-srv-01 | Server | MedDefense Central | Radiology / IT | Windows Server 2016 | PACS imaging | 10.10.2.12, ports 135/445/4242/11112 | Active | Supports medical imaging storage and transmission. |
| A-010 | billing-srv-01 | Server | MedDefense Central | Finance / IT | Ubuntu 18.04 | Billing and claims processing | 10.10.2.15, ports 22/80/3306 | Deprecated | Scan confirms Ubuntu 18.04 with standard support ended June 2023; MySQL is exposed internally. Previously affected by ransomware and suspected crypto-miner. |
| A-011 | ad-dc-01 | Server | MedDefense Central | IT | Windows Server 2019 | Primary domain controller | 10.10.2.20, ports 53/88/135/389/445/636 | Active | Provides authentication and directory services. |
| A-012 | ad-dc-02 | Server | MedDefense Central | IT | Windows Server 2019 | Secondary domain controller | 10.10.2.21, ports 53/88/135/389/445/636 | Active | Provides authentication redundancy. |
| A-013 | file-srv-01 | Server | MedDefense Central | IT / Department Owners | Windows Server 2016 | Department file shares | 10.10.2.30, ports 135/139/445 | Active | Scan confirms documented file server. |
| A-014 | print-srv-01 | Server | MedDefense Central | IT | Windows Server 2012 R2 | Print services | 10.10.2.31, ports 135/139/445/9100 | Deprecated | Previously marked unverified; scan confirms it exists and is end-of-life. |
| A-015 | backup-srv-01 | Server | MedDefense Central | IT | Ubuntu 22.04 | Backup operations | 10.10.2.40, port 22 | Active | Runs Veeam backup jobs. |
| A-016 | NAS-01 | Data Store | MedDefense Central server room | IT | Synology DSM 7 | Backup repository | 10.10.2.41, ports 5000/5001/22 | Active | Scan identifies the local NAS; management interface is accessible from the entire network. |
| A-017 | web-srv-01 | Server | MedDefense Central DMZ | IT / Patient Services / Marketing | Ubuntu 20.04 | Public website and patient portal | 10.10.2.50, ports 22/80/443 | Active | Documentation places this system in the DMZ; scan lists it in the Central server subnet. |
| A-018 | UNKNOWN-01 | Server | MedDefense Central server subnet | Unknown | Linux 4.x | Unknown web services | 10.10.2.99, ports 22/8888/9090 | Shadow IT (unmanaged) | Scan explicitly states this device is not in any documentation and has no DNS hostname. |
| A-019 | ws-srv-01 | Server | Westside Clinic | Westside Clinic / IT | Windows Server 2016 | Local file server and scheduling | 10.10.10.10, ports 135/139/445/3389 | Active | Scan confirms documented Westside server. |
| A-020 | WS-WC-XRAY | Endpoint | Westside Clinic | Radiology / Clinic Operations | Unknown vendor-specific system | X-ray workstation | 10.10.10.100, ports 80/4242 | Active | Scan identifies a vendor-specific X-ray workstation; the service was documented generally, but this asset was not in the IT asset list. |
| A-021 | Unknown Westside Linux Device | Server | Westside Clinic | Unknown | Linux 5.x | Unknown web service, possible Grafana or Node.js | 10.10.10.200, ports 22/80/3000 | Shadow IT (unmanaged) | Scan explicitly states the device is not in documentation and may have been unofficially connected. |
| A-022 | Westside Netgear Router | Network Device | Westside Clinic | IT / Westside Clinic | Netgear firmware | ISP access and IPSec VPN to Central | 10.10.10.1, ports 80/443/22 | Shadow IT (unmanaged) | Consumer-grade router used for medical facility connectivity. |
| A-023 | Fortinet FortiGate 100F | Network Device | MedDefense Central | IT / Network Team | Fortinet FortiGate | Perimeter firewall, DMZ, VPN termination | Internet edge / Central / VPNs | Active | Documented firewall supporting Central, Westside VPN, and HQ VPN. |
| A-024 | Cisco Core Switch | Network Device | MedDefense Central | IT / Network Team | Cisco, model unknown | Core switching | Central internal network | Active | Model unknown; Central network has no enforced segmentation. |
| A-025 | Cisco Access Switches | Network Device | MedDefense Central floors | IT / Network Team | Cisco, models unknown | Floor network access | Central internal network | Active | Documentation states two access switches per floor. |
| A-026 | Ubiquiti UniFi APs | Network Device | MedDefense Central | IT / Network Team | Ubiquiti UniFi | Wireless access | 10.10.1.200-10.10.1.211, ports 22/443 | Active | Scan confirms 12 APs including lobby, café, garage, basement, and ER APs. |
| A-027 | Central Guest WiFi | Network Device | MedDefense Central | IT / Network Team | Separate SSID | Guest wireless access | Segment not verified | Unknown | Guest SSID exists but isolation is unverified. |
| A-028 | Corporate HQ Building Network / VLAN | Network Device | Corporate HQ | Greenfield Building Management / IT | Building-managed network | HQ connectivity and site-to-site VPN | 10.10.20.0/24 | Active | Scan confirms HQ subnet over site-to-site VPN. |
| A-029 | WS-RECEPT-01 / WS-RECEPT-02 | Endpoint | MedDefense Central reception | Administration / IT | Windows 10 (19045) | Reception workstation access | 10.10.1.10-10.10.1.11, ports 135/139/445/3389 | Active | Scan shows RDP enabled on reception workstations without network-level restriction. |
| A-030 | Nurse Workstations | Endpoint | MedDefense Central nurse stations | Nursing / IT | Windows 10 (19045) | EHR access and clinical workflow | 10.10.1.20-10.10.1.42, ports 135/139/445 | Active | Includes first-, second-, and third-floor nurse workstations; a nurse station workstation was observed logged into EHR unattended. |
| A-031 | Admin Workstations | Endpoint | MedDefense Central administration | Administration / IT | Windows 10 (19045) | Administrative access | 10.10.1.50-10.10.1.52, ports 135/139/445/3389 | Active | Scan shows RDP enabled on admin workstations without network-level restriction. |
| A-032 | Pharmacy Workstations | Endpoint | MedDefense Central Pharmacy | Pharmacy / IT | Windows 10 (19045) | Pharmacy management access | 10.10.1.60-10.10.1.61, ports 135/139/445 | Active | Relevant to pharmacy dosage incident. |
| A-033 | WS-RAD-01 MRI Control Workstation | IoT Medical | Radiology, MedDefense Central | Radiology / Clinical Engineering | Windows XP SP3 / Windows XP Embedded | MRI control and PACS transmission | 10.10.1.70, ports 135/139/445 | Deprecated | End-of-life MRI control workstation; cannot be patched or upgraded due to certification constraints. |
| A-034 | WS-RAD-02 | Endpoint | Radiology, MedDefense Central | Radiology / IT | Windows 10 (19045) | Radiology workstation access | 10.10.1.71, ports 135/139/445 | Active | Scan identifies additional Radiology workstation. |
| A-035 | Laboratory Workstations | Endpoint | Laboratory, MedDefense Central | Laboratory / IT | Windows 10 (19045) | Laboratory workflow access | 10.10.1.80-10.10.1.81, ports 135/139/445 | Active | Scan identifies two lab workstations. |
| A-036 | ER Thin Clients | Endpoint | Emergency Department, MedDefense Central | Emergency / IT | Linux thin client | Clinical access in ER | 10.10.1.100-10.10.1.103, port 22 | Active | Scan identifies four ER thin clients; documentation mentions approximately 60 thin clients overall. |
| A-037 | Additional Central Workstations | Endpoint | MedDefense Central | Clinical and Administrative Departments / IT | Windows 10 | User access to clinical and business systems | 10.10.1.0/24 | Active | Scan reports approximately 290 additional Windows workstations omitted for brevity. |
| A-038 | Westside Workstations | Endpoint | Westside Clinic | Westside Clinic / IT | Windows 10 | Clinic workstation access | 10.10.10.20-10.10.10.55, ports 135/139/445 | Active | Scan shows 36 listed range endpoints; documentation estimated approximately 45 workstations. |
| A-039 | Corporate HQ Workstations | Endpoint | Corporate HQ | Corporate Departments / IT | Windows 10/11 | Finance, HR, Legal, Marketing, Executive Leadership, IT access | 10.10.20.10-10.10.20.130, ports 135/139/445 | Active | Scan confirms approximately 120 HQ workstations and no HQ servers. |
| A-040 | Corporate HQ Laptops | Endpoint | Corporate HQ / mobile workforce | Corporate Departments / IT | Windows 11 | Mobile administrative access | 10.10.20.200-10.10.20.201 and additional intermittent devices, ports 135/445 | Active | Scan detected approximately 25 laptops; documentation estimated approximately 30. |
| A-041 | Physician iPads | Endpoint | MedDefense Central / physician rounds | Clinical Departments / IT | iPadOS, management unknown | Rounds and clinical access | Wireless segment unknown | Unknown | Documentation mentions approximately 25 iPads; scan does not confirm them. |
| A-042 | IT Intern Personal Laptop | Endpoint | Internal WiFi | Unmanaged user device | Unknown | No authorized critical service | Internal network, not guest network | Shadow IT (unmanaged) | Incident F found this device on the internal network for 3 weeks running a torrent client. |
| A-043 | Philips IntelliVue Monitors | IoT Medical | MedDefense Central ICU/ER/3F and other areas | Clinical Engineering / Clinical Departments | Philips IntelliVue | Patient monitoring | 10.10.3.10-10.10.3.32 and additional devices, ports 80/443/2575 | Active | Scan lists representative devices and approximately 65 additional monitors. |
| A-044 | BD Alaris Infusion Pumps | IoT Medical | MedDefense Central ICU/ER/3F and other areas | Clinical Engineering / Clinical Departments | BD Alaris firmware 12.1.2 | Network-connected dosage updates | 10.10.3.40-10.10.3.46 and additional devices, ports 80/443 | Active | Scan states firmware has known CVEs and network isolation was recommended but not implemented. |
| A-045 | MON-VITALS-3F-01 | IoT Medical | MedDefense Central patient room | Clinical Engineering / Clinical Departments | Unknown vendor | Vital signs monitoring | 10.10.3.47, port 80 | Active | Matches the connected vital signs monitor observed during the walk-through. |
| A-046 | Nurse Call System | IoT Medical | MedDefense Central | Facilities / Clinical Operations / IT | IP-based system | Nurse call and phone integration | 10.10.3.50-10.10.3.51, ports 80/5060 | Active | Scan confirms two nurse-call devices. |
| A-047 | HID Badge Readers | Physical Infrastructure | MedDefense Central | Facilities / IT / Security | HID Global | Physical access control | 10.10.3.60-10.10.3.62, ports 80/443 | Active | Scan confirms main, server room, and ER badge readers. |
| A-048 | GE Revolution CT Scanner | IoT Medical | MedDefense Central | Radiology / Clinical Engineering | Unknown OS | CT imaging | Not found in scan summary | Unknown | Documented in onboarding packet but not specifically identified in scan summary. |
| A-049 | Microsoft O365 E3 | Application | Cloud service | IT / All Departments | Microsoft O365 E3 | Email, productivity, collaboration | Cloud service | Active | Contracted organization-wide; not expected to appear as internal IP host. |
| A-050 | Sophos Endpoint Protection | Application | Managed endpoints | IT / Security | Sophos | Endpoint protection | Endpoint management scope unknown | Active | Contract exists, but coverage and currency on all endpoints are not confirmed. |
| A-051 | Veeam Backup Software | Application | backup-srv-01 | IT | Veeam | Backup jobs | 10.10.2.40 to NAS-01 | Active | Supports nightly backup operations. |
| A-052 | Patient Portal | Application | web-srv-01 | Patient Services / IT | Web application platform not documented | Patient access to lab results | web-srv-01 / DMZ | Active | Broken access control incident allowed authenticated patients to view other patients' lab results. |
| A-053 | Public Website | Application | web-srv-01 | Marketing / IT | Web application platform not documented | Public website | web-srv-01 / DMZ | Active | Website was defaced and restored from backup. |
| A-054 | Pharmacy Management System | Application | All three sites | Pharmacy / IT | Platform not documented | Medication dosage management | Network segment not documented | Active | Database update script caused incorrect dosages across all three sites. |
| A-055 | HR File Share | Data Store | File share environment | HR / IT | File share platform not fully documented | HR documents and employee data | Internal segment reachable by intern laptop | Active | Incident F states the intern laptop had access to the same network segment as the HR file share. |

## Reconciliation Notes

### Assets found in the network scan that do not appear in documentation

- **10.10.2.99 / UNKNOWN-01**: Linux 4.x device on the Central server subnet with ports 22, 8888, and 9090. The scan states that it is not in any documentation and has no DNS hostname.
- **10.10.10.200 / Unknown Westside Linux device**: Linux 5.x device at Westside with ports 22, 80, and 3000. The scan states that it is not in documentation and may be an unofficial tool such as Grafana or Node.js.
- **WS-WC-XRAY / 10.10.10.100**: A vendor-specific X-ray workstation appears in the scan. Westside diagnostic imaging was documented, but this specific asset was not listed in the IT asset inventory.
- **NAS-01 / 10.10.2.41**: The NAS was mentioned in notes and the diagram as a backup repository, but the scan provides the first concrete hostname, OS, IP address, and exposed management ports.
- **Individual AP hostnames** such as AP-LOBBY, AP-CAFE, AP-GARAGE, AP-BSMT, and AP-ER are scan-confirmed, while earlier documentation only provided the total count of 12 UniFi APs.

### Assets mentioned in documentation that do not appear in the network scan

- **GE Revolution CT Scanner**: Documented in the onboarding packet with unknown OS, but not specifically identified in the scan summary.
- **Physician iPads**: Approximately 25 iPads were documented, but they are not identified in the scan summary.
- **Possible additional Westside server**: Marcus mentioned a possible additional server in the Westside closet. The scan found 10.10.10.200, but it cannot be assumed to be the same device without physical validation.
- **Central physical infrastructure assets** such as the server room, second-floor network closet, and emergency exit do not appear in a network scan because they are not IP assets.
- **Microsoft O365 E3** does not appear in the internal scan because it is a cloud service.
- **Some thin clients and workstations** are documented in larger quantities than the explicitly listed scan rows because the scan summary omits many endpoints for brevity.

### Discrepancies and contradictions between sources

- The scan confirms the Central environment is effectively flat: all scanned subnets were reachable from Sarah's HQ workstation without access restrictions. This confirms earlier documentation stating there is no enforced segmentation.
- Documentation estimated approximately 30 HQ laptops, but the scan detected approximately 25 during the scan window. The scan notes these are intermittent mobile devices, so this is not necessarily a contradiction but requires endpoint management reconciliation.
- Documentation estimated approximately 45 Westside workstations, while the scan excerpt lists addresses from WS-WC-01 to WS-WC-36. The difference may be due to devices powered off, omitted rows, or inventory drift.
- `print-srv-01` was marked unverified in the IT asset list, but the scan confirms it exists at 10.10.2.31 and is running an end-of-life Windows Server 2012 platform.
- `billing-srv-01` was documented as Ubuntu 18.04 and the scan confirms it at 10.10.2.15. The scan adds that standard support ended in June 2023 and ESM is not activated.
- The documentation describes `web-srv-01` as a DMZ system, while the scan lists it under 10.10.2.0/24 Central servers. This requires validation of whether the DMZ is logically separate, only documented at a high level, or not actually segmented as expected.
- The onboarding packet states that medical devices are on the flat Central network, and the scan confirms that medical device addressing is only a convention because there is no VLAN or firewall separation.
- The network scan confirms that MySQL on `billing-srv-01`, PostgreSQL on `ehr-db-01`, and the NAS management interface are accessible from the entire internal network, supporting the earlier gap analysis around missing internal segmentation.

## Registry Limitations

This registry should be treated as a consolidated working inventory, not a final CMDB. The next steps should include physical validation of undocumented systems, endpoint management reconciliation, DHCP and DNS review, firewall object review, and confirmation of whether scan-only devices are authorized, owned, supported, and monitored.


