# Prioritized Gap Analysis

## Purpose

This document consolidates findings from the Asset Criticality Assessment, Data Map, Complete Control Matrix, Shadow IT Assessment, and supporting scan/documentation evidence. The objective is to identify the most significant security gaps by cross-referencing:

- What MedDefense must protect: critical assets and sensitive data.
- What protections currently exist: preventive, detective, corrective, compensating, deterrent controls.
- Where the distance between asset criticality and control coverage is unacceptable.

## Risk Rating Method

| Risk Level | Rule Applied |
|---|---|
| Critical | Gap affects a Critical-rated asset or Restricted data and lacks effective detective or corrective coverage. |
| High | Gap affects a High-rated asset or Confidential data and has incomplete control coverage. |
| Medium | Gap affects a Medium-rated asset or has partial controls that reduce but do not eliminate risk. |
| Low | Gap affects a Low-rated asset and has partial compensating measures. |

## Prioritized Gap List

### GAP-001: No Effective Internal Network Segmentation

**Affected Asset(s):**  
Network Core and Site Connectivity (**Critical**), EHR System (**Critical**), Medical IoT and Nurse Call Systems (**Critical**), PACS/Imaging (**Critical**), Identity Infrastructure (**Critical**)

**Data at Risk:**  
Patient medical records, medical imaging data, medication data, billing data, authentication data, and medical device data (**Restricted**)

**Current Control Status:**  
MedDefense has a FortiGate firewall, VPNs, Active Directory, and some endpoint protection, but the scan confirmed that internal subnets are reachable without meaningful restrictions.

**What is Missing:**  
Technical Preventive control: enforced VLANs, ACLs, firewall rules, and zone-based segmentation between workstations, servers, medical devices, backup infrastructure, and administrative networks. Technical Detective control is also missing for east-west internal movement.

**Risk Level:**  
Critical

**Risk Justification:**  
This gap affects multiple Critical asset categories and Restricted data. The absence of segmentation means that a compromised workstation, unmanaged device, or vulnerable medical device can reach systems such as EHR, PACS, billing, backup storage, and domain controllers. There is no effective internal containment layer if a preventive control is bypassed.

**Potential Impact:**  
A single compromised endpoint or Shadow IT device could be used to move laterally across clinical, administrative, and medical device networks. This could expose patient records, disrupt clinical systems, compromise backups, and create hospital-wide downtime similar to the billing ransomware incident but with broader clinical consequences.

### GAP-002: EHR Database Broadly Accessible from the Internal Network

**Affected Asset(s):**  
EHR System: `ehr-srv-01`, `ehr-db-01` (**Critical**)

**Data at Risk:**  
Patient medical records and clinical records (**Restricted**)

**Current Control Status:**  
Active Directory authentication exists, a password policy exists, and `ehr-srv-01` has SSH key-only hardening. However, PostgreSQL on `ehr-db-01` is reachable from the internal network instead of being restricted to the EHR application server.

**What is Missing:**  
Technical Preventive control: database-level network allowlisting and host-based firewall restrictions. Technical Detective control: database access monitoring and centralized alerting for unauthorized connection attempts.

**Risk Level:**  
Critical

**Risk Justification:**  
The EHR database stores Restricted data and supports a Critical clinical asset. Broad internal database reachability creates a direct path from any compromised internal host to the most sensitive clinical data store. Existing controls do not provide sufficient detection or restriction for database access attempts.

**Potential Impact:**  
An attacker with internal network access could attempt credential attacks, exploit database exposure, access patient records, or alter clinical data. This could trigger regulatory reporting, legal exposure, reputational damage, and patient safety risk if clinical data integrity is affected.

### GAP-003: Medical IoT Devices Exposed to the Entire Internal Network

**Affected Asset(s):**  
Medical IoT and Nurse Call Systems (**Critical**), including Philips IntelliVue monitors, BD Alaris infusion pumps, connected vital signs monitors, and nurse call systems

**Data at Risk:**  
Patient monitoring data, device configuration data, dosage-related operational data, and clinical workflow data (**Restricted**)

**Current Control Status:**  
Some general network infrastructure controls exist, but there is no enforced isolation for medical devices. The scan confirmed that medical device management interfaces are reachable from the internal network.

**What is Missing:**  
Technical Preventive control: medical device VLANs, ACLs, and restricted management access. Technical Detective control: monitoring of medical device traffic and alerts for unauthorized access attempts.

**Risk Level:**  
Critical

**Risk Justification:**  
The affected assets are Critical because compromise can directly affect patient monitoring, dosage workflows, and nurse call availability. The data and functions involved are Restricted in a healthcare context. Existing controls do not provide sufficient isolation or detection.

**Potential Impact:**  
A compromised internal device could access medical device management interfaces, interfere with patient monitoring, disrupt nurse call communications, or target infusion pump infrastructure. This could create direct patient safety risk and clinical operational disruption.

### GAP-004: Legacy MRI Workstation Running End-of-Life Windows XP on the General Network

**Affected Asset(s):**  
PACS, Imaging, and Radiology Systems (**Critical**), MRI control workstation `WS-RAD-01` / Siemens MAGNETOM MRI (**Critical**)

**Data at Risk:**  
Medical imaging data, imaging workflow data, and patient identifiers associated with studies (**Restricted**)

**Current Control Status:**  
The MRI requires network connectivity to PACS. Proposed compensating controls exist in the assessment, including dedicated segmentation and MRI-to-PACS allowlisting, but they are not yet confirmed as implemented.

**What is Missing:**  
Technical Compensating and Preventive controls: dedicated MRI isolation, allowlisted communication only to PACS, and passive network monitoring. Administrative Compensating control: formal risk exception and periodic review.

**Risk Level:**  
Critical

**Risk Justification:**  
The MRI workstation supports a Critical imaging workflow and runs an unsupported operating system that cannot be patched or upgraded. Because it is on the same network as general workstations, it can act as both a vulnerable target and a pivot into the broader hospital network.

**Potential Impact:**  
A compromise could interrupt MRI availability, delay approximately 45 MRI studies per day, expose imaging data, or allow an attacker to move from Radiology into PACS, EHR, and other clinical systems.

### GAP-005: Backup Architecture Is Not Resilient Against Ransomware or Physical Co-Failure

**Affected Asset(s):**  
Backup and Recovery Infrastructure: `backup-srv-01`, Veeam, `NAS-01` (**Critical**)

**Data at Risk:**  
Backup copies of EHR data, billing data, file shares, application data, and system configurations (**Restricted**)

**Current Control Status:**  
Veeam nightly backups and `NAS-01` exist, but the NAS is located in the same rack, same server room, and same network as production systems. The January ransomware event revealed that the available backup was three weeks old due to a misconfigured job.

**What is Missing:**  
Technical Corrective control: immutable, offline, or offsite backups. Administrative Corrective control: tested recovery procedures, backup validation, and recovery time/recovery point objectives.

**Risk Level:**  
Critical

**Risk Justification:**  
Backup infrastructure protects multiple Critical systems and Restricted data. Existing corrective controls are weak because production and backup assets share the same failure and ransomware exposure path. There is no evidence of tested recovery capability.

**Potential Impact:**  
A ransomware event could encrypt both production systems and backups, preventing restoration of EHR, billing, file shares, or imaging workflows. MedDefense could face prolonged clinical and administrative downtime with limited ability to recover reliable data.

### GAP-006: No Formal Incident Response Plan

**Affected Asset(s):**  
All Critical systems, including EHR, billing, PACS, domain controllers, medical IoT, and backup infrastructure (**Critical**)

**Data at Risk:**  
Patient records, imaging data, billing data, HR data, credentials, logs, and backup data (**Restricted** and **Confidential**)

**Current Control Status:**  
Some technical and vendor support controls exist, but the January ransomware response was improvised for four days. No formal incident response plan is documented.

**What is Missing:**  
Administrative Corrective control: formal incident response plan, roles and responsibilities, containment playbooks, evidence preservation procedure, escalation matrix, and communications plan.

**Risk Level:**  
Critical

**Risk Justification:**  
This gap affects Critical assets and Restricted data across the enterprise. Without formal incident response, MedDefense has no repeatable process to contain, investigate, eradicate, and recover from incidents that bypass preventive controls.

**Potential Impact:**  
Future ransomware, credential compromise, patient portal breach, or Shadow IT compromise could remain active longer, spread more widely, and cause avoidable legal, operational, and patient-care impact.

### GAP-007: Patient Portal Authorization Controls Are Insufficient

**Affected Asset(s):**  
Patient Portal and `web-srv-01` (**High**), EHR-related patient data (**Critical**)

**Data at Risk:**  
Patient lab results and patient portal data (**Restricted**)

**Current Control Status:**  
`web-srv-01` is protected by the perimeter firewall/DMZ concept and backups restored the public website after defacement. However, a prior broken access control allowed authenticated patients to view other patients' lab results by modifying a URL parameter.

**What is Missing:**  
Technical Preventive control: application-level authorization enforcement and secure object access checks. Technical Detective control: application logging and alerting for abnormal access patterns. Administrative Detective control: secure code review or application security testing.

**Risk Level:**  
Critical

**Risk Justification:**  
The data involved is Restricted patient information, and the prior incident proves that authorization controls failed. Perimeter controls do not protect against authenticated application abuse, and no effective detective control is documented.

**Potential Impact:**  
Patients could access other patients' lab results, triggering privacy violations, regulatory notification, patient trust damage, legal exposure, and reputational harm.

### GAP-008: Organization-Wide MFA Is Missing

**Affected Asset(s):**  
Identity and Access Infrastructure (**Critical**), EHR, O365, VPN users, administrative accounts, clinical endpoints, and file shares

**Data at Risk:**  
Patient data, HR records, financial/legal data, credentials, and cloud productivity data (**Restricted** and **Confidential**)

**Current Control Status:**  
Active Directory authentication and a password policy exist. MFA is documented only for James Chen's personal account.

**What is Missing:**  
Technical Preventive control: organization-wide MFA for privileged users, remote access, O365, VPN, EHR access, and high-risk applications.

**Risk Level:**  
High

**Risk Justification:**  
The gap affects Critical identity infrastructure and multiple Restricted/Confidential data categories. Password-only access significantly increases the likelihood that phishing, password reuse, or credential theft results in unauthorized access.

**Potential Impact:**  
A compromised password could allow attackers to access email, internal systems, file shares, VPN sessions, or clinical applications. This could lead to data theft, fraudulent activity, or lateral movement across the flat network.

### GAP-009: Shadow IT Stores or Processes Sensitive Data Outside Governance

**Affected Asset(s):**  
Dr. Patel's personal NAS, Marketing personal Google Drive, Raspberry Pi network monitor, unknown Linux systems (**High** to **Critical** depending on data/function)

**Data at Risk:**  
Research data, patient-related data, marketing and press communications, internal network data, credentials, logs, and operational intelligence (**Restricted**, **Confidential**, and **Internal**)

**Current Control Status:**  
The Complete Control Matrix covers approved assets, but Shadow IT systems are outside normal asset inventory, endpoint protection, backup, patching, access review, monitoring, and retention controls.

**What is Missing:**  
Administrative Preventive control: mandatory asset and cloud service approval process. Technical Detective control: continuous discovery of unauthorized devices and unsanctioned cloud services. Technical Preventive control: network access control or equivalent enforcement.

**Risk Level:**  
High

**Risk Justification:**  
Shadow IT can contain Restricted or Confidential data while being invisible to official controls. The risk is high because these systems may bypass authentication, monitoring, backup, retention, and offboarding processes.

**Potential Impact:**  
Sensitive research or patient data could be exposed from an unmanaged NAS, press communications could be lost or leaked from a personal Google Drive, and an abandoned Raspberry Pi could become a persistent internal foothold for attackers.

### GAP-010: Weak Physical Security Around Critical Infrastructure

**Affected Asset(s):**  
Central Server Room, Network Closet, Network Core, Backup Infrastructure, Domain Controllers, EHR and Billing Servers (**Critical**)

**Data at Risk:**  
All data stored or processed by Central servers and network infrastructure, including Restricted patient and backup data

**Current Control Status:**  
Badge readers, limited cameras, and a limited guard service exist. However, server room access uses generic badges, there is no camera covering the server room corridor, no visitor log, and a network closet was observed unlocked with credentials posted.

**What is Missing:**  
Physical Preventive control: restricted badge profiles and locked network closets. Physical Detective control: camera coverage and visitor logging near critical infrastructure. Administrative Preventive control: credential handling and physical access procedure.

**Risk Level:**  
Critical

**Risk Justification:**  
This gap affects Critical infrastructure and Restricted data, and the physical controls are either weak or absent at the points that matter most. The unlocked network closet with posted credentials creates a direct route to both physical and logical compromise.

**Potential Impact:**  
An insider, contractor, or visitor could access network infrastructure, steal credentials, connect rogue devices, disrupt connectivity, tamper with servers, or compromise backup and identity systems.

### GAP-011: HR and Administrative Data Are Reachable from Unmanaged or Poorly Controlled Endpoints

**Affected Asset(s):**  
Administrative, File, and Cloud Services (**High**), HR File Share (**High**), HQ endpoints (**High**)

**Data at Risk:**  
Employee HR records, salary data, legal data, finance data, executive communications (**Confidential**)

**Current Control Status:**  
O365, AD, password policy, HQ VLAN, and site-to-site VPN exist. However, the intern's personal laptop was connected to the internal network for three weeks and had access to the same segment as the HR file share.

**What is Missing:**  
Technical Preventive control: network access control, device compliance enforcement, and segmentation around HR data. Technical Detective control: alerts for unmanaged devices accessing sensitive segments.

**Risk Level:**  
High

**Risk Justification:**  
The affected data is Confidential and official controls are incomplete. An unmanaged personal laptop running torrent software had network access to an HR segment, showing that device trust and network placement are not enforced.

**Potential Impact:**  
Employee records, salaries, or legal documents could be exposed. The device could also introduce malware, create bandwidth abuse, or become a bridge between external threats and internal HR resources.

### GAP-012: No Formal Vulnerability Management Program

**Affected Asset(s):**  
All servers, endpoints, medical devices, applications, network devices, and Shadow IT systems (**Critical** to **High**)

**Data at Risk:**  
Patient records, imaging data, billing data, HR data, credentials, backup data, and operational logs (**Restricted** and **Confidential**)

**Current Control Status:**  
Some endpoint protection and vendor support contracts exist. However, Marcus had not completed formal vulnerability assessment, endpoint security evaluation, cloud inventory, threat landscape analysis, or IoT device analysis.

**What is Missing:**  
Administrative Detective control: formal vulnerability management program. Technical Detective control: recurring authenticated scans, exposure monitoring, and remediation tracking.

**Risk Level:**  
High

**Risk Justification:**  
The environment contains end-of-life systems such as Windows XP, Windows Server 2012 R2, and Ubuntu 18.04 without ESM, plus medical devices with known CVEs. Without a formal program, vulnerabilities remain unknown or unprioritized until exploitation occurs.

**Potential Impact:**  
Known vulnerabilities could be exploited on clinical systems, billing infrastructure, medical devices, or network services. This could cause data exposure, ransomware, service disruption, or patient-care impact.

### GAP-013: Database and Management Interfaces Are Exposed Internally

**Affected Asset(s):**  
EHR Database (**Critical**), Billing Infrastructure (**High**), Backup Infrastructure (**Critical**), NAS-01 (**Critical**)

**Data at Risk:**  
EHR records, billing data, backup data, system configurations (**Restricted**)

**Current Control Status:**  
Network perimeter controls exist, but the scan confirmed internal exposure of PostgreSQL on `ehr-db-01`, MySQL on `billing-srv-01`, and NAS management interfaces.

**What is Missing:**  
Technical Preventive control: host firewall rules, service allowlisting, management network isolation, and least-access network rules. Technical Detective control: alerts for unauthorized management and database connection attempts.

**Risk Level:**  
Critical

**Risk Justification:**  
The exposed services provide access paths to Restricted data and Critical recovery assets. Because the internal network is flat, any compromised host can potentially attempt access to sensitive databases and backup management interfaces.

**Potential Impact:**  
An attacker could attack databases, extract data, modify records, or compromise backup repositories. This could lead to patient data breach, billing fraud, ransomware escalation, or loss of recovery capability.

### GAP-014: Lack of Centralized Logging and Security Monitoring

**Affected Asset(s):**  
All Critical and High asset categories, including EHR, PACS, billing, AD, network infrastructure, endpoints, and Shadow IT

**Data at Risk:**  
Audit logs, authentication records, patient access logs, system logs, and security event data (**Confidential** and operationally critical)

**Current Control Status:**  
Sophos endpoint protection, FortiGate logs, native system logs, and application logs may exist, but no centralized SIEM, IDS, or formal monitoring process is documented.

**What is Missing:**  
Technical Detective control: centralized log collection, correlation, alerting, IDS/NDR, and monitored security use cases. Administrative Detective control: defined monitoring ownership and review procedures.

**Risk Level:**  
Critical

**Risk Justification:**  
This gap affects the ability to detect compromise across Critical assets and Restricted data environments. Without centralized logging and monitoring, incidents that bypass preventive controls may remain undetected until operational symptoms appear.

**Potential Impact:**  
Ransomware, crypto-mining, patient portal abuse, Shadow IT compromise, or credential misuse could continue for days or weeks. MedDefense may also be unable to determine what data was accessed, which complicates legal, regulatory, and patient notification decisions.

## Gap Distribution Summary

### Gaps by Risk Level

| Risk Level | Count | Gap IDs |
|---|---:|---|
| Critical | 10 | GAP-001, GAP-002, GAP-003, GAP-004, GAP-005, GAP-006, GAP-007, GAP-010, GAP-013, GAP-014 |
| High | 4 | GAP-008, GAP-009, GAP-011, GAP-012 |
| Medium | 0 | None identified in the prioritized set |
| Low | 0 | None identified in the prioritized set |

### Asset Categories with the Most Gaps

| Asset Category | Related Gap IDs | Pattern |
|---|---|---|
| Network Core and Site Connectivity | GAP-001, GAP-003, GAP-010, GAP-013, GAP-014 | Flat network architecture creates exposure paths across clinical, administrative, backup, and medical device environments. |
| EHR System and Patient Data | GAP-001, GAP-002, GAP-007, GAP-013, GAP-014 | Restricted patient data is exposed by broad internal access, weak application authorization, and weak detection. |
| Medical IoT and Imaging | GAP-001, GAP-003, GAP-004, GAP-012, GAP-014 | Clinical devices and legacy systems are reachable, difficult to patch, and insufficiently monitored. |
| Backup and Recovery Infrastructure | GAP-005, GAP-006, GAP-013, GAP-014 | Corrective capability exists but is fragile, local, and not supported by tested recovery or strong monitoring. |
| Identity and Administrative Data | GAP-008, GAP-009, GAP-011, GAP-014 | Password-only access, Shadow IT, unmanaged devices, and limited monitoring create data exposure risk. |

### Control Category and Function Concentration

The gaps are concentrated in **Technical Detective**, **Technical Preventive**, and **Administrative Corrective** controls. MedDefense has some preventive controls, including a firewall, VPNs, Active Directory, password policy, endpoint protection, and vendor contracts, but those controls do not provide sufficient internal segmentation, monitoring, or incident response capability. The overall pattern is that MedDefense is more prevention-oriented than detection- or response-oriented, which means the organization may not know quickly when preventive controls fail and may respond inconsistently once an incident is discovered.


