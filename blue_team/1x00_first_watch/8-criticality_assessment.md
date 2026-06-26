# Asset Criticality Assessment

## Purpose

This document evaluates the criticality of MedDefense Health Systems asset categories using the CIA Triad: Confidentiality, Integrity, and Availability. The assessment is calibrated to MedDefense's healthcare context, where clinical operations, patient safety, protected health information, regulatory exposure, and continuity of care are the primary drivers of criticality.

## Criticality Scale

| Level | Definition |
|---|---|
| Critical | Compromise directly threatens patient safety, causes regulatory violation, or halts clinical operations. |
| High | Compromise causes significant operational disruption, financial loss, or data exposure. |
| Medium | Compromise causes moderate disruption and is recoverable within standard procedures. |
| Low | Compromise has minimal operational or security impact. |

## Asset Criticality Matrix

| Asset Category | Confidentiality | Integrity | Availability | Overall Criticality | Justification |
|---|---|---|---|---|---|
| EHR System | Critical | Critical | Critical | Critical | The EHR system includes `ehr-srv-01` and `ehr-db-01`, which support core patient care documentation and access to clinical records. Loss of confidentiality would expose protected health information and trigger regulatory, legal, and reputational consequences. Loss of integrity could lead physicians to make decisions based on incorrect patient data, and loss of availability would force clinical staff into paper workflows during active care delivery. |
| PACS, Imaging, and Radiology Systems | High | Critical | Critical | Critical | This category includes `pacs-srv-01`, the MRI control workstation, CT imaging, X-ray workstation, and radiology workstations. Integrity is critical because altered or incorrect imaging studies could directly affect diagnosis and treatment decisions. Availability is also critical because Radiology processes time-sensitive imaging, including approximately 45 MRI studies per day, and downtime delays patient care. |
| Medical IoT and Nurse Call Systems | High | Critical | Critical | Critical | This category includes Philips IntelliVue monitors, BD Alaris infusion pumps, connected vital signs monitors, and the IP-based nurse call system. Integrity and availability are critical because inaccurate monitoring, compromised dosage update capability, or unavailable nurse call functions can directly affect patient safety. Confidentiality is high because these systems can expose patient-related diagnostic, monitoring, and operational data. |
| Network Core and Site Connectivity | High | Critical | Critical | Critical | This category includes the FortiGate firewall, Cisco core and access switches, UniFi APs, Westside VPN, HQ VPN, and related routing and switching infrastructure. Availability is critical because network failure can interrupt access to EHR, PACS, billing, authentication, medical devices, and inter-site services. Integrity is critical because unauthorized network changes or lack of segmentation could enable lateral movement across all sites, which the scan confirmed are reachable without access restrictions. |
| Identity and Access Infrastructure | High | Critical | Critical | Critical | This category includes `ad-dc-01`, `ad-dc-02`, Active Directory authentication, and the HID badge integration for some doors. Compromise of identity infrastructure could allow unauthorized access to clinical systems, administrative systems, servers, and physical access controls. Availability is critical because loss of domain authentication can prevent staff from accessing systems needed for care delivery and operations. |
| Billing and Claims Infrastructure | High | High | High | High | This category includes `billing-srv-01` and related billing and claims processing functions. Confidentiality is high because billing systems may contain patient identifiers, insurance details, and financial records. Availability is high because the January ransomware incident prevented insurance claims processing for 4 days, directly disrupting revenue cycle operations, even if it did not immediately halt clinical care. |
| Backup and Recovery Infrastructure | High | High | Critical | Critical | This category includes `backup-srv-01`, Veeam, and `NAS-01`. Availability is critical because these assets determine whether MedDefense can recover from ransomware, system failure, data corruption, or outage affecting clinical and business systems. Confidentiality and integrity are high because backup repositories may contain full copies of sensitive systems, and corrupted or encrypted backups would undermine recovery confidence. |
| Clinical Endpoints and Mobile Devices | High | High | High | High | This category includes nurse station workstations, pharmacy workstations, lab workstations, thin clients, radiology workstations, and physician iPads. These endpoints are used to access EHR, pharmacy, laboratory, imaging, and other clinical workflows. Compromise could expose patient records, allow unauthorized changes under valid user sessions, or disrupt frontline care delivery. |
| Administrative, File, and Cloud Services | High | High | Medium | High | This category includes `file-srv-01`, HR file shares, Microsoft O365 E3, HQ workstations, HQ laptops, and administrative systems used by Finance, HR, Legal, Marketing, and Executive Leadership. Confidentiality is high because HR, legal, finance, and executive records may contain sensitive employee, legal, financial, and governance data. Availability is medium because outages are disruptive but usually do not immediately stop clinical care. |
| Physical Security and Restricted Infrastructure Areas | High | High | Critical | Critical | This category includes the server room, network closets, badge readers, emergency exit access path, guard service, and camera coverage. Availability is critical because unauthorized physical access to the server room or network closets could disconnect, damage, or tamper with infrastructure supporting hospital operations. Confidentiality and integrity are high because physical access can enable data theft, device tampering, credential exposure, and unauthorized access to restricted IT areas. |

## Top 5 Most Critical Assets

### 1. EHR System (`ehr-srv-01` and `ehr-db-01`)

The EHR system is the most critical asset because it is central to patient care, clinical documentation, and provider decision-making. If EHR data is unavailable, physicians may lose timely access to medication history, allergies, diagnoses, orders, and care notes. If EHR data is modified or corrupted, clinical decisions could be made from inaccurate records, creating direct patient safety risk. A confidentiality breach would expose protected health information and create regulatory notification, legal, and reputational consequences.

### 2. Network Core and Site Connectivity

The network core is ranked second because almost every other critical service depends on it. The FortiGate firewall, core switches, access switches, wireless infrastructure, and VPN links enable connectivity between Central, Westside, HQ, servers, workstations, and medical devices. The scan confirms that all subnets are reachable without access restrictions, so a network compromise could spread across clinical, administrative, and medical device environments rather than remaining contained.

### 3. Medical IoT and Nurse Call Systems

Medical IoT is ranked third because it connects cybersecurity risk directly to patient safety. Philips monitors, BD Alaris infusion pumps, connected vital signs monitors, and the nurse call system support patient monitoring, dosage-related workflows, and clinical response. If these systems display inaccurate data, become unavailable, or are reachable by unauthorized systems on the flat network, the impact is not only technical downtime but potential harm to patient care.

### 4. PACS, Imaging, and Radiology Systems

PACS and imaging systems are ranked fourth because diagnosis and treatment often depend on timely and accurate imaging. The MRI workstation is especially concerning because it runs an end-of-life Windows XP platform and cannot be patched, upgraded, or replaced under current constraints. A compromise could delay imaging studies, affect diagnostic integrity, or create a pivot path into the broader hospital network because the MRI workstation is not properly isolated.

### 5. Identity and Access Infrastructure

Identity and access infrastructure is ranked fifth because Active Directory and badge integration control who can access systems and some physical areas. If domain controllers are compromised, attackers could gain broad access to servers, endpoints, applications, and sensitive data using legitimate-looking credentials. If authentication is unavailable, staff may be unable to access clinical and administrative systems when needed.

## Assessment Notes

Several categories received an overall **Critical** rating because MedDefense operates a healthcare environment where system failure can affect patient care, not only IT availability. The highest-risk pattern is dependency concentration: EHR, PACS, medical devices, billing, backups, identity, and endpoints all depend on a flat network with limited internal segmentation. This means the compromise of one critical category can quickly affect multiple others.


