# Control Gap Analysis

## Purpose

This document analyzes the Control Summary Matrix from Task 4 to identify significant gaps in MedDefense Health Systems' current security control framework. A control gap is considered significant when a critical asset, zone, or security function lacks adequate coverage, or when an existing control does not cover the assets that need it most.

## Identified Control Gaps

### Gap ID: G-001

**Gap Description:**  
MedDefense has no documented technical detective control for internal network activity beyond endpoint protection. There is no evidence of IDS, network detection, centralized traffic monitoring, or alerting for suspicious east-west movement inside the Central network.

**Category x Function Missing:**  
Technical Detective

**Affected Asset(s) or Zone:**  
MedDefense Central internal network, EHR systems, billing-srv-01, medical IoT devices, workstations, file shares, and domain controllers.

**Risk if Unaddressed:**  
If an attacker bypasses the perimeter firewall or compromises an internal device, MedDefense may not detect lateral movement, data access, malware communication, or reconnaissance activity. This affects **Confidentiality** because sensitive patient and business data could be accessed without detection, **Integrity** because systems could be modified, and **Availability** because malware activity could spread before response begins.

**Evidence:**  
The Task 4 matrix includes technical preventive controls such as the FortiGate firewall, DMZ, VPNs, Active Directory, and limited MFA, but the only technical detective control identified is Sophos endpoint protection. Marcus's notes also state that the Central network is flat and that medical devices, workstations, and servers share the same 10.10.0.0/16 broadcast domain, increasing the need for internal detection.

### Gap ID: G-002

**Gap Description:**  
There is no formal incident response plan or documented incident handling procedure.

**Category x Function Missing:**  
Administrative Corrective

**Affected Asset(s) or Zone:**  
All MedDefense systems and business functions, especially billing-srv-01, EHR systems, domain controllers, clinical systems, and patient-facing services.

**Risk if Unaddressed:**  
Future incidents may be handled inconsistently, slowly, or without proper containment, evidence preservation, communication, or recovery coordination. This increases **Availability** impact during outages, **Confidentiality** impact during breaches, and **Integrity** impact when compromised systems are not properly contained or rebuilt.

**Evidence:**  
The documentation states that no formal incident response plan exists and that the January ransomware response on billing-srv-01 was ad hoc for four days. The Task 4 control matrix does not include an administrative corrective incident response control.

### Gap ID: G-003

**Gap Description:**  
There is no documented business continuity plan or disaster recovery plan for clinical operations.

**Category x Function Missing:**  
Administrative Corrective

**Affected Asset(s) or Zone:**  
MedDefense Central clinical operations, EHR availability, billing operations, medical imaging services, and hospital continuity during outages or power loss.

**Risk if Unaddressed:**  
If a major system outage, ransomware event, power failure, or infrastructure failure occurs, clinical staff may not have a tested procedure for continuing operations safely. This primarily impacts **Availability**, but it can also affect **Integrity** if paper processes or manual workarounds result in incomplete or incorrect patient records.

**Evidence:**  
Marcus's notes state that there is no business continuity plan and no disaster recovery plan, and that Central has no documented procedure for clinical operations if power is lost beyond the UPS capacity. The Task 4 matrix contains technical backup controls but no administrative recovery planning control.

### Gap ID: G-004

**Gap Description:**  
Backups exist, but there is no evidence of offsite, isolated, or immutable backup storage, and no evidence of a tested recovery procedure.

**Category x Function Missing:**  
Technical Corrective

**Affected Asset(s) or Zone:**  
backup-srv-01, local NAS, EHR data, billing data, department file shares, and other server data dependent on backup recovery.

**Risk if Unaddressed:**  
A ransomware event or physical incident affecting the server room could compromise both production systems and backups. This would severely affect **Availability** because systems may not be restorable, and **Integrity** because recovery may depend on outdated or compromised backup data.

**Evidence:**  
Task 4 identified Veeam nightly backups and a local NAS as corrective controls, but Marcus's notes state that the NAS is in the same server room, on the same network, and in the same rack as the backup server. The January ransomware incident also showed that the backup was three weeks old because of a misconfigured cron job.

### Gap ID: G-005

**Gap Description:**  
There is no effective network segmentation between servers, workstations, and medical IoT devices at MedDefense Central.

**Category x Function Missing:**  
Technical Preventive

**Affected Asset(s) or Zone:**  
Central network, EHR servers, billing-srv-01, PACS server, domain controllers, workstations, Philips IntelliVue monitors, BD Alaris infusion pumps, and other medical devices.

**Risk if Unaddressed:**  
A compromised workstation, medical device, or guest-connected system could directly reach critical servers or other clinical devices. This threatens **Confidentiality** by exposing patient and business data, **Integrity** by allowing unauthorized modification of systems or medical device behavior, and **Availability** by enabling malware or lateral movement across the entire environment.

**Evidence:**  
Marcus's notes and the network diagram state that everything at Central is on 10.10.0.0/16 with no VLANs configured, and that medical devices, workstations, and servers are on the same broadcast domain. The Task 4 matrix contains perimeter controls but no internal segmentation control for Central.

### Gap ID: G-006

**Gap Description:**  
Multi-factor authentication is not deployed organization-wide and is only documented for James Chen's personal account.

**Category x Function Missing:**  
Technical Preventive

**Affected Asset(s) or Zone:**  
User accounts, administrative accounts, VPN access, O365 accounts, clinical systems, EHR access, and privileged IT access.

**Risk if Unaddressed:**  
Compromised passwords may be enough to access sensitive systems or cloud services. This creates a major **Confidentiality** risk for patient, HR, and financial data, and an **Integrity** risk if attackers use valid accounts to modify records or configurations.

**Evidence:**  
Task 4 identified MFA only as a limited control for James Chen's account. Marcus's notes state that there is no MFA anywhere else.

### Gap ID: G-007

**Gap Description:**  
Physical detective controls do not cover the server room corridor or key IT infrastructure access points.

**Category x Function Missing:**  
Physical Detective

**Affected Asset(s) or Zone:**  
Server room, server room corridor, backup server, local NAS, domain controllers, billing server, EHR servers, and other Central infrastructure.

**Risk if Unaddressed:**  
Unauthorized physical access to critical infrastructure may not be recorded or detected. This affects **Confidentiality** if data or hardware is accessed, **Integrity** if equipment is tampered with, and **Availability** if systems are disconnected, damaged, or stolen.

**Evidence:**  
Task 4 identified cameras only in the parking garage and ER entrance. Marcus's physical notes state that there are no cameras in the server room corridor and that server room badge access uses the same generic badge issued to everyone.

### Gap ID: G-008

**Gap Description:**  
Westside Clinic lacks adequate perimeter and physical controls for a medical facility.

**Category x Function Missing:**  
Technical Preventive and Physical Preventive

**Affected Asset(s) or Zone:**  
Westside Clinic network, ws-srv-01, local server closet, clinic workstations, local scheduling and file services, and VPN connectivity to Central.

**Risk if Unaddressed:**  
An attacker or unauthorized person could compromise Westside infrastructure and use its VPN connectivity as a path into Central. This threatens **Confidentiality** of clinic and Central data, **Integrity** of local and connected systems, and **Availability** of clinic operations.

**Evidence:**  
The documentation states that Westside has no firewall and uses a consumer-grade Netgear router for ISP connectivity and site-to-site VPN. Marcus's physical notes also state that Westside has basically zero physical security for IT equipment and that the server closet does not lock.

### Gap ID: G-009

**Gap Description:**  
There is no documented formal vulnerability assessment program for servers, endpoints, cloud services, or medical IoT devices.

**Category x Function Missing:**  
Administrative Detective

**Affected Asset(s) or Zone:**  
All servers, endpoints, cloud services, medical IoT devices, public website, patient portal, and network infrastructure.

**Risk if Unaddressed:**  
Known vulnerabilities, unsupported systems, weak configurations, and exposed services may remain unidentified until they are exploited. This affects **Confidentiality**, **Integrity**, and **Availability**, especially for systems such as billing-srv-01, print-srv-01, web-srv-01, and medical IoT devices.

**Evidence:**  
Marcus's notes state that he had not completed a formal vulnerability assessment of all servers, endpoint security evaluation, cloud service inventory, threat landscape analysis, or IoT device analysis. The Task 4 matrix does not include an administrative detective vulnerability management control.

### Gap ID: G-010

**Gap Description:**  
Security governance and compliance assurance are not formally evidenced, including HIPAA Security Rule assessment.

**Category x Function Missing:**  
Administrative Detective

**Affected Asset(s) or Zone:**  
Organization-wide security program, patient data handling, compliance posture, clinical systems, administrative systems, and executive risk reporting.

**Risk if Unaddressed:**  
MedDefense may believe it is compliant without evidence, leaving patient data protection gaps unidentified and increasing legal, regulatory, and operational risk. This primarily affects **Confidentiality** of protected health information, but weak governance can also allow **Integrity** and **Availability** risks to persist without remediation.

**Evidence:**  
Marcus's notes state that HIPAA Security Rule compliance has never been formally assessed and that Legal claims compliance without evidence. The Task 4 matrix does not include an administrative detective compliance assessment or audit control.

## Overall Pattern

MedDefense's security posture is more prevention-oriented than detection-oriented. The organization has some preventive controls, such as a firewall, VPNs, badge access, password policy, and limited MFA, but it has weak internal detection, limited physical monitoring around critical infrastructure, no formal incident response plan, and no tested continuity or recovery program. This means that if an attacker bypasses preventive controls, MedDefense may detect the compromise late and respond inconsistently, increasing the potential impact on confidentiality, integrity, and availability.


