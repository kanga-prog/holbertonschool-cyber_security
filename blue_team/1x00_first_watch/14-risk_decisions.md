# Risk Treatment Decisions

## Purpose

This document selects the seven highest-priority MedDefense security gaps from the updated gap analysis and applies formal risk treatment strategies. The goal is to identify what MedDefense should do within a realistic annual security budget of **$120,000**.

The four risk treatment strategies are:

- **Mitigate**: implement controls to reduce risk to an acceptable level.
- **Transfer**: shift financial consequences to a third party, such as insurance or an outsourced provider.
- **Accept**: acknowledge the risk and take no action, with management sign-off.
- **Avoid**: eliminate the activity or asset that creates the risk.

Because the selected gaps affect Critical assets, Restricted healthcare data, or hospital-wide operations, the primary treatment strategy for all seven selected gaps is **Mitigate**. Transfer, acceptance, or avoidance may support future planning, but they are not appropriate as the primary response for these priority risks.

## Selected Top Gaps

The selected gaps are:

1. GAP-001: No Effective Internal Network Segmentation
2. GAP-014: Lack of Centralized Logging and Security Monitoring
3. GAP-005: Backup Architecture Is Not Resilient Against Ransomware or Physical Co-Failure
4. GAP-006: No Formal Incident Response Plan
5. GAP-012: No Formal Vulnerability Management Program
6. GAP-008: Organization-Wide MFA Is Missing
7. GAP-003: Medical IoT Devices Exposed to the Entire Internal Network

These gaps were selected because they are repeatedly validated by the internal assessment and by healthcare breach patterns: ransomware spreads through flat networks, weak backups turn incidents into prolonged outages, missing monitoring increases dwell time, weak identity controls enable credential abuse, and exposed medical IoT creates patient safety risk.

---

## Risk Treatment Decision 1

**Gap ID:** GAP-001  
**Gap Title:** No Effective Internal Network Segmentation  
**Risk Level:** Critical

**Treatment Strategy:** Mitigate

**Justification:**  
This gap affects multiple Critical asset categories, including EHR, PACS, medical IoT, Active Directory, billing, backup infrastructure, and clinical endpoints. Avoiding the risk is not feasible because MedDefense must continue operating its hospital network. Accepting the risk is inappropriate because flat network architecture allows a single compromised device to affect the entire environment. Transferring financial loss through insurance would not prevent patient care disruption, so mitigation is required.

**Proposed Control(s):**

- Implement internal VLAN segmentation for servers, clinical workstations, medical IoT, administrative endpoints, backup infrastructure, and guest WiFi.  
  - **Category:** Technical  
  - **Function:** Preventive
- Add ACLs or internal firewall rules to restrict traffic between zones to explicitly required services.  
  - **Category:** Technical  
  - **Function:** Preventive
- Prioritize segmentation first around EHR, PACS, billing, domain controllers, backup systems, and medical devices.  
  - **Category:** Technical  
  - **Function:** Compensating / Preventive

**Estimated Cost:**  
$10-50K. Budget allocation: **$35,000**

**Implementation Effort:**  
Long-term > 1 month

**Expected Risk Reduction:**  
High. Segmentation reduces the blast radius of ransomware, credential compromise, Shadow IT, and medical device compromise. It does not eliminate vulnerabilities, but it prevents a single compromised endpoint from automatically reaching every critical system.

**Trade-offs:**  
Implementation requires careful coordination with IT and clinical departments to avoid disrupting EHR, PACS, medical device traffic, and site-to-site connectivity. Misconfigured rules could interrupt patient care, so rollout must be phased and tested.

---

## Risk Treatment Decision 2

**Gap ID:** GAP-014  
**Gap Title:** Lack of Centralized Logging and Security Monitoring  
**Risk Level:** Critical

**Treatment Strategy:** Mitigate

**Justification:**  
MedDefense currently has some logs and endpoint protection, but no documented centralized monitoring, SIEM, IDS, NDR, or formal review process. Accepting this risk would mean incidents are detected only after visible operational symptoms, as happened with the crypto-miner and comparable healthcare breaches. A full enterprise SIEM may exceed the budget, but a scoped logging and managed detection approach is feasible.

**Proposed Control(s):**

- Deploy centralized log collection for Active Directory, FortiGate, critical Linux servers, Windows servers, EHR-related systems, backup infrastructure, and web-srv-01.  
  - **Category:** Technical  
  - **Function:** Detective
- Implement alerting for high-risk events: failed logins, privileged account changes, unusual VPN access, ransomware indicators, backup job failures, and unexpected outbound traffic from servers.  
  - **Category:** Technical  
  - **Function:** Detective
- Establish weekly security log review ownership and escalation criteria.  
  - **Category:** Administrative  
  - **Function:** Detective
- Consider a lightweight managed detection service or scoped SIEM instead of a full enterprise deployment.  
  - **Category:** Technical / Administrative  
  - **Function:** Detective

**Estimated Cost:**  
$10-50K. Budget allocation: **$35,000**

**Implementation Effort:**  
Short-term to Long-term. Initial critical log onboarding can begin in < 1 month; full tuning requires > 1 month.

**Expected Risk Reduction:**  
High. Monitoring does not prevent compromise, but it reduces dwell time and improves MedDefense's ability to detect ransomware staging, credential abuse, patient portal abuse, and medical device reconnaissance before impact becomes hospital-wide.

**Trade-offs:**  
A lower-cost monitoring approach will not provide the same coverage as a mature enterprise SOC or SIEM. It may generate false positives and require staff time to tune alerts and review findings.

---

## Risk Treatment Decision 3

**Gap ID:** GAP-005  
**Gap Title:** Backup Architecture Is Not Resilient Against Ransomware or Physical Co-Failure  
**Risk Level:** Critical

**Treatment Strategy:** Mitigate

**Justification:**  
Backups are MedDefense's last line of defense against ransomware, system failure, and data corruption. Current backups are stored on a local NAS in the same rack, same room, and same network as production systems, which means ransomware or a physical event could destroy both production and recovery capability. Avoidance is not possible because backups are required, and accepting the risk would leave MedDefense exposed to prolonged clinical and administrative outages.

**Proposed Control(s):**

- Add immutable, offline, or offsite backup storage for critical systems.  
  - **Category:** Technical  
  - **Function:** Corrective
- Restrict NAS management access to an IT management segment only.  
  - **Category:** Technical  
  - **Function:** Preventive
- Implement backup job monitoring and alerting for failed or stale backups.  
  - **Category:** Technical  
  - **Function:** Detective
- Define and test recovery procedures for EHR, billing, AD, file shares, and PACS.  
  - **Category:** Administrative  
  - **Function:** Corrective

**Estimated Cost:**  
$10-50K. Budget allocation: **$25,000**

**Implementation Effort:**  
Short-term < 1 month for restricted management and backup validation; Long-term > 1 month for full recovery testing.

**Expected Risk Reduction:**  
High. Isolated backups and tested recovery reduce the likelihood that ransomware becomes a prolonged hospital outage. They also improve confidence that restored data is recent and usable.

**Trade-offs:**  
Storage and recovery testing require staff time, scheduling, and coordination with clinical departments. Recovery exercises may temporarily affect non-production systems or require maintenance windows.

---

## Risk Treatment Decision 4

**Gap ID:** GAP-006  
**Gap Title:** No Formal Incident Response Plan  
**Risk Level:** Critical

**Treatment Strategy:** Mitigate

**Justification:**  
The prior ransomware response was improvised for four days, and real-world healthcare breaches show that unplanned response increases downtime, cost, confusion, and regulatory exposure. Avoidance is not possible because incidents cannot be eliminated. Transfer through cyber insurance may help financially, but it does not replace containment, communications, and recovery execution.

**Proposed Control(s):**

- Create an incident response plan with roles, escalation paths, legal involvement, communications, containment steps, evidence preservation, and recovery coordination.  
  - **Category:** Administrative  
  - **Function:** Corrective
- Develop playbooks for ransomware, credential compromise, patient portal breach, medical device incident, and lost/stolen endpoint.  
  - **Category:** Administrative  
  - **Function:** Corrective
- Run at least one tabletop exercise with IT, Security, Legal, Clinical Operations, Finance, and Executive Leadership.  
  - **Category:** Administrative  
  - **Function:** Corrective / Detective

**Estimated Cost:**  
$1-10K. Budget allocation: **$8,000**

**Implementation Effort:**  
Short-term < 1 month

**Expected Risk Reduction:**  
Medium to High. The plan will not prevent incidents, but it reduces confusion, improves containment speed, preserves evidence, and helps leadership make faster decisions during a crisis.

**Trade-offs:**  
The plan requires participation from busy clinical, legal, IT, and executive staff. It must be maintained and tested regularly or it will become a paper control.

---

## Risk Treatment Decision 5

**Gap ID:** GAP-012  
**Gap Title:** No Formal Vulnerability Management Program  
**Risk Level:** Critical after Task 13 reassessment

**Treatment Strategy:** Mitigate

**Justification:**  
The reality check showed that real healthcare breaches often begin with known vulnerabilities that were not patched in time. MedDefense has end-of-life systems, exposed services, public-facing applications, medical devices with known CVEs, and no formal vulnerability management process. Accepting the risk would allow known weaknesses to remain exploitable until attackers find them first.

**Proposed Control(s):**

- Establish a vulnerability management program with recurring scans, risk-based prioritization, ownership, remediation tracking, and executive reporting.  
  - **Category:** Administrative  
  - **Function:** Detective
- Prioritize internet-facing systems, VPN/firewall infrastructure, EHR, billing, PACS, Active Directory, backup systems, and medical IoT.  
  - **Category:** Technical  
  - **Function:** Detective
- Create patch SLAs for critical, high, medium, and low vulnerabilities.  
  - **Category:** Administrative  
  - **Function:** Preventive / Corrective
- Document exceptions for systems that cannot be patched, such as the MRI workstation, and require compensating controls.  
  - **Category:** Administrative  
  - **Function:** Compensating

**Estimated Cost:**  
$1-10K. Budget allocation: **$7,000**

**Implementation Effort:**  
Short-term < 1 month for program launch; Long-term > 1 month for full operational maturity.

**Expected Risk Reduction:**  
High. A vulnerability program reduces the chance that MedDefense is compromised through known, preventable weaknesses. It also improves prioritization so limited resources are focused on systems most likely to cause clinical or regulatory impact.

**Trade-offs:**  
Scanning and remediation may generate operational friction with system owners, vendors, and clinical departments. Medical devices and certified systems may require exceptions rather than direct patching.

---

## Risk Treatment Decision 6

**Gap ID:** GAP-008  
**Gap Title:** Organization-Wide MFA Is Missing  
**Risk Level:** Critical after Task 13 reassessment

**Treatment Strategy:** Mitigate

**Justification:**  
The breach validation showed that password-only VPN and EHR access can enable patient data theft and insider abuse. MedDefense currently has MFA only for James Chen's account. Avoiding the risk is not feasible because staff require system access, and accepting it is not appropriate because identity compromise can expose Restricted patient data and Critical systems.

**Proposed Control(s):**

- Deploy MFA first for privileged users, VPN access, O365, remote-capable laptops, and administrative accounts.  
  - **Category:** Technical  
  - **Function:** Preventive
- Extend MFA to EHR and other high-risk applications where technically feasible.  
  - **Category:** Technical  
  - **Function:** Preventive
- Implement enrollment tracking, exception approval, and break-glass account procedures.  
  - **Category:** Administrative  
  - **Function:** Preventive / Compensating

**Estimated Cost:**  
$1-10K. Budget allocation: **$8,000**

**Implementation Effort:**  
Short-term < 1 month for privileged and remote access; Long-term > 1 month for broader application coverage.

**Expected Risk Reduction:**  
High. MFA significantly reduces the usefulness of stolen or reused passwords and directly addresses credential abuse risk for remote access, cloud services, and privileged accounts.

**Trade-offs:**  
MFA may create user friction, especially for clinicians and remote staff. Exceptions may be needed for legacy systems, shared clinical workstations, and emergency workflows, so governance is required.

---

## Risk Treatment Decision 7

**Gap ID:** GAP-003  
**Gap Title:** Medical IoT Devices Exposed to the Entire Internal Network  
**Risk Level:** Critical

**Treatment Strategy:** Mitigate

**Justification:**  
Medical IoT devices are connected to patient monitoring, dosage-related workflows, and clinical response. The scan confirmed that Philips monitors, BD Alaris pumps, and other medical devices expose management interfaces to the internal network, while BD Alaris firmware has known CVEs and network isolation has not been implemented. Avoidance is not feasible because the devices are clinically required, and replacement is not realistic within the annual budget.

**Proposed Control(s):**

- Use the segmentation project from GAP-001 to isolate medical devices into controlled zones.  
  - **Category:** Technical  
  - **Function:** Compensating / Preventive
- Restrict medical device management interfaces to authorized biomedical engineering and IT management hosts only.  
  - **Category:** Technical  
  - **Function:** Preventive
- Review and change default credentials on medical device management interfaces where vendor support allows.  
  - **Category:** Administrative / Technical  
  - **Function:** Preventive
- Create a joint IT, Security, and Biomedical Engineering procedure for medical device security exceptions and monitoring.  
  - **Category:** Administrative  
  - **Function:** Compensating

**Estimated Cost:**  
$1-10K incremental cost. Budget allocation: **$2,000**  
Note: the main network engineering cost is already included under GAP-001 segmentation.

**Implementation Effort:**  
Short-term < 1 month for inventory and access restrictions on known devices; Long-term > 1 month for full medical device segmentation and governance.

**Expected Risk Reduction:**  
Medium to High. Medical device isolation and credential review reduce the chance that a compromised workstation or Shadow IT device can access patient monitors, infusion pumps, or nurse call systems. Residual risk remains because some devices may not be patchable or may require vendor coordination.

**Trade-offs:**  
Clinical devices must remain available, and changes may require vendor validation or Biomedical Engineering involvement. Incorrect restrictions could interrupt monitoring or medication workflows, so implementation must be staged and tested.

---

## Budget Summary

### Proposed First-Year Security Budget Allocation

| Priority | Gap ID | Initiative | Estimated Cost Range | Planned Allocation |
|---:|---|---|---|---:|
| 1 | GAP-001 | Internal segmentation for critical zones | $10-50K | $35,000 |
| 2 | GAP-014 | Centralized logging and scoped monitoring | $10-50K | $35,000 |
| 3 | GAP-005 | Backup resilience and recovery testing | $10-50K | $25,000 |
| 4 | GAP-006 | Incident response plan and tabletop exercise | $1-10K | $8,000 |
| 5 | GAP-012 | Vulnerability management program | $1-10K | $7,000 |
| 6 | GAP-008 | MFA rollout for privileged, VPN, O365, and remote access | $1-10K | $8,000 |
| 7 | GAP-003 | Medical IoT access restrictions and credential review | $1-10K | $2,000 |
|  |  | **Total Planned Allocation** |  | **$120,000** |

## Budget Fit Assessment

The proposed plan fits within the **$120,000** annual security budget by prioritizing controls that reduce risk across multiple critical assets instead of purchasing one expensive standalone tool. The plan avoids spending most of the budget on a full enterprise SIEM and instead funds a scoped monitoring approach, internal segmentation, backup resilience, MFA, incident response, vulnerability management, and initial medical IoT containment.

## Deferred Items for Next Fiscal Year

The following items should be deferred to the next fiscal year unless additional funding becomes available:

- Full enterprise SIEM or 24/7 SOC service expansion beyond the scoped monitoring plan.
- Complete hospital-wide network redesign beyond the initial critical segmentation phase.
- Full medical device security program covering all devices, vendors, and biomedical engineering workflows.
- Full DLP implementation for EHR exports, O365, file shares, and endpoint transfers.
- Replacement of end-of-life systems that require major capital expenditure, including legacy medical equipment and unsupported platforms.

These items are deferred because the first-year plan focuses on the highest shared risk reducers: segmentation, monitoring, recoverability, identity protection, and response readiness.

## Executive Recommendation

MedDefense should treat the top seven gaps primarily through mitigation because they affect Critical assets, Restricted data, and hospital operations. Transfer through cyber insurance may help with financial recovery, but it cannot restore patient care during an outage or prevent data exposure. Acceptance is not appropriate for these gaps because comparable healthcare organizations have already experienced ransomware, PHI breaches, medical device compromise, and prolonged outages from the same weakness patterns. Avoidance is generally not feasible because MedDefense must continue operating its clinical systems, medical devices, and inter-site network.


