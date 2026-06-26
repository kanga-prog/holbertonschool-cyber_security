# Predecessor Review

## Purpose

This document critically evaluates Marcus Webb's unfinished draft assessment against the security posture assessment completed for MedDefense Health Systems. The review compares Marcus's findings with the current assessment, validates or challenges his conclusions, identifies findings he raised that were previously missed, and connects his unfinished threat landscape notes to the next phase of the security program.

## Part 1: Comparative Analysis

| Finding | Marcus's Assessment | Your Assessment | Agree/Disagree | Resolution |
|---|---|---|---|---|
| M-01: Network Segmentation | Marcus rated the flat network as **Critical** and described it as the single most dangerous finding. He stated that all devices share `10.10.0.0/16`, with no VLANs or internal firewalls. | Confirmed and expanded. The network scan confirmed that all internal subnets are reachable from HQ without access restrictions. This maps directly to **GAP-001: No Effective Internal Network Segmentation** and affects Critical assets such as EHR, PACS, AD, billing, backups, and medical IoT. | Agree | Marcus's conclusion is valid and fully supported. This remains one of the highest-priority gaps and is selected for first-year mitigation in the risk treatment plan. |
| M-02: Backup Isolation | Marcus rated backup isolation as **Critical** because `NAS-01` is in the same server room and on the same network as production systems. He warned that ransomware could encrypt production and backup simultaneously. | Confirmed. The asset registry and scan identify `backup-srv-01` and `NAS-01`; the gap analysis documents weak backup resilience as **GAP-005**. The January ransomware incident also showed backup reliability issues because the available backup was three weeks old. | Agree | Marcus's finding is correct. It is retained as Critical and should be mitigated through immutable or offsite backup replication, NAS access restriction, backup monitoring, and recovery testing. |
| M-03: Medical IoT Exposure | Marcus rated medical IoT exposure as **High**, potentially **Critical**, due to patient safety implications. He identified Philips monitors, BD Alaris pumps, nurse call, and badge readers on the same network as workstations and servers. | Confirmed and upgraded to Critical in the current assessment. The scan confirms medical devices expose HTTP/HTTPS management interfaces across the internal network, and BD Alaris firmware has known CVEs with network isolation recommended. This maps to **GAP-003** and **GAP-018**. | Agree, with severity adjustment | Marcus understated the final severity by rating it High with a possible Critical note. The current assessment resolves it as Critical because the affected devices can impact patient safety, clinical operations, and Restricted data. |
| M-04: Absence of Monitoring and Detection | Marcus rated monitoring absence as **High** and stated that MedDefense has no SIEM, IDS/IPS, log centralization, alerting, retention policy, or review process. | Confirmed and upgraded to Critical. The current assessment maps this to **GAP-014: Lack of Centralized Logging and Security Monitoring**. Healthcare breach validation showed that weak detection leads to long dwell time and delayed response. | Agree, with severity adjustment | Marcus correctly identified the weakness. The current assessment increases the risk level to Critical because the gap affects all Critical assets and Restricted data with no reliable detective capability. |
| M-05: No MFA on Any System | Marcus rated MFA absence as **High** and stated that VPN, EHR, Active Directory admin accounts, and the patient portal admin panel rely on username and password alone. | Confirmed and upgraded to Critical after the reality check. This maps to **GAP-008: Organization-Wide MFA Is Missing**. Credential abuse in healthcare breach examples shows that password-only access can directly expose PHI. | Agree, with severity adjustment | Marcus's recommendation to prioritize VPN, admin accounts, and EHR MFA is valid. The current plan includes MFA rollout as a first-year mitigation item. |
| M-06: Westside Clinic Security | Marcus rated Westside as **High** because it uses a consumer Netgear router, has no firewall, no managed switches, weak physical security, and a server closet that does not lock. | Confirmed. The scan identifies the Netgear router at `10.10.10.1`, the Westside VPN, `ws-srv-01`, workstations, X-ray workstation, and an undocumented Linux device at `10.10.10.200`. Westside is included in **GAP-001**, **GAP-009**, and Shadow IT exposure. | Agree | Marcus was correct. His recommended FortiGate 60F replacement, server closet lock, and VPN ACL review should be treated as practical quick wins within the broader segmentation plan. |
| M-07: Shared Credentials in Radiology | Marcus rated shared Radiology credentials as **Medium**, noting that `raduser/radiology1` eliminates accountability on PACS access. | Confirmed, but the current assessment treats this as more serious when combined with Critical PACS/imaging assets, Restricted imaging data, and weak monitoring. It supports **GAP-008**, **GAP-014**, and the PACS/Imaging criticality assessment. | Partially agree | The finding is valid, but the severity should be raised to High in practice because shared credentials affect patient imaging data and prevent reliable auditability. Marcus's smart card or proximity badge recommendation is appropriate. |
| M-08: Print Server End of Life | Marcus rated `print-srv-01` as **Low**, arguing that it is low value and internal-only. | Partially confirmed. The scan confirms `print-srv-01` at `10.10.2.31` running Windows Server 2012 with print ports exposed. However, because the network is flat, internal-only does not meaningfully reduce risk. | Partially disagree | The asset itself may be lower value than EHR or PACS, but in a flat network an EOL print server can become a pivot point. It should remain below clinical systems in priority but be tracked under **GAP-012: No Formal Vulnerability Management Program** as at least Medium risk. |
| TLS 1.0 on Patient Portal | Marcus identified that `web-srv-01` uses TLS 1.0 alongside TLS 1.2 and recommended disabling TLS 1.0. | This was not explicitly documented in the earlier gap analysis. It affects the patient portal and public-facing web services. | Agree; missed finding | Valid new gap. Add **GAP-020: Legacy TLS Enabled on Patient Portal** to the gap register. |
| No DLP Controls | Marcus identified that patient records and financial data can be exfiltrated through email, USB, or cloud upload with no detection or prevention. | Confirmed by the reality check and already documented as **GAP-016: No DLP or Sensitive Data Export Monitoring**. | Agree | Marcus's finding was valid and was independently confirmed through breach validation. It should remain Critical because it affects Restricted and Confidential data. |
| Unrestricted USB Storage | Marcus identified unrestricted USB ports on all workstations and noted that this is significant when combined with no DLP. | This was not explicitly documented as its own gap in Task 12. It is related to DLP, endpoint control, and data-in-use/data-transfer protection. | Agree; missed finding | Valid new gap. Add **GAP-021: Unrestricted Removable Media on Workstations** to the gap register. |
| HQ Building Management Network Risk | Marcus identified that HQ network infrastructure is managed by the landlord and MedDefense lacks visibility into the security of shared building infrastructure. | The asset registry documented the landlord-managed HQ network and MedDefense VLAN, but the gap analysis did not fully document the visibility and assurance risk. | Agree; missed finding | Valid new gap. Add **GAP-022: Limited Security Assurance Over Landlord-Managed HQ Network**. |
| No Formal Change Management | Marcus identified that server and network changes are made ad hoc without documentation, testing, or approval. He linked this to the broken cron job that caused the three-week backup gap. | This was underdeveloped in the previous analysis. It directly affects backup reliability, database updates, network changes, and clinical application integrity. | Agree; missed finding | Valid new gap. Add **GAP-023: No Formal Change Management Process**. |
| External Threat Landscape | Marcus stated that internal posture is only half the equation and that a formal threat landscape report is needed. | Confirmed. The reality check against healthcare breaches showed that MedDefense's gaps align with ransomware, credential abuse, web application compromise, and medical device pivot patterns. | Agree | Marcus's unfinished work should become the next formal deliverable: a Threat Landscape Report using CISA, HHS, HC3, MITRE ATT&CK, and STRIDE mapping. |

## Marcus Findings That Were Missed and Should Be Added

### GAP-020: Legacy TLS Enabled on Patient Portal

**Affected Asset(s):**  
Patient Portal and Public Website on `web-srv-01` (**High**), patient-facing web services, public trust and portal authentication.

**Data at Risk:**  
Patient portal data, lab result access, login credentials, and patient-facing session data (**Restricted**).

**Current Control Status:**  
`web-srv-01` is protected by the FortiGate and is documented as a public website and patient portal system. However, Marcus identified that the SSL/TLS configuration still permits TLS 1.0 alongside TLS 1.2.

**What is Missing:**  
Technical Preventive control: hardened TLS configuration that disables TLS 1.0 and other legacy protocols. Administrative Detective control: recurring external web configuration review.

**Risk Level:**  
High

**Risk Justification:**  
The patient portal handles Restricted data and is externally exposed. Legacy TLS does not automatically mean data has been compromised, but it weakens the security posture of a patient-facing service and may create compliance and trust concerns.

**Potential Impact:**  
Attackers could target weak transport configuration, downgrade clients where feasible, or use the finding as evidence of weak web security governance. This would increase risk around the patient portal, which already experienced broken access control.

### GAP-021: Unrestricted Removable Media on Workstations

**Affected Asset(s):**  
Clinical Endpoints and Mobile Devices (**High**), Administrative Endpoints (**High**), EHR access workstations, pharmacy workstations, HR and finance workstations.

**Data at Risk:**  
Patient records, imaging data, billing data, HR records, financial records, internal documentation, and credentials (**Restricted** and **Confidential**).

**Current Control Status:**  
Sophos endpoint protection is contracted, but no device control or USB storage restriction is documented. Marcus stated that USB ports are unrestricted on all workstations and no GPO disables USB storage.

**What is Missing:**  
Technical Preventive control: GPO or endpoint control restricting USB mass storage. Technical Detective control: alerts for large file transfers to removable media. Administrative Preventive control: removable media policy and exception approval process.

**Risk Level:**  
High

**Risk Justification:**  
Unrestricted USB storage creates an easy data exfiltration path from endpoints that can access Restricted and Confidential data. The risk is amplified by missing DLP, weak monitoring, and shared or unattended sessions.

**Potential Impact:**  
A staff member, contractor, or attacker with workstation access could copy patient records, HR documents, billing files, or internal documentation to removable media without detection. USB devices could also introduce malware into clinical or administrative endpoints.

### GAP-022: Limited Security Assurance Over Landlord-Managed HQ Network

**Affected Asset(s):**  
Corporate HQ network and VLAN (**High**), HQ workstations and laptops, VPN connectivity to Central, Finance, HR, Legal, Executive Leadership, and IT operations.

**Data at Risk:**  
HR records, finance data, legal documents, executive communications, O365 data, VPN credentials, and administrative files (**Confidential**, with potential **Restricted** exposure if HQ users access clinical systems).

**Current Control Status:**  
MedDefense has its own VLAN in the landlord-managed building network and a site-to-site VPN to Central. However, Marcus identified that MedDefense has no visibility into the security of the shared building infrastructure.

**What is Missing:**  
Administrative Preventive control: contractual security requirements and assurance for the landlord-managed network. Technical Detective control: monitoring of HQ-to-Central traffic and unusual access patterns. Technical Preventive control: strict VPN ACLs and validation of VLAN isolation.

**Risk Level:**  
High

**Risk Justification:**  
HQ contains administrative departments and connects to Central through VPN. If the building-managed network is insecure or VLAN isolation is weak, MedDefense could be exposed to risks outside its direct control. The scan also showed broad reachability from HQ to internal MedDefense subnets.

**Potential Impact:**  
A compromise or misconfiguration in the landlord-managed environment could expose HQ traffic or provide a path toward Central systems. This could affect finance, HR, legal operations, IT administration, and potentially clinical system access through VPN connectivity.

### GAP-023: No Formal Change Management Process

**Affected Asset(s):**  
All production servers, network devices, backup systems, EHR, billing, pharmacy systems, PACS, and medical IoT supporting services (**Critical** to **High**).

**Data at Risk:**  
Patient records, medication data, billing data, imaging data, backups, system configurations, and operational data (**Restricted** and **Confidential**).

**Current Control Status:**  
No formal change management process is documented. Marcus stated that configuration changes are made ad hoc without documentation, testing, or approval, and linked this to the broken cron job that caused a three-week backup gap.

**What is Missing:**  
Administrative Preventive control: formal change approval, testing, documentation, rollback planning, and ownership. Administrative Corrective control: post-change review and failure remediation. Technical Detective control: configuration change logging and monitoring.

**Risk Level:**  
Critical

**Risk Justification:**  
This gap affects Critical clinical and recovery systems. MedDefense has already experienced incidents that align with poor change governance, including a backup job failure and pharmacy dosage corruption after a database update script. Without change management, operational changes can create security and patient safety risks.

**Potential Impact:**  
A poorly tested change could break backups, corrupt clinical data, expose databases, misconfigure network access, weaken firewall rules, or disrupt EHR/PACS/pharmacy operations. This could result in data loss, patient safety risk, downtime, and regulatory exposure.

## Findings Identified in the Current Assessment That Marcus Missed

| Finding | Evidence from Current Assessment | Likely Reason Marcus Missed It |
|---|---|---|
| `UNKNOWN-01` on Central server subnet | Network scan identified `10.10.2.99` as a Linux system with SSH and two web services, not in documentation. | Marcus likely did not have the network scan before leaving. |
| Unknown Westside Linux device | Network scan identified `10.10.10.200` as undocumented Linux with SSH, HTTP, and port 3000. | Marcus suspected an additional Westside server but never confirmed it. |
| Dr. Patel personal NAS | Helpdesk disclosure identified a personal NAS in Cardiology storing research data. | Marcus may not have had department-level visibility or time to pursue Shadow IT interviews. |
| Marketing personal Google Drive | Helpdesk disclosure identified a Google Drive linked to personal Gmail. | Marcus suspected cloud service sprawl but did not complete the cloud inventory. |
| Abandoned Raspberry Pi monitor | Helpdesk disclosure identified a previous intern's Raspberry Pi on the second floor. | Marcus may have known about it informally, but it was not documented in the draft. |
| Patient portal broken access control | Incident analysis showed authenticated patients could view other patients' lab results by modifying a URL parameter. | Marcus documented TLS weakness but may not have analyzed application authorization incidents yet. |
| Pharmacy dosage integrity incident | Incident analysis showed a database update script overwrote medication dosage values across all three sites. | Marcus's draft focused more on infrastructure and may not have reviewed application change incidents. |
| Automated offboarding gap | Healthcare breach validation showed terminated-account abuse risk; no MedDefense offboarding control was documented. | Marcus had not completed HR/identity lifecycle analysis. |
| DLP/export monitoring gap severity | Marcus identified no DLP, but the current assessment expanded it into a Critical gap based on breach validation. | Marcus listed it as not yet documented and had not completed the reality check. |
| DMZ egress filtering uncertainty | The network diagram shows `web-srv-01` in a DMZ, but the scan lists it in the server subnet and no egress restriction is validated. | Marcus's diagram was marked incomplete and simplified. |
| Medical device credential governance | Reality check and medical IoT analysis identified default credential governance as a specific gap. | Marcus recognized default credential risk but did not write a full IoT assessment. |

## Resolution of Differences

Marcus's assessment was highly accurate in direction and correctly identified several of MedDefense's highest-risk issues. The current assessment agrees with most of his findings but changes the severity of several items based on additional evidence: medical IoT, MFA, and monitoring are treated as Critical rather than only High because they affect patient safety, Restricted data, and enterprise-wide compromise detection. The main disagreement is with the Low rating for `print-srv-01`; the print server is not a top clinical asset, but in a flat network an unsupported internal server can become a pivot point, so it should not be treated as merely low risk.

## Part 2: The Last Page

Marcus's unfinished threat landscape work connects directly to the completed internal posture assessment. The internal assessment shows that MedDefense has the exact weaknesses commonly exploited by healthcare attackers: flat networks, missing MFA, weak monitoring, fragile backups, exposed medical IoT, public-facing web risk, and incomplete vulnerability management. External threat landscape analysis is the logical next step because it adds likelihood and attacker behavior to the internal findings; it answers who would exploit these weaknesses, how they would do it, and which controls reduce the most realistic attack paths. A formal Threat Landscape Report using CISA, HHS 405(d), HC3, MITRE ATT&CK, and STRIDE would turn the posture assessment into a forward-looking defense strategy.

## Final Assessment

Marcus's draft should be treated as credible, technically sound, and strategically useful, but incomplete. He correctly identified the core structural weaknesses that now drive the assessment: segmentation, backup isolation, medical IoT exposure, monitoring, MFA, Westside security, shared credentials, and lifecycle risk. The current assessment validates those findings, adds scan evidence, expands the analysis to data flows and Shadow IT, and converts the results into prioritized gaps and risk decisions. The next phase should complete Marcus's intended work by producing a formal threat landscape and threat modeling report for MedDefense.


