# MedDefense Attack Surface Map

## Overview

An attack surface is every point where an attacker could attempt to interact with MedDefense systems, data, or people. It includes both technical and human entry points. A surface is not automatically a vulnerability, but it becomes dangerous when protection is weak, monitoring is limited, or documented gaps make exploitation easier.

This map organizes the MedDefense attack surface into three dimensions:

1. **External Surface** - systems and services reachable from the Internet.
2. **Internal Surface** - systems and services reachable after an attacker gains a foothold inside the network.
3. **Human Surface** - people and roles that can be targeted through social engineering, insider misuse, or unsafe workflows.

The analysis references prior 1x00 posture findings used throughout the MedDefense threat work: public-facing exposure, flat network architecture, weak identity controls, unmanaged assets, legacy systems, default credentials, weak monitoring, and insufficient security training.

---

# Section 1: External Surface

## 1. Patient Portal

**Entry Point:**  
Public patient portal hosted on `web-srv-01`.

**Asset Behind It:**  
Patient-facing web application connected to patient services, authentication, scheduling, and potentially EHR-adjacent workflows.

**Protection Exists:**  
- **CM-NET-01: Network Boundary Protection** should protect public-facing applications.
- **CM-APP-01: Web Application Security** should cover secure development, patching, input validation, and vulnerability management.
- **CM-IAM-01: Authentication and MFA** should protect user login functions.
- **CM-LOG-01: Security Logging and Monitoring** should detect suspicious portal activity.

**Documented Gap:**  
- **MD-GAP-01: Unpatched public-facing systems.**
- **MD-GAP-05: No SIEM / IDS / effective monitoring.**
- **MD-GAP-06: No tested incident response plan.**

**Why It Matters:**  
The patient portal is a direct Internet-facing path into MedDefense. If a vulnerability exists in the web application, authentication flow, or underlying server, attackers could steal credentials, access patient data, or use the portal as a foothold for deeper compromise.

---

## 2. VPN Endpoints

**Entry Point:**  
Remote access VPN, including the FortiGate perimeter device.

**Asset Behind It:**  
Internal MedDefense network access for staff, IT support, and possibly third-party vendors.

**Protection Exists:**  
- **CM-IAM-01: MFA for remote access.**
- **CM-NET-01: Network boundary protection.**
- **CM-VULN-01: Vulnerability and patch management.**
- **CM-VRM-01: Third-party access governance** for vendors using remote access.

**Documented Gap:**  
- **MD-GAP-01: Unpatched public-facing systems.**
- **GAP-IAM-02: No automated offboarding / stale active accounts.**
- **MD-GAP-03: Weak identity and privilege management.**
- **MD-GAP-05: Weak monitoring of unusual VPN activity.**

**Why It Matters:**  
VPN access is one of the highest-risk external surfaces. The BlackReef profile and prior intelligence dossier identify VPN appliance vulnerabilities and valid credentials as common healthcare ransomware entry points. A compromised VPN account or unpatched VPN CVE can give an attacker direct internal access.

---

## 3. Email Infrastructure

**Entry Point:**  
Microsoft O365 email infrastructure.

**Asset Behind It:**  
Organization-wide email accounts, executive communications, attachments, mailbox rules, SharePoint and OneDrive links, and possibly Entra ID authentication.

**Protection Exists:**  
- **CM-IAM-01: MFA for cloud accounts.**
- **CM-EMAIL-01: Email security gateway / anti-phishing protection.**
- **CM-LOG-02: Cloud audit logging.**
- **CM-DATA-02: Data loss prevention for cloud-stored information.**

**Documented Gap:**  
- **GAP-TRAIN-01: Low security awareness and phishing training completion.**
- **MD-GAP-05: Limited monitoring and alerting.**
- **MD-GAP-03: Weak identity controls.**

**Why It Matters:**  
Email is a major social engineering and credential-theft surface. Attackers can use phishing, business email compromise, malicious attachments, OAuth consent abuse, or mailbox rule manipulation to gain access or conduct fraud.

---

## 4. Public Website

**Entry Point:**  
MedDefense public website.

**Asset Behind It:**  
Public communications platform, hospital information, service pages, contact forms, and possibly CMS administration.

**Protection Exists:**  
- **CM-APP-01: Web application security.**
- **CM-VULN-01: Vulnerability scanning and patching.**
- **CM-NET-01: Boundary protection.**
- **CM-LOG-01: Web server logging and monitoring.**

**Documented Gap:**  
- **MD-GAP-01: Public-facing application exposure.**
- **MD-GAP-05: No centralized monitoring.**
- **MD-GAP-06: Weak incident response readiness.**

**Why It Matters:**  
The public website can be used for defacement, credential harvesting, malware redirection, or initial access if the CMS or web server is vulnerable. Hacktivists and opportunistic attackers are especially likely to target this surface.

---

## 5. DNS

**Entry Point:**  
Public DNS records for MedDefense domains and externally reachable services.

**Asset Behind It:**  
Domain resolution for patient portal, public website, email routing, VPN endpoints, and cloud services.

**Protection Exists:**  
- **CM-NET-01: External service governance.**
- **CM-DNS-01: DNS change control and registrar protection.**
- **CM-IAM-02: Privileged access control for DNS administration.**

**Documented Gap:**  
- **MD-GAP-05: Limited monitoring of external indicators.**
- **MD-GAP-VRM-01: Vendor and external service governance gaps.**

**Why It Matters:**  
DNS misconfiguration or registrar compromise can redirect users to malicious infrastructure. DNS records also reveal MedDefense's external footprint to attackers conducting reconnaissance.

---

## 6. Externally Reachable Billing Server / Web Service

**Entry Point:**  
`billing-srv-01`, previously referenced as running Apache 2.4.29 with known remote code execution risk.

**Asset Behind It:**  
Billing system, financial workflows, patient billing data, and potentially backend database connections.

**Protection Exists:**  
- **CM-VULN-01: Vulnerability and patch management.**
- **CM-NET-01: Network boundary protection.**
- **CM-APP-01: Application security.**
- **CM-LOG-01: Monitoring.**

**Documented Gap:**  
- **MD-GAP-01: Unpatched public-facing systems.**
- **MD-GAP-05: Weak monitoring.**
- **MD-GAP-02: Flat network increases post-compromise blast radius.**

**Why It Matters:**  
This system has already been used as an example of opportunistic compromise, including crypto-mining activity. If reachable externally and unpatched, it is a likely target for automated scanners and initial access brokers.

---

# Section 2: Internal Surface

## Internal Surface Context: Flat Network Finding

The internal surface is especially dangerous because MedDefense has a documented **flat network**. In a segmented network, a compromised workstation or server would have limited reach. In MedDefense's flat network, internal services such as databases, management interfaces, NAS storage, medical devices, and legacy systems may be reachable from broad parts of the environment.

This means that once an attacker gains a foothold through phishing, VPN compromise, public web exploitation, or vendor access, the internal attack surface becomes immediately valuable.

---

## 1. MySQL on `billing-srv-01`

**Asset:**  
Billing server and billing database services.

**Exposure:**  
MySQL service accessible network-wide.

**Why This Matters in a Flat Network:**  
If MySQL is reachable from broad internal segments, any compromised endpoint may be able to attempt database login, brute force credentials, exploit weak configurations, or extract billing data. Billing data may include patient identifiers, insurance information, payment details, and financial records.

**Associated Gap:**  
- **MD-GAP-02: Flat network / lack of segmentation.**
- **MD-GAP-03: Weak identity and privilege management.**
- **MD-GAP-05: Weak monitoring.**

---

## 2. PostgreSQL on `ehr-db-01`

**Asset:**  
EHR database server.

**Exposure:**  
PostgreSQL service accessible network-wide.

**Why This Matters in a Flat Network:**  
The EHR database is one of MedDefense's highest-value assets. If it is reachable from unnecessary hosts, attackers who compromise any internal system may attempt credential theft, direct database access, data dumping, or ransomware staging. Broad database reachability increases the probability of patient-data exfiltration.

**Associated Gap:**  
- **MD-GAP-02: Flat network / lack of segmentation.**
- **GAP-DATA-01: Uncontrolled patient-data exposure.**
- **MD-GAP-05: Insufficient monitoring.**

---

## 3. NAS Management Interface

**Asset:**  
Backup NAS or network storage.

**Exposure:**  
NAS web management interface and file-sharing services reachable from the internal network.

**Why This Matters in a Flat Network:**  
Ransomware groups specifically look for backup infrastructure. If the NAS is reachable from compromised hosts, attackers can delete, encrypt, or modify backups before deploying ransomware. This directly increases extortion pressure.

**Associated Gap:**  
- **MD-GAP-04: Non-isolated backup infrastructure.**
- **MD-GAP-02: Flat network.**
- **MD-GAP-05: Weak monitoring of backup deletion/modification attempts.**

---

## 4. FortiGate Admin Interface

**Asset:**  
FortiGate firewall / perimeter gateway.

**Exposure:**  
Administrative interface accessible internally, and possibly externally if misconfigured.

**Why This Matters in a Flat Network:**  
If an attacker reaches the FortiGate admin interface from a compromised internal host, they may attempt credential attacks, configuration changes, VPN account manipulation, or firewall rule changes. Control of the perimeter device can support persistence and external access.

**Associated Gap:**  
- **MD-GAP-03: Weak privileged access management.**
- **MD-GAP-05: Weak monitoring.**
- **MD-GAP-01: Public-facing system exposure if management is externally reachable.**

---

## 5. IoT Web Interfaces

**Asset:**  
Medical IoT devices, facility devices, and unmanaged web-enabled systems.

**Exposure:**  
HTTP/HTTPS management interfaces reachable from the internal network.

**Why This Matters in a Flat Network:**  
IoT devices often run outdated firmware, weak authentication, and limited logging. In a flat network, these devices can become pivot points for attackers or blind spots for persistence.

**Associated Gap:**  
- **GAP-ASSET-01: Shadow IT and unmanaged devices.**
- **MD-GAP-02: Lack of segmentation.**
- **GAP-IAM-01: Default or shared credentials.**

---

## 6. Windows XP MRI Workstation

**Asset:**  
MRI workstation connected to Siemens scanner environment.

**Exposure:**  
Legacy Windows XP system reachable on the medical device network, with possible connectivity to PACS or other imaging workflows.

**Why This Matters in a Flat Network:**  
Windows XP is end-of-life and difficult to patch. If reachable from the broader internal network, it can be exploited, infected, or used as a pivot into imaging systems. It may also disrupt clinical diagnostics if compromised.

**Associated Gap:**  
- **GAP-LEGACY-01: Legacy unsupported systems.**
- **MD-GAP-02: Weak network segmentation.**
- **CM-MD-01: Medical device security control needed.**

---

## 7. Windows Server 2012 R2 Systems

**Asset:**  
Legacy Windows Server workloads.

**Exposure:**  
Server services accessible from internal network segments.

**Why This Matters in a Flat Network:**  
Older server operating systems may have patching constraints and weaker security baselines. If exposed network-wide, they are attractive targets for privilege escalation, lateral movement, and ransomware deployment.

**Associated Gap:**  
- **GAP-LEGACY-01: Legacy unsupported or aging systems.**
- **MD-GAP-02: Flat network.**
- **CM-VULN-01: Patch and vulnerability management weakness.**

---

## 8. PACS Default Credentials

**Asset:**  
Radiology PACS workstation or PACS-connected systems.

**Exposure:**  
Shared/default credentials such as `raduser/radiology1`.

**Why This Matters in a Flat Network:**  
Shared credentials remove accountability and may allow unauthorized users or attackers to access imaging systems. If the same or similar credentials are reused elsewhere, an attacker may expand access.

**Associated Gap:**  
- **GAP-IAM-01: Shared credentials and weak accountability.**
- **GAP-TRAIN-01: Weak security practice reinforcement.**
- **MD-GAP-05: Insufficient access monitoring.**

---

## 9. Medical IoT Default Credentials

**Asset:**  
Medical IoT devices and network-connected clinical equipment.

**Exposure:**  
Default credentials or weak shared credentials on internal web interfaces.

**Why This Matters in a Flat Network:**  
Default credentials are a low-effort path for attackers. In a flat network, a compromised IoT device may become a foothold for reconnaissance, persistence, or pivoting to more important systems.

**Associated Gap:**  
- **GAP-IAM-01: Default/shared credentials.**
- **GAP-ASSET-01: Unmanaged devices.**
- **MD-GAP-02: Lack of segmentation.**

---

## 10. Active Directory and Domain Controllers

**Asset:**  
Domain controllers and Active Directory services.

**Exposure:**  
Authentication, directory, group policy, and administrative services reachable internally.

**Why This Matters in a Flat Network:**  
Ransomware groups target Active Directory to escalate privileges and deploy ransomware through Group Policy. If attackers reach Domain Controllers after compromising one internal host, the entire Windows environment may be at risk.

**Associated Gap:**  
- **MD-GAP-03: Weak identity and privilege management.**
- **MD-GAP-02: Flat network.**
- **MD-GAP-05: Weak detection of tools such as BloodHound, AdFind, Mimikatz, and PsExec.**

---

# Section 3: Human Surface

## 1. Clinical Staff

**Role:**  
Doctors, nurses, technicians, and clinical personnel.

**Access Level:**  
Clinical staff have access to EHR records, patient data, PACS, medical device workflows, and care coordination systems.

**Why They Are Targetable:**  
Clinical staff are busy, patient-focused, and trained to be helpful. They may respond quickly to urgent requests, especially those framed as patient-care or IT-support issues. They also have broad access to patient data.

**Training or Control Gap:**  
- **GAP-TRAIN-01: Low security training completion.**
- **GAP-MON-01: Insufficient EHR access monitoring.**
- **GAP-IAM-01: Shared credentials in clinical environments.**

**Likely Attack Methods:**  
Vishing, phishing, smishing, credential theft, fake IT support calls, and malicious links related to scheduling, HR, or patient care.

---

## 2. Reception and Front Desk Staff

**Role:**  
Registration clerks and reception personnel.

**Access Level:**  
Reception staff may access patient registration systems, appointment schedules, demographic data, insurance information, and visitor-facing workflows.

**Why They Are Targetable:**  
They are the first contact point for patients, visitors, vendors, and callers. They handle urgent requests and may be pressured by people claiming authority, distress, or clinical urgency.

**Training or Control Gap:**  
- **GAP-TRAIN-01: Weak social engineering awareness.**
- **GAP-PHY-01: Physical access and visitor verification weaknesses.**
- **GAP-MON-01: Weak detection of inappropriate EHR access.**

**Likely Attack Methods:**  
Pretexting, impersonation, vishing, visitor manipulation, tailgating support, and inappropriate EHR access.

---

## 3. IT Staff

**Role:**  
IT administrators, support staff, network administrators, and security staff.

**Access Level:**  
IT staff may have elevated privileges, access to Active Directory, VPN administration, endpoint management, server maintenance, backups, firewall administration, and monitoring tools.

**Why They Are Targetable:**  
IT staff are high-value targets because their credentials can unlock major parts of the environment. The small team size increases fatigue and makes unsafe shortcuts more likely, such as plaintext credentials in scripts or rushed password resets.

**Training or Control Gap:**  
- **GAP-IAM-03: Weak privileged credential management.**
- **GAP-PROC-01: Lack of secure administrative automation standards.**
- **MD-GAP-05: Limited monitoring and alerting.**
- **MD-GAP-06: No tested incident response plan.**

**Likely Attack Methods:**  
Spear phishing, brand impersonation, fake vendor patches, credential theft, password reset abuse, malware disguised as security updates, and social engineering using urgency.

---

## 4. Executives

**Role:**  
CEO, CFO, board-facing leadership, department directors.

**Access Level:**  
Executives have access to strategic documents, financial approvals, sensitive communications, contracts, legal matters, and high-level decision-making.

**Why They Are Targetable:**  
Executives are attractive for business email compromise, wire fraud, strategic intelligence, and reputation attacks. Their authority can be abused to pressure other employees into bypassing procedure.

**Training or Control Gap:**  
- **GAP-TRAIN-01: Need for role-specific executive phishing/BEC training.**
- **CM-FIN-01: Financial approval and out-of-band verification control required.**
- **CM-EMAIL-01: Email impersonation protection needed.**

**Likely Attack Methods:**  
Business email compromise, executive impersonation, phishing, malicious document attachments, credential theft, and payment fraud.

---

## 5. External Contractors

**Role:**  
IT support contractors, EHR maintenance vendors, medical device vendors, building management contractors, and other third parties.

**Access Level:**  
Contractors may have VPN access, EHR maintenance access, medical device maintenance access, physical access, cloud administration access, or building network access.

**Why They Are Targetable:**  
Contractors are partly outside MedDefense's direct control. Their devices, accounts, and security practices may not match MedDefense standards. If a contractor account remains active after termination or is compromised at the vendor, MedDefense inherits the risk.

**Training or Control Gap:**  
- **GAP-IAM-02: No automated offboarding / stale contractor accounts.**
- **MD-GAP-VRM-01: Vendor access governance gap.**
- **CM-VRM-01: Third-party risk management required.**
- **CM-IAM-04: Third-party access control required.**

**Likely Attack Methods:**  
Vendor credential compromise, stolen VPN access, remote support abuse, supply chain compromise, physical access abuse, and phishing of vendor personnel.

---

# Surface Assessment Summary

The **internal surface** represents the greatest risk for MedDefense today because the documented flat network turns any successful external, human, or vendor compromise into a potential enterprise-wide incident. The external surface is dangerous because VPN, web services, O365, and the patient portal provide entry points, and the human surface is dangerous because staff and contractors can be manipulated or make unsafe decisions. However, the internal surface determines the blast radius after initial access. Network-wide access to MySQL on `billing-srv-01`, PostgreSQL on `ehr-db-01`, NAS management, FortiGate administration, IoT interfaces, legacy Windows XP and Server 2012 R2 systems, PACS/default credentials, and Active Directory means that one compromised account or endpoint could lead to data exfiltration, backup destruction, privilege escalation, and ransomware deployment. Until segmentation, identity hardening, backup isolation, and monitoring are improved, the flat internal network is the surface that most directly converts small compromises into hospital-wide crises.

---

## Summary Table

| Surface | Main Entry Points | Main Assets at Risk | Key Gaps | Overall Risk |
|---|---|---|---|---|
| External | Patient portal, VPN, O365, public website, DNS, billing web service | EHR-adjacent workflows, credentials, billing data, email, public reputation | MD-GAP-01, MD-GAP-03, MD-GAP-05, MD-GAP-06 | High |
| Internal | Databases, NAS, FortiGate admin, IoT interfaces, legacy systems, PACS, AD | EHR database, billing data, backups, domain control, medical devices | MD-GAP-02, MD-GAP-03, MD-GAP-04, GAP-LEGACY-01, GAP-ASSET-01 | Critical |
| Human | Clinical staff, reception, IT, executives, contractors | Credentials, patient data, financial approvals, physical access, vendor paths | GAP-TRAIN-01, GAP-IAM-01, GAP-IAM-02, GAP-MON-01, MD-GAP-VRM-01 | High |

