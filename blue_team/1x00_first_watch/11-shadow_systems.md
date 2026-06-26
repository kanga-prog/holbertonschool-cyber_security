# Shadow IT Assessment

## Purpose

This document assesses three Shadow IT systems identified by the IT helpdesk lead. Shadow IT refers to systems, services, or devices operating inside or alongside the MedDefense environment without formal IT approval, ownership, monitoring, or security governance.

The systems assessed are:

- Dr. Patel's personal NAS in Cardiology.
- A Marketing Google Drive linked to a personal Gmail account.
- A Raspberry Pi on the second floor of Central, originally used as an unofficial network monitor.

Each system is assessed for sensitive data exposure, missing official controls, worst-case compromise scenario, recommended response, and required asset registry updates.

## Shadow System 1: Dr. Patel's Personal NAS in Cardiology

### Risk Assessment

**Sensitive data or access this system might contain:**  
The personal NAS may contain research data, clinical research extracts, patient-related cardiology data, imaging or diagnostic files, study notes, or spreadsheets derived from hospital systems. If the research data includes patient identifiers, clinical observations, appointment details, imaging references, or treatment information, it should be treated as **Restricted** because it may qualify as protected health information.

**Official controls that do not cover this system:**  
The NAS is not documented as an approved MedDefense asset, so it is likely outside official asset inventory, standard configuration management, Active Directory access control, Sophos endpoint protection, Veeam backup governance, centralized monitoring, vulnerability assessment, patch management, and formal data retention procedures. It may also bypass O365 governance and approved department file share permissions.

**Worst-case scenario if compromised:**  
An attacker compromises the NAS from the flat internal network, steals research or patient-related cardiology data, and uses the device as a foothold to move laterally toward EHR, PACS, or other clinical systems. The worst case combines **Confidentiality** impact from exposed patient or research data, **Integrity** impact if research data is altered, and **Availability** impact if the NAS becomes ransomware staging or malware distribution infrastructure.

### Recommended Response

**Strategy:** Migrate

**Justification:**  
The data should be moved to an approved MedDefense storage platform such as a governed department file share, approved research storage, or an IT-managed cloud repository with access controls, auditability, backup, retention, and ownership. The personal NAS should not be legitimized as-is because it was personally purchased, informally connected, and may already contain sensitive data outside governance.

**Required actions:**

1. Disconnect or isolate the NAS after coordinating with Cardiology and Legal to prevent evidence or data loss.
2. Inventory the data stored on the device and classify it.
3. Transfer approved data to an IT-managed storage location.
4. Validate permissions and ownership for the migrated data.
5. Wipe or securely decommission the personal NAS after migration and approval.

## Shadow System 2: Marketing Google Drive Linked to Personal Gmail

### Risk Assessment

**Sensitive data or access this system might contain:**  
The shared Google Drive may contain media files, press communications, public relations drafts, campaign materials, internal strategy, photos, vendor materials, and potentially sensitive communications related to hospital operations. If any patient images, staff photos, incident statements, legal review drafts, or unreleased public communications are stored there, the data may be **Confidential** or **Restricted** depending on content.

**Official controls that do not cover this system:**  
Because the drive is linked to a personal Gmail account, it is outside MedDefense's Microsoft O365 E3 governance, Active Directory authentication, organization password policy, MFA enforcement, access review, legal hold, audit logging, retention policy, backup management, and offboarding process. If the Gmail owner leaves or loses access, MedDefense may lose control of the data.

**Worst-case scenario if compromised:**  
A compromised personal Gmail account could expose confidential marketing plans, media files, press communications, or patient-related images if any were uploaded. An attacker could also alter or delete public communication materials, causing reputational damage, regulatory risk if patient information is exposed, and operational disruption during a public incident or crisis communication process.

### Recommended Response

**Strategy:** Migrate

**Justification:**  
The data and workflow should be moved into an approved corporate platform under MedDefense control, such as Microsoft O365/SharePoint/OneDrive or another formally approved media repository. The personal Google Drive should not remain in use because it is tied to an individual account that MedDefense does not govern or audit.

**Required actions:**

1. Identify the owner of the personal Gmail account and obtain a data export under Legal and IT oversight.
2. Review the drive contents for patient data, employee data, legal material, and public communication drafts.
3. Migrate approved files to an IT-managed repository.
4. Remove shared links and revoke external access from the personal Google Drive.
5. Document Marketing's approved storage location and sharing process going forward.

## Shadow System 3: Raspberry Pi Network Monitor on Second Floor

### Risk Assessment

**Sensitive data or access this system might contain:**  
The Raspberry Pi may contain network monitoring data, packet captures, credentials, logs, internal IP addresses, hostnames, service information, or monitoring dashboards. If it captured traffic or stored scan results, it may provide access to sensitive operational intelligence about MedDefense's internal network.

**Official controls that do not cover this system:**  
The Raspberry Pi is likely outside the official asset inventory, Sophos endpoint protection, Active Directory control, Veeam backups, patch management, vulnerability assessment, centralized logging, access review, and documented ownership. It may have local credentials, default credentials, outdated packages, or exposed web services similar to other undocumented Linux devices found during the scan.

**Worst-case scenario if compromised:**  
An attacker compromises the Raspberry Pi and uses it as a persistent internal foothold for reconnaissance, credential capture, traffic observation, or lateral movement across the flat MedDefense network. The worst case affects **Confidentiality** through captured network information or credentials, **Integrity** if monitoring data or configurations are altered, and **Availability** if it is used to support malware deployment or network disruption.

### Recommended Response

**Strategy:** Legitimize and Secure

**Justification:**  
Because the device may have been intentionally created as a network monitor at Marcus's request, its function could be useful to Security if properly governed. The appropriate response is to bring it under IT and Security ownership, validate its purpose, rebuild it from a trusted image, harden it, document it in the asset registry, and restrict its access. If validation shows there is no legitimate need, it should then be decommissioned.

**Required actions:**

1. Locate the device physically and disconnect or isolate it until ownership and function are confirmed.
2. Preserve any relevant configuration or logs for review.
3. Rebuild the device from a trusted image if the monitoring function is still needed.
4. Assign an owner, document its purpose, restrict network access, and apply patch management.
5. Require authentication, logging, and regular review of any monitoring data it collects.

## Asset Registry Update

The following entries should be added to the Asset Registry from Task 7.

| Asset ID | Name | Type | Location | Owner (Dept) | OS/Platform | Critical Services | Network Segment | Status | Notes |
|---|---|---|---|---|---|---|---|---|---|
| A-056 | Dr. Patel Personal NAS | Data Store | Cardiology office, MedDefense Central | Cardiology / Dr. Patel, not IT-owned | Personal NAS platform unknown | Unapproved research data storage | Central internal network, exact IP unknown | Shadow IT | Personally purchased NAS connected to a wall port; stores research data because official shared drive was considered too slow. Requires data classification, migration, and decommissioning. |
| A-057 | Marketing Personal Google Drive | Application | Cloud service outside MedDefense governance | Marketing, linked to personal Gmail owner | Google Drive / personal Gmail | Media files and press communications | External cloud service | Shadow IT | Shared Google Drive linked to a personal Gmail account. Outside MedDefense O365, AD, retention, audit, and offboarding controls. Requires migration to an approved corporate repository. |
| A-058 | Second-Floor Raspberry Pi Monitor | Network Device | Second floor, MedDefense Central | Unknown; possibly previous intern / Security | Raspberry Pi OS or Linux, version unknown | Unofficial network monitoring | Central internal network, exact IP unknown | Shadow IT | Device was reportedly set up as a network monitor and abandoned after Marcus and the intern left. Requires physical validation, isolation, rebuild, ownership assignment, and documentation. |

## Shadow IT Policy Recommendation

MedDefense should implement a mandatory **IT Asset and Cloud Service Approval Policy** requiring that any device, storage system, software service, cloud repository, or network-connected tool be reviewed and approved by IT and Security before use. The policy should include a fast approval path for departments with legitimate operational needs, because staff often create Shadow IT when approved tools are slow, difficult to access, or do not meet workflow needs. This policy should be enforced through procurement review, network access control, periodic network scans, cloud service reviews, and manager accountability so that new systems cannot quietly become unmanaged repositories for sensitive data.


