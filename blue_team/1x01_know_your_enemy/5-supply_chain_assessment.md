# Supply Chain Risk Assessment for MedDefense

## Overview

MedDefense depends on multiple third-party vendors for clinical systems, cloud services, endpoint protection, medical devices, and building network infrastructure. Each vendor creates a different type of supply chain exposure. A vendor compromise may not start inside MedDefense, but it can become a MedDefense incident if the vendor has trusted access to systems, data, identity, or physical infrastructure.

This assessment maps five critical vendors and evaluates how each one could become an attack path into MedDefense.

---

## Vendor 1: MedTech Solutions

**Service:**  
EHR maintenance provider. MedTech Solutions has an annual contract worth $145,000, a 4-hour response SLA, and direct server access for EHR maintenance.

**Access Type:**  
Network and application access.  
MedTech has direct maintenance access to the EHR server environment.

**Access Scope:**  
MedTech can reach the EHR maintenance interface or server management path used to support the electronic health record platform. Depending on how the access is configured, this may include:

- EHR application server
- EHR database or database management functions
- Patient records stored or processed by the EHR
- Maintenance tools and service accounts
- Potentially the Windows or Linux server hosting the EHR application
- Logs, configuration files, and integration points with billing, lab, or identity systems

**Compromise Scenario:**  
If MedTech Solutions is breached, an attacker could steal MedTech technician credentials, VPN access, remote support tooling, or EHR maintenance tokens. The attacker could then connect to MedDefense through the trusted vendor access path. Once inside, the attacker could access the EHR server, extract patient records, modify or disrupt clinical data, deploy malware through maintenance tools, or use the EHR server as a pivot point into adjacent internal systems. If the EHR server has connectivity to Active Directory, file shares, billing systems, or backup systems, the compromise could escalate into a broader ransomware or data exfiltration incident.

**Existing Controls:**  
Referenced control areas from the 1x00 Control Matrix:

- **CM-VRM-01: Vendor Risk Management** - vendor contracts and access should be reviewed.
- **CM-IAM-04: Third-Party Access Control** - vendor accounts should be unique, time-limited, MFA-protected, and logged.
- **CM-LOG-01: Security Logging and Monitoring** - vendor sessions should be monitored and reviewed.
- **CM-NET-02: Network Segmentation** - vendor access should be restricted to the specific EHR maintenance zone.

**Risk Assessment:**  
**Critical**  
MedTech has direct access to the most sensitive clinical system at MedDefense: the EHR. A compromise could expose regulated patient data, disrupt clinical workflows, affect patient care, and provide a pathway for ransomware. The risk is critical unless access is tightly segmented, monitored, MFA-protected, and only enabled when needed.

---

## Vendor 2: Microsoft

**Service:**  
Microsoft O365 E3, including organization-wide email, SharePoint, OneDrive, and identity services if Entra ID is used.

**Access Type:**  
Application, data, and identity access.  
Microsoft hosts or manages core collaboration and identity services used across MedDefense.

**Access Scope:**  
Microsoft services may contain or control access to:

- MedDefense email accounts
- SharePoint sites
- OneDrive files
- Teams or collaboration data if enabled
- User identities and authentication if Entra ID is used
- Conditional access policies
- MFA configuration
- Potentially audit logs and cloud security alerts
- Sensitive business documents, HR data, contracts, and possibly patient-related documents if users store them in O365

**Compromise Scenario:**  
If Microsoft tenant administration or MedDefense's Microsoft cloud identity environment is compromised, an attacker could reset passwords, bypass MFA, create malicious OAuth applications, read executive email, conduct business email compromise, access SharePoint and OneDrive files, create mailbox forwarding rules, and harvest credentials. If Entra ID is integrated with on-premises Active Directory or used for single sign-on, the attacker could use identity compromise to access other MedDefense applications.

**Existing Controls:**  
Referenced control areas from the 1x00 Control Matrix:

- **CM-IAM-01: MFA for All Users** - especially administrators and remote/cloud access.
- **CM-IAM-02: Privileged Access Management** - restrict global administrator rights.
- **CM-LOG-02: Cloud Audit Logging** - monitor sign-ins, mailbox rules, OAuth grants, and admin actions.
- **CM-DATA-02: Data Loss Prevention** - limit exposure of sensitive patient or business data in cloud storage.
- **CM-VRM-01: Vendor Risk Management** - assess cloud provider risk and contractual responsibilities.

**Risk Assessment:**  
**Critical**  
Microsoft services are organization-wide. A compromise of identity or tenant administration could affect email, documents, authentication, and downstream application access. Even if Microsoft itself is not breached, compromise of MedDefense's Microsoft tenant would be a major enterprise incident.

---

## Vendor 3: Sophos

**Service:**  
Endpoint protection platform. Sophos agents are installed on all managed MedDefense endpoints and can receive updates and configuration changes.

**Access Type:**  
Application and endpoint management access.  
Sophos has a privileged software agent on managed endpoints.

**Access Scope:**  
Sophos can reach or influence:

- Workstations
- Servers with installed endpoint agents
- Security policies and endpoint configurations
- Malware quarantine and detection settings
- Potentially remote response features, depending on licensing
- Update channels used to push agent or policy changes

**Compromise Scenario:**  
If Sophos management infrastructure, update channel, or MedDefense's Sophos admin console is compromised, an attacker could push malicious configurations, disable protection, whitelist malware, deploy malicious updates, or reduce detection before ransomware deployment. Because the endpoint agent is widely deployed and trusted, a compromised security platform could become a high-impact software supply chain attack path.

**Existing Controls:**  
Referenced control areas from the 1x00 Control Matrix:

- **CM-END-01: Endpoint Protection Management** - endpoint protection should be centrally managed and monitored.
- **CM-IAM-02: Privileged Access Management** - restrict access to the Sophos console.
- **CM-LOG-01: Security Logging and Monitoring** - monitor security-tool policy changes and disablement events.
- **CM-VRM-02: Vendor Security Review** - require vendor assurance for update integrity and incident notification.

**Risk Assessment:**  
**High**  
Sophos has broad reach across endpoints. A compromise could disable defenses or deliver malicious updates. The risk is high because endpoint tooling is powerful, but the impact depends on console privileges, update integrity, and whether MedDefense monitors policy changes.

---

## Vendor 4: Siemens

**Service:**  
MRI scanner manufacturer. Siemens provides periodic maintenance for the MRI scanner, including the Windows XP workstation and firmware updates.

**Access Type:**  
Physical, application, and medical device maintenance access.  
Siemens has access to specialized medical equipment and an associated legacy workstation.

**Access Scope:**  
Siemens can reach or influence:

- MRI scanner system
- Windows XP workstation connected to the MRI environment
- Scanner firmware or maintenance tools
- Local imaging data generated by the MRI system
- Possibly PACS integration pathways if the MRI workstation sends images to PACS
- Medical device network segment, if not isolated

**Compromise Scenario:**  
If Siemens maintenance credentials, laptop, firmware package, or remote support process is compromised, malware could be introduced to the MRI workstation or device environment. Because the workstation runs Windows XP, it is likely difficult to patch and may be vulnerable to legacy malware. If the MRI system is connected to PACS or the broader clinical network, an attacker could pivot from the medical device environment into imaging systems or other internal systems. The attacker could also disrupt MRI availability, affecting patient care and diagnostics.

**Existing Controls:**  
Referenced control areas from the 1x00 Control Matrix:

- **CM-MD-01: Medical Device Security** - maintain inventory, segmentation, and compensating controls for legacy medical devices.
- **CM-NET-02: Network Segmentation** - isolate medical device networks from general IT and server networks.
- **CM-CHG-01: Change Management** - validate firmware and maintenance updates.
- **CM-VRM-01: Vendor Risk Management** - require controlled vendor maintenance procedures.

**Risk Assessment:**  
**High**  
The Siemens environment includes a legacy Windows XP workstation and medical device connectivity. The risk is high because compromise could affect patient care and provide a pivot path, especially if medical devices are not segmented. It is not rated Critical unless the MRI network has broad access to EHR, PACS, or Active Directory.

---

## Vendor 5: Greenfield Building Management

**Service:**  
HQ office building management. Greenfield manages the building network infrastructure, and MedDefense has a VLAN on their network.

**Access Type:**  
Network and physical infrastructure access.  
Greenfield controls or manages the building network infrastructure on which MedDefense has a VLAN.

**Access Scope:**  
Greenfield may be able to reach or influence:

- Building switches or network infrastructure
- VLAN configuration
- Network routing or trunk ports
- Physical network closets
- Potentially traffic paths used by MedDefense offices
- Connectivity between MedDefense VLAN and shared building infrastructure

**Compromise Scenario:**  
If Greenfield is compromised, an attacker could gain access to building network management systems, modify VLAN configurations, sniff traffic, attempt VLAN hopping, create unauthorized ports, or disrupt MedDefense connectivity. If MedDefense's VLAN is not properly isolated, the attacker could attempt to reach internal MedDefense systems from the building infrastructure. Physical access to network closets could also allow rogue devices to be connected.

**Existing Controls:**  
Referenced control areas from the 1x00 Control Matrix:

- **CM-NET-01: Network Boundary Protection** - MedDefense traffic should be isolated from third-party building networks.
- **CM-NET-02: Network Segmentation** - VLANs should be strictly separated with firewall enforcement.
- **CM-PHY-01: Physical Security** - network closets and infrastructure should be access controlled.
- **CM-VRM-01: Vendor Risk Management** - building management provider should be assessed as a network-risk vendor.

**Risk Assessment:**  
**Medium to High**  
The risk is medium to high depending on whether MedDefense's VLAN is isolated by firewall controls or only by shared switching configuration. If Greenfield can modify VLANs or access switch management, the risk becomes high because a building-management compromise could become a network compromise.

---

## Supply Chain Risk Summary

The single vendor compromise that would cause the most direct damage to MedDefense is **MedTech Solutions**, because it has direct maintenance access to the EHR server, which contains or processes regulated patient data and supports clinical operations. A MedTech compromise could immediately become an EHR compromise, leading to patient-data theft, clinical disruption, ransomware staging, or loss of trust in the integrity of medical records. Microsoft is also critical because it controls organization-wide email, collaboration, and possibly identity through Entra ID, but MedTech's direct path to the EHR makes it the most dangerous vendor in the specific clinical context James Chen is worried about. The first control MedDefense should implement across all vendors is **centralized third-party access management with MFA, least privilege, time-bound access, session logging, and periodic access review**. This one control reduces the blast radius of vendor compromise across network, application, cloud, medical device, and physical infrastructure vendors.

---

## Summary Table

| Vendor | Service | Access Type | Access Scope | Risk |
|---|---|---|---|---|
| MedTech Solutions | EHR maintenance | Network / Application | EHR server, patient data, maintenance tools | Critical |
| Microsoft | O365 E3 / possible Entra ID | Application / Data / Identity | Email, SharePoint, OneDrive, identity | Critical |
| Sophos | Endpoint protection | Application / Endpoint management | Managed endpoints, agent policies, updates | High |
| Siemens | MRI scanner maintenance | Physical / Application / Medical device | MRI, Windows XP workstation, firmware, PACS pathway | High |
| Greenfield Building Management | Building network infrastructure | Network / Physical | Building network, MedDefense VLAN, network closets | Medium to High |

