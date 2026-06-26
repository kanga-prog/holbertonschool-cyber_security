# MedDefense Health Systems Security Posture Assessment

## 1. Executive Summary

MedDefense Health Systems has a functioning baseline of security controls, including a perimeter firewall, VPN connectivity, Active Directory, endpoint protection, backups, vendor support contracts, badge access, and limited physical security. However, the current posture is **not sufficient for a healthcare organization that handles protected health information for more than 50,000 patients and depends on digital systems for clinical care**. The organization is over-reliant on perimeter controls while internal networks, medical devices, backups, monitoring, identity controls, and response processes remain under-protected.

The single most critical finding is the **flat internal network**: workstations, servers, medical devices, backup infrastructure, and inter-site networks can reach one another without meaningful segmentation. This weakness amplifies nearly every other risk because a compromised workstation, VPN account, Shadow IT device, or medical IoT system could become a path to EHR, PACS, Active Directory, billing, backups, or patient-care devices.

The top three recommended actions are:

1. **Implement internal segmentation for critical zones**: servers, clinical endpoints, medical IoT, backups, administrative systems, and guest/WiFi traffic.
2. **Establish centralized logging and monitoring for critical systems**: Active Directory, FortiGate, EHR, billing, backups, web systems, and medical-device-adjacent networks.
3. **Strengthen recovery and identity resilience**: immutable/offsite backups, tested recovery procedures, MFA for VPN/admin/O365/EHR access, and formal incident response.

The first-year security plan fits within the proposed **$120,000 annual budget** by prioritizing controls that reduce risk across multiple critical assets instead of purchasing one expensive standalone tool.

---

## 2. Scope and Methodology

### 2.1 Scope

The assessment covered the following MedDefense environments:

- **MedDefense Central Hospital**
  - Core hospital operations, Emergency, Surgery, Cardiology, Radiology, Oncology, Pediatrics, Maternity, Pharmacy, Laboratory, and Administration.
  - Server room, network closet, clinical workstations, thin clients, medical IoT, WiFi, and physical access controls.

- **Westside Clinic**
  - Outpatient services, local server, X-ray workstation, workstations, consumer router, and site-to-site VPN to Central.

- **Corporate HQ**
  - Finance, HR, Legal, Marketing, Executive Leadership, IT operations, workstations, laptops, landlord-managed network/VLAN, and VPN connectivity.

- **Cloud and external services**
  - Microsoft O365 E3, vendor support contracts, Shadow IT cloud storage, and externally exposed patient-facing services.

### 2.2 Systems and Data Assessed

The assessment included:

- EHR system and database.
- PACS, imaging systems, MRI, CT, X-ray, and Radiology workflows.
- Billing, claims, and insurance processing infrastructure.
- Active Directory and identity infrastructure.
- Backup infrastructure, Veeam, and NAS storage.
- Clinical and administrative endpoints.
- Medical IoT devices, including monitors, infusion pumps, nurse call, and badge readers.
- Physical security controls around critical infrastructure.
- Patient portal and public website.
- HR, finance, legal, executive, and administrative data.
- Shadow IT systems: personal NAS, personal Google Drive, abandoned Raspberry Pi, and scan-discovered unknown systems.

### 2.3 Sources of Information Used

This assessment consolidates evidence from:

- Onboarding documentation and environment summary.
- Network scan summary for `10.10.0.0/16`.
- Incident classification and root-cause analysis.
- Physical walk-through observations.
- Asset registry and asset criticality assessment.
- Data map and data classification analysis.
- Complete control matrix.
- Shadow IT assessment.
- Prioritized gap analysis and healthcare breach reality check.
- Marcus Webb's predecessor draft assessment.
- Risk treatment decisions prepared under the $120,000 budget constraint.

### 2.4 Limitations and Assumptions

- The network scan may not include devices powered off during the scan window.
- Some endpoint counts come from older documentation and scan summaries that omit repetitive devices for brevity.
- Medical device operating systems and firmware details are incomplete for some devices.
- Cloud service usage is not fully inventoried.
- Some proposed compensating controls, especially for the MRI workstation, are documented as recommendations and are not yet confirmed as implemented.
- Risk ratings are based on available evidence and should be updated after remediation, validation testing, and external threat landscape analysis.

---

## 3. Asset Landscape

### 3.1 Asset Inventory Summary

The consolidated asset inventory contains **58 assets** after adding Shadow IT systems from the helpdesk disclosure.

### 3.2 Asset Count by Type

| Asset Type | Count | Examples |
|---|---:|---|
| Physical Infrastructure | 7 | Central Hospital, Westside Clinic, Corporate HQ, server room, network closet, emergency exit, HID badge readers |
| Servers | 12 | `ehr-srv-01`, `pacs-srv-01`, `billing-srv-01`, domain controllers, `web-srv-01`, `UNKNOWN-01` |
| Data Stores | 4 | `ehr-db-01`, `NAS-01`, HR file share, Dr. Patel personal NAS |
| Network Devices | 8 | FortiGate 100F, Cisco switches, UniFi APs, Netgear router, HQ VLAN/building network, Raspberry Pi monitor |
| Endpoints | 14 | Nurse workstations, admin workstations, pharmacy workstations, lab workstations, HQ laptops, physician iPads, intern laptop |
| Medical IoT | 6 | MRI workstation, Philips monitors, BD Alaris pumps, nurse call, vital signs monitor, CT scanner |
| Applications and Cloud Services | 7 | O365, Sophos, Veeam, patient portal, public website, pharmacy management system, Marketing Google Drive |
| **Total** | **58** |  |

### 3.3 Asset Count by Site or Primary Association

| Site / Association | Count | Notes |
|---|---:|---|
| Central Hospital | 40 | Primary concentration of clinical systems, servers, medical IoT, network infrastructure, physical risks, and Shadow IT |
| Westside Clinic | 6 | Clinic server, workstations, X-ray workstation, Netgear router, undocumented Linux device |
| Corporate HQ | 4 | HQ workstations, laptops, building-managed VLAN/network, administrative operations |
| Enterprise / Cloud / Shared Services | 8 | O365, Sophos, patient portal, public website, pharmacy system, HR file share, Marketing Google Drive, cross-site service functions |
| **Total** | **58** | Counted by primary association; some enterprise services support multiple sites |

### 3.4 Top 5 Critical Assets

| Rank | Critical Asset | Justification |
|---:|---|---|
| 1 | EHR System (`ehr-srv-01`, `ehr-db-01`) | Core clinical record system. Compromise affects patient care, physician decision-making, protected health information, regulatory exposure, and clinical continuity. |
| 2 | Network Core and Site Connectivity | Provides connectivity between Central, Westside, HQ, servers, workstations, WiFi, VPNs, and medical devices. A flat network makes any compromise enterprise-wide. |
| 3 | Medical IoT and Nurse Call Systems | Includes patient monitors, infusion pumps, vital signs monitoring, and nurse call systems. Compromise can directly affect patient safety and care delivery. |
| 4 | PACS, Imaging, and Radiology Systems | Supports diagnosis and treatment decisions. Includes PACS and the legacy MRI workstation, which is clinically required but cannot be patched or replaced immediately. |
| 5 | Identity and Access Infrastructure | Active Directory and badge integration control logical and some physical access. Compromise enables broad unauthorized access across systems and sites. |

### 3.5 Data Classification Summary

| Classification | Major Data Categories | Business Impact |
|---|---|---|
| Restricted | Patient records, lab results, imaging data, medication dosage data, billing/insurance data, credentials, backups | Severe regulatory, legal, patient safety, and reputational impact |
| Confidential | HR records, salaries, legal files, finance records, executive communications, vendor contracts | Significant internal, financial, and legal harm |
| Internal | Internal notes, org charts, operational documentation, diagrams, IT notes | Operational exposure and attacker reconnaissance value |
| Public | Public website content, public phone numbers, public-facing communications | Low confidentiality impact, but integrity failure can damage trust |

---

## 4. Current Security Controls

### 4.1 Control Inventory Summary

The complete control matrix identifies **32 security controls**.

### 4.2 Controls by Category

| Control Category | Count | Overall Effectiveness |
|---|---:|---|
| Technical | 19 | Mixed. Strongest around perimeter and proposed compensating controls; weakest around internal segmentation and monitoring. |
| Administrative | 8 | Mixed to weak. Vendor contracts exist, but incident response, change management, vulnerability management, and governance are incomplete. |
| Physical | 5 | Weak. Badge access, cameras, guard service, and UPS exist but do not adequately protect critical infrastructure. |
| **Total** | **32** |  |

### 4.3 Controls by Function

| Control Function | Count | Overall Effectiveness |
|---|---:|---|
| Preventive | 17 | Moderate at the perimeter, weak internally. |
| Detective | 3 | Weak. Limited cameras, endpoint protection, and proposed monitoring do not provide enough enterprise detection. |
| Corrective | 8 | Weak to adequate. Backups and vendor support exist, but recovery is not resilient or well tested. |
| Compensating | 3 | Strong where designed for MRI, but not broadly implemented. |
| Deterrent | 1 | Weak. Guard service is limited in hours and site coverage. |
| **Total** | **32** |  |

### 4.4 Overall Maturity Assessment

MedDefense has foundational security components but lacks mature defense-in-depth. The organization is strongest in basic perimeter presence, vendor support contracts, Active Directory authentication, and basic backup tooling. It is weakest in internal segmentation, centralized monitoring, MFA coverage, backup resilience, medical device isolation, formal incident response, vulnerability management, DLP, change management, and Shadow IT governance.

### 4.5 Key Control Effectiveness Findings

- The FortiGate perimeter firewall exists, but internal segmentation is not enforced.
- VPN connectivity exists, but VPN ACLs and MFA coverage are insufficient.
- Active Directory exists, but password-only access and shared credentials weaken accountability.
- Sophos endpoint protection is contracted, but coverage and currency are not validated.
- Backups exist, but the local NAS shares the same physical and network failure domain as production.
- Physical controls exist, but generic server room badges, limited camera coverage, and unlocked closets create infrastructure risk.
- Proposed MRI compensating controls are strong but are not yet implemented.
- Administrative controls are incomplete: no formal IR plan, no formal change management, no mature vulnerability management, and no complete cloud/Shadow IT governance.

---

## 5. Gap Analysis

### 5.1 Critical Gaps

| Gap ID | Description | Affected Assets | Potential Impact | Recommended Treatment |
|---|---|---|---|---|
| GAP-001 | No effective internal network segmentation | Network core, EHR, PACS, medical IoT, AD, billing, backups | A single compromised device can reach critical systems across the enterprise; ransomware or lateral movement can become hospital-wide. | Mitigate through VLANs, ACLs, internal firewall rules, and phased critical-zone segmentation. |
| GAP-002 | EHR database broadly accessible from internal network | `ehr-db-01`, `ehr-srv-01` | Unauthorized internal access attempts against the most sensitive clinical database; possible PHI breach or record manipulation. | Restrict PostgreSQL to `ehr-srv-01`, apply host firewall rules, and monitor database access. |
| GAP-003 | Medical IoT exposed to entire internal network | Philips monitors, BD Alaris pumps, vital signs monitors, nurse call | Device compromise may affect monitoring, dosage workflows, and patient safety. | Segment medical devices, restrict management interfaces, review credentials, and coordinate with Biomedical Engineering. |
| GAP-004 | Legacy MRI workstation on general network | MRI workstation, PACS, Radiology | Unpatchable Windows XP system can become a pivot or disrupt imaging studies. | Implement MRI dedicated VLAN, MRI-to-PACS allowlist, passive monitoring, and formal risk exception. |
| GAP-005 | Backup architecture not resilient against ransomware or physical co-failure | `backup-srv-01`, Veeam, `NAS-01` | Production and backups can be encrypted together; prolonged inability to restore EHR, billing, file shares, or PACS. | Add immutable/offsite backup, restrict NAS access, monitor backup jobs, and test restores. |
| GAP-006 | No formal incident response plan | All critical systems | Delayed containment, inconsistent escalation, poor evidence handling, and longer downtime during incidents. | Create IR plan, playbooks, escalation matrix, and tabletop exercise. |
| GAP-007 | Patient portal authorization controls insufficient | Patient portal, `web-srv-01`, patient lab results | Authenticated users may access other patients' lab results; regulatory and legal exposure. | Perform application authorization review, logging, secure code testing, and access anomaly monitoring. |
| GAP-008 | Organization-wide MFA missing | VPN, O365, AD, EHR, admin accounts | Stolen credentials can enable remote access, privileged access, or PHI theft. | Deploy MFA first for VPN, admin, O365, and remote access; extend to EHR where feasible. |
| GAP-010 | Weak physical security around critical infrastructure | Server room, network closet, servers, backups, network core | Unauthorized access to infrastructure, rogue devices, credential theft, service disruption. | Restrict badge access, lock closets, remove posted credentials, add camera coverage and visitor logs. |
| GAP-012 | No formal vulnerability management program | Servers, endpoints, apps, medical IoT, network devices | Known vulnerabilities remain exploitable, including public-facing systems, EOL systems, and medical devices. | Launch recurring scanning, remediation tracking, patch SLAs, and exception process. |
| GAP-013 | Database and management interfaces exposed internally | EHR DB, billing DB, NAS, management services | Internal attacker can target databases and backup management interfaces. | Enforce host-based restrictions, management network isolation, and access monitoring. |
| GAP-014 | Lack of centralized logging and security monitoring | All Critical and High assets | Attacks may persist for days or weeks without detection; difficult breach investigation. | Deploy centralized logs, alerts, NDR/SIEM-lite or managed detection, and review process. |
| GAP-015 | No automated account lifecycle and offboarding control | AD, VPN, O365, EHR, file shares | Former staff may retain access to PHI and internal systems. | Integrate HR termination with account deactivation and dormant account monitoring. |
| GAP-016 | No DLP or sensitive data export monitoring | EHR, O365, file shares, billing, HR | Bulk export of PHI or Confidential data may occur without alerts. | Implement DLP/export monitoring for EHR, O365, file shares, USB, and cloud uploads. |
| GAP-017 | DMZ egress and internal reachability not validated | `web-srv-01`, patient portal, internal servers | Public web compromise may pivot into internal clinical systems. | Validate DMZ placement, restrict outbound DMZ traffic, and alert on unusual egress. |
| GAP-018 | Medical device default credential governance missing | Medical IoT and nurse call systems | Default or unmanaged credentials can allow unauthorized management access. | Inventory device credentials, remove defaults, restrict access, and monitor management logins. |
| GAP-023 | No formal change management process | Servers, network devices, backups, pharmacy, EHR, PACS | Poorly tested changes can break backups, corrupt clinical data, or expose systems. | Establish change approval, testing, rollback planning, documentation, and post-change review. |

### 5.2 High Gaps

| Gap ID | Description | Affected Assets | Potential Impact | Recommended Treatment |
|---|---|---|---|---|
| GAP-009 | Shadow IT stores or processes sensitive data outside governance | Personal NAS, personal Google Drive, Raspberry Pi, unknown Linux systems | Sensitive data exposure, unmanaged attack paths, loss of organizational control over data. | Migrate unauthorized storage, legitimize useful monitoring, decommission unmanaged systems, and enforce asset approval policy. |
| GAP-011 | HR and administrative data reachable from unmanaged or poorly controlled endpoints | HR file share, HQ endpoints, administrative systems | Employee data or legal/financial data may be exposed through unmanaged devices. | Implement NAC/device compliance, HR segmentation, endpoint validation, and alerts. |
| GAP-019 | Security governance authority not aligned with IT operational control | All critical remediation areas | Known risks may remain unresolved due to unclear authority and accountability. | Define risk ownership, escalation rights, implementation accountability, and Board-level reporting. |
| GAP-020 | Legacy TLS enabled on patient portal | Patient portal, `web-srv-01` | Patient-facing transport security weakness and compliance concern. | Disable TLS 1.0, validate external web configuration, and include in recurring scans. |
| GAP-021 | Unrestricted removable media on workstations | Clinical and administrative endpoints | PHI, HR data, or internal documents can be copied to USB without detection. | Apply USB storage restrictions, exception process, and removable media monitoring. |
| GAP-022 | Limited assurance over landlord-managed HQ network | Corporate HQ, VPN, finance, HR, legal, executive systems | Shared infrastructure risk may affect HQ and VPN path to Central. | Review contract/security requirements, validate VLAN isolation, and restrict VPN ACLs. |

### 5.3 Medium and Low Gaps

No Medium or Low gaps are emphasized in the Board-level priority set. Lower-value risks such as the print server still require remediation, but they are included under broader Critical or High programs such as vulnerability management and lifecycle management.

### 5.4 Gap Distribution Analysis

| Risk Level | Count |
|---|---:|
| Critical | 17 |
| High | 6 |
| Medium | 0 |
| Low | 0 |
| **Total** | **23** |

### 5.5 Most Exposed Areas

The gaps are concentrated in five areas:

1. **Network architecture**: flat network, broad reachability, weak VPN ACLs, uncertain DMZ separation.
2. **Detection and response**: no centralized monitoring, no formal IR plan, weak log review.
3. **Clinical technology**: EHR database exposure, PACS, MRI, medical IoT, nurse call, pharmacy integrity.
4. **Identity and data protection**: missing MFA, weak offboarding, shared credentials, no DLP/export monitoring.
5. **Recovery and governance**: fragile backups, no formal change management, Shadow IT, weak authority alignment.

The most important pattern is that MedDefense is prevention-heavy at the perimeter but weak in internal containment, detection, and recovery.

---

## 6. Risk Treatment Recommendations

### 6.1 Seven Priority Recommendations

| Priority | Gap(s) Addressed | Treatment Strategy | Recommendation | Estimated Cost | Timeline |
|---:|---|---|---|---:|---|
| 1 | GAP-001, GAP-003, GAP-004, GAP-013, GAP-017 | Mitigate | Implement internal segmentation for servers, medical devices, backups, clinical endpoints, admin endpoints, guest WiFi, DMZ, and VPN routes. | $35,000 | Long-term > 1 month |
| 2 | GAP-014, GAP-007, GAP-015, GAP-016, GAP-018 | Mitigate | Deploy centralized logging and scoped monitoring for AD, FortiGate, servers, EHR, billing, backups, portal, and high-risk medical-device-adjacent traffic. | $35,000 | Short-term start, long-term tuning |
| 3 | GAP-005 | Mitigate | Add immutable/offsite backup capability, restrict NAS access, validate backup jobs, and test recovery for EHR, billing, AD, file shares, and PACS. | $25,000 | Short-term and long-term |
| 4 | GAP-006 | Mitigate | Build an incident response plan, ransomware playbook, credential compromise playbook, patient portal breach playbook, medical device incident playbook, and run a tabletop exercise. | $8,000 | Short-term < 1 month |
| 5 | GAP-012, GAP-020, GAP-023 | Mitigate | Launch vulnerability and configuration management: recurring scans, patch SLAs, TLS remediation, EOL tracking, change approval, and exception tracking. | $7,000 | Short-term start, long-term maturity |
| 6 | GAP-008, GAP-015 | Mitigate | Deploy MFA for VPN, privileged accounts, O365, remote access, and EHR where vendor-supported. | $8,000 | Short-term < 1 month for first phase |
| 7 | GAP-003, GAP-018 | Mitigate | Start medical IoT access restrictions and credential governance with Biomedical Engineering. | $2,000 incremental | Short-term start, long-term maturity |

### 6.2 Budget Allocation

| Initiative | Allocation |
|---|---:|
| Internal segmentation for critical zones | $35,000 |
| Centralized logging and scoped monitoring | $35,000 |
| Backup resilience and recovery testing | $25,000 |
| Incident response plan and tabletop exercise | $8,000 |
| Vulnerability management and change governance launch | $7,000 |
| MFA rollout for privileged, VPN, O365, and remote access | $8,000 |
| Medical IoT access restrictions and credential review | $2,000 |
| **Total** | **$120,000** |

### 6.3 Quick Wins: Implementable Within 1 Week

| Quick Win | Gap(s) Addressed | Expected Benefit |
|---|---|---|
| Disable TLS 1.0 on patient portal after compatibility testing | GAP-020 | Removes a known legacy protocol weakness from a patient-facing system. |
| Remove posted network credentials from the unlocked closet and change exposed credentials | GAP-010, GAP-023 | Reduces immediate physical-to-logical compromise risk. |
| Validate current backup job status and alert on failures | GAP-005 | Reduces chance of silent backup failure. |
| Start MFA enrollment for IT admins and VPN users where available through existing licensing | GAP-008 | Quickly reduces credential abuse risk for high-impact users. |
| Locate and isolate the Raspberry Pi and unknown Shadow IT systems | GAP-009 | Removes unmanaged footholds from the internal network pending review. |
| Document temporary IR escalation contacts and decision roles | GAP-006 | Provides immediate response structure while the full plan is built. |
| Review FortiGate rules for obvious DMZ-to-internal over-permissiveness | GAP-017 | Reduces public-web-to-internal pivot risk. |

### 6.4 Short-Term Priorities: Within 1 Month

| Priority | Gap(s) Addressed | Outcome |
|---|---|---|
| Launch formal incident response plan and tabletop | GAP-006 | Faster, more consistent response to ransomware, portal breach, credential abuse, and medical device incidents. |
| Roll out MFA to VPN, privileged users, O365, and high-risk remote access | GAP-008, GAP-015 | Reduces the likelihood that stolen passwords become enterprise compromise. |
| Begin critical log onboarding and alerting | GAP-014 | Improves detection for authentication abuse, backup failure, server compromise, and portal anomalies. |
| Start vulnerability management program | GAP-012, GAP-020 | Tracks known vulnerabilities, patch SLAs, EOL systems, and external-facing exposure. |
| Begin backup resilience improvements | GAP-005 | Improves recoverability from ransomware and operational failures. |
| Replace Westside consumer router and lock server closet if feasible within local facilities budget | GAP-001, GAP-009, GAP-010, GAP-022 | Reduces weak-site exposure to Central. |

### 6.5 Long-Term Roadmap Items

| Roadmap Item | Gap(s) Addressed | Rationale |
|---|---|---|
| Full internal network redesign and segmentation | GAP-001, GAP-003, GAP-004, GAP-013, GAP-017 | Required to reduce blast radius across the enterprise. |
| Mature SIEM/SOC or managed detection program | GAP-014, GAP-016, GAP-018 | Needed for sustained detection and investigation capability. |
| Full DLP implementation for EHR exports, O365, file shares, USB, and cloud uploads | GAP-016, GAP-021 | Required to reduce insider and credential-abuse data exfiltration risk. |
| Medical device security program with Biomedical Engineering | GAP-003, GAP-018 | Required for safe long-term medical IoT management. |
| Formal BCP/DR program and recurring recovery exercises | GAP-005, GAP-006 | Required to maintain clinical operations during extended outages. |
| Governance and authority alignment | GAP-019, GAP-023 | Ensures critical security decisions become funded, assigned, implemented, and reviewed. |
| External Threat Landscape Assessment and STRIDE threat model | All major gaps | Connects internal posture to real attacker behavior and future budget priorities. |

---

## 7. Conclusion and Next Steps

### 7.1 Business-Level Posture Summary

MedDefense is operating with several important security building blocks, but the organization does not yet have a mature healthcare security posture. The primary business risk is not the absence of all security; it is the lack of defense-in-depth around the systems that matter most: EHR, medical devices, imaging, identity, backups, and inter-site connectivity.

The current posture creates three major business risks:

1. **Clinical disruption risk**: EHR, PACS, medical IoT, and network outages could affect patient care.
2. **Regulatory and legal risk**: Restricted patient data and Confidential business data are exposed through weak segmentation, missing DLP, poor monitoring, and Shadow IT.
3. **Recovery risk**: backups and incident response are not resilient enough to guarantee rapid recovery from ransomware or system compromise.

### 7.2 Consequence of Inaction

If the recommendations are not implemented, MedDefense remains exposed to the same failure patterns observed in recent healthcare breaches: ransomware spreading across flat networks, credential abuse without MFA, patient data access without detection, medical device compromise, and backup failure during recovery. The likely outcome is not a minor IT disruption; it could be prolonged EHR downtime, cancelled procedures, ambulance diversion, regulatory investigation, breach notification, litigation, reputational damage, and avoidable patient safety risk.

### 7.3 Next Phase: External Threat Landscape Assessment

Marcus Webb's unfinished assessment correctly stated that internal posture is only half of the risk picture. This assessment identifies where MedDefense is weak; the next phase should identify who is most likely to exploit those weaknesses and how. A formal **External Threat Landscape Assessment** should profile relevant threat actor categories such as ransomware operators, credential thieves, insiders, opportunistic botnets, and medical-device-focused attackers. It should map their tactics, techniques, and procedures to MedDefense's architecture using CISA, HHS 405(d), HC3, MITRE ATT&CK, and STRIDE threat modeling.

### 7.4 Final Recommendation

The Board should approve the first-year **$120,000 security investment** and require quarterly reporting on segmentation, monitoring, backup resilience, MFA rollout, incident response readiness, vulnerability management, and medical IoT containment. These investments do not solve every problem, but they directly reduce the highest-risk pathways to patient data exposure, clinical downtime, and enterprise-wide compromise.


