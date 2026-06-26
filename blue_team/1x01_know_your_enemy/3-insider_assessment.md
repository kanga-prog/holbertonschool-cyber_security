# Insider Threat Assessment for MedDefense

## Overview

This assessment analyzes five insider-risk scenarios from the MedDefense environment.  
The purpose is to distinguish **malicious insider behavior** from **negligent insider behavior**, identify observable warning signs, and connect each scenario to existing control gaps from the MedDefense posture work.

In healthcare, insider risk is especially dangerous because staff often need broad access to patient data for legitimate clinical operations. The goal is not to block legitimate care delivery, but to detect when valid access becomes unsafe, inappropriate, or malicious.

---

## Scenario 1: The Shared Login

**Scenario:**  
The Radiology department uses a shared account (`raduser/radiology1`) for the PACS workstation. Multiple technicians use the same credentials throughout the day. Nobody logs out between patients.

### Classification: Negligent

This is primarily a negligent insider-risk scenario. There is no evidence that the technicians are intentionally trying to harm MedDefense or steal data. However, the practice creates serious accountability and access-control risk because multiple users operate under the same identity.

### Behavioral Indicators

- Multiple users accessing PACS records under the same account throughout the day.
- No logout events or session changes between patients and staff shifts.
- PACS access patterns that cannot be tied to a specific named technician.

### Existing Control from 1x00

**Access Control / Unique User Identification** should cover this scenario.  
The control matrix should require individual user accounts for systems that access patient data, especially PACS and EHR-related systems.

### Gap Exploited from 1x00

**GAP-IAM-01: Shared credentials and weak user accountability**  
This gap allows multiple users to access sensitive systems using the same login, making it impossible to determine who accessed which patient record.

### Recommended Mitigation

Implement **unique named accounts with automatic session lock/logout** for PACS workstations. Each technician should authenticate individually, and the workstation should lock between users or after short inactivity.

---

## Scenario 2: The Ghost Account

**Scenario:**  
An IT support contractor's VPN account remained active for 47 days after their contract ended. Network logs show the account authenticated 3 times during off-hours in the weeks after termination. This mirrors Incident F from the 1x00 incident analysis.

### Classification: Malicious

This scenario should be treated as malicious until proven otherwise. The account belonged to a contractor whose contract had ended, yet it authenticated multiple times after termination during off-hours. Even if the original account retention was caused by negligence, the post-termination use is unauthorized and suspicious.

### Behavioral Indicators

- Successful VPN logins after the contractor's end date.
- Off-hours authentication from an account that should have been disabled.
- Lack of matching HR or ticketing activity authorizing continued access.

### Existing Control from 1x00

**Account Lifecycle Management / Offboarding Control** should cover this scenario.  
The control matrix should require immediate account disablement when employment or contract access ends.

### Gap Exploited from 1x00

**GAP-IAM-02: No automated offboarding and stale active accounts**  
The contractor's VPN access remained active for 47 days after contract termination, creating a ghost account that could be abused by the former contractor or by an external attacker with the credentials.

### Recommended Mitigation

Implement **automated HR-to-IAM offboarding** that disables VPN, Active Directory, email, SaaS, and privileged access immediately when a contract or employment relationship ends. Add a weekly review of active contractor accounts.

---

## Scenario 3: The Personal NAS

**Scenario:**  
Dr. Patel in Cardiology connected a personal NAS device to his office network port. He stores research data and convenience copies of patient files he consults frequently. The NAS is not encrypted, not backed up, and not visible to IT. This references the shadow IT finding from 1x00 Task 11.

### Classification: Negligent

This is negligent insider behavior and a shadow IT issue. Dr. Patel may believe he is improving productivity, but storing patient files on an unmanaged personal NAS creates confidentiality, integrity, availability, and compliance risks.

### Behavioral Indicators

- Unknown or unmanaged device connected to a hospital network port.
- Unusual SMB, file-sharing, or NAS traffic from a clinician office.
- Patient files stored outside approved EHR, file server, or managed research repository.

### Existing Control from 1x00

**Asset Management / Network Access Control / Data Handling Control** should cover this scenario.  
Only approved and inventoried devices should connect to the hospital network, and patient data should only be stored in approved encrypted systems.

### Gap Exploited from 1x00

**GAP-ASSET-01: Shadow IT and unmanaged devices**  
The NAS is not visible to IT, not encrypted, not backed up, and not governed by MedDefense security policies.

**GAP-DATA-01: Uncontrolled storage of patient data**  
Patient files are copied outside approved systems, increasing the risk of unauthorized access, loss, or breach notification obligations.

### Recommended Mitigation

Deploy **Network Access Control (NAC)** to block unauthorized devices and require that patient data be stored only in approved encrypted repositories with access logging and backup coverage.

---

## Scenario 4: The Curious Employee

**Scenario:**  
A registration clerk at the front desk accesses the EHR records of a local politician who was treated at MedDefense Central. She does not modify anything. She tells a friend about the visit, and the friend posts it on social media.

### Classification: Malicious

This is malicious insider behavior. The clerk intentionally accessed patient records without a business need and disclosed protected health information to someone outside the organization. Even though she did not modify data, unauthorized viewing and disclosure are serious privacy violations.

### Behavioral Indicators

- Access to a high-profile patient's EHR by an employee with no treatment, billing, or registration need.
- EHR access outside the clerk's normal patient workflow or department assignment.
- Access to celebrity, public figure, VIP, or sensitive patient records without a corresponding work order or appointment task.

### Existing Control from 1x00

**EHR Access Monitoring / Role-Based Access Control / Privacy Audit Control** should cover this scenario.  
The control matrix should include audit logging, break-glass monitoring, minimum necessary access, and alerts for VIP or unusual patient-record access.

### Gap Exploited from 1x00

**GAP-MON-01: Insufficient monitoring of inappropriate EHR access**  
The clerk was able to access records without an alert or review before the information was disclosed externally.

**GAP-TRAIN-01: Weak privacy and security awareness reinforcement**  
The employee either did not understand or ignored the obligation to keep patient information confidential.

### Recommended Mitigation

Implement **EHR user behavior monitoring with VIP/sensitive-record alerts**. Access to public figures or sensitive records should trigger privacy review when the user has no documented care or administrative relationship to the patient.

---

## Scenario 5: The Overworked Admin

**Scenario:**  
A sysadmin, overwhelmed by tickets, writes a script to automate password resets. The script stores Active Directory admin credentials in plaintext in a file on his desktop. He shares the script with a colleague via email so they can help with the backlog.

### Classification: Negligent

This is negligent insider behavior. The sysadmin's intention is operational efficiency, not harm. However, storing domain admin credentials in plaintext and sharing them by email creates a severe privilege compromise risk.

### Behavioral Indicators

- Plaintext credentials stored in scripts, desktop files, or shared folders.
- Administrative scripts sent by email or stored outside a secure repository.
- Password reset activity performed through shared or embedded admin credentials.

### Existing Control from 1x00

**Privileged Access Management / Secure Administration Control** should cover this scenario.  
Administrative credentials should never be hardcoded, stored in plaintext, or shared by email. Password reset tasks should use approved tools with logging and role-based delegation.

### Gap Exploited from 1x00

**GAP-IAM-03: Weak privileged credential management**  
The environment allows administrative credentials to be stored insecurely and reused outside controlled workflows.

**GAP-PROC-01: Lack of secure administrative automation standards**  
The sysadmin created an unsafe workaround because there is no approved automation process for high-volume administrative tasks.

### Recommended Mitigation

Implement a **Privileged Access Management (PAM) solution or delegated password reset tool** that allows authorized staff to reset passwords without exposing domain admin credentials. Scripts should use secure vaulting, service accounts with least privilege, and code review before use.

---

## Pattern Assessment

The systemic weakness at MedDefense is that legitimate access is not consistently tied to strong accountability, monitoring, and governance. This makes insider threats particularly dangerous because staff and contractors can use valid access in unsafe ways without being detected quickly. At least two Project 1x00 findings support this pattern: first, the **shared Radiology account** shows weak identity accountability, making it difficult to attribute patient-data access to a specific person; second, the **ghost contractor account** shows weak offboarding and account lifecycle management, allowing access to survive after a business relationship ends. The **personal NAS / shadow IT finding** adds a third pattern: users are able to create unmanaged data stores outside IT visibility. Together, these issues show that MedDefense's insider risk is not only a people problem; it is a control failure involving identity management, asset visibility, EHR access monitoring, privileged credential handling, and enforcement of approved workflows.

---

## Summary Table

| Scenario | Classification | Main Risk | Existing Control Area | Gap Exploited | Recommended Mitigation |
|---|---|---|---|---|---|
| 1. Shared Login | Negligent | No user accountability in PACS | Unique user identification | GAP-IAM-01 | Named accounts and auto-lock/logout |
| 2. Ghost Account | Malicious | Unauthorized post-termination VPN access | Account lifecycle management | GAP-IAM-02 | Automated offboarding and contractor reviews |
| 3. Personal NAS | Negligent | Shadow IT and unmanaged patient-data storage | Asset management / NAC / data handling | GAP-ASSET-01 / GAP-DATA-01 | NAC and approved encrypted storage |
| 4. Curious Employee | Malicious | Unauthorized EHR access and PHI disclosure | EHR monitoring / RBAC / privacy audit | GAP-MON-01 / GAP-TRAIN-01 | VIP/sensitive-record access alerts |
| 5. Overworked Admin | Negligent | Plaintext admin credentials and unsafe sharing | PAM / secure administration | GAP-IAM-03 / GAP-PROC-01 | PAM or delegated password reset tooling |

