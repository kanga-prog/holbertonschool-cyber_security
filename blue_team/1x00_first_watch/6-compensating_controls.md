# Compensating Controls for Legacy MRI Workstation

## Purpose

This document analyzes the security risk created by the legacy MRI control workstation at MedDefense Central and proposes compensating controls. The workstation cannot be patched, upgraded, replaced, or disconnected from the network because of medical device certification, budget constraints, and clinical operational requirements.

## Risk Analysis

The MRI control workstation represents a critical security risk because it runs Windows XP Embedded, an operating system that has not received security patches since April 2014. This means known vulnerabilities may remain exploitable and cannot be remediated through normal patch management. The risk extends beyond Radiology because the workstation is currently placed on the same VLAN as general hospital workstations, allowing a compromised MRI workstation to become a pivot point into the broader MedDefense network. Because the device must communicate with the PACS server to transmit imaging studies, it requires network connectivity, so the risk must be reduced through compensating controls rather than removal from the network.

## Compensating Control Strategy

### Control 1: Dedicated MRI Network Segmentation

**Description:**
Place the MRI control workstation in a dedicated VLAN or isolated network segment separate from general hospital workstations, servers, and other medical devices. Only explicitly required traffic between the MRI workstation and the PACS server should be allowed.

**Category + Function:**
Technical / Compensating

**How It Reduces Risk Without OS Modification:**
This control does not modify the MRI operating system or medical device software. It reduces risk by limiting the systems the MRI workstation can communicate with, preventing it from being used as an easy pivot point into the broader hospital network.

**Limitations / Residual Risk:**
Segmentation reduces exposure but does not remove vulnerabilities from the Windows XP system itself. If the MRI workstation is compromised, the attacker may still affect the MRI workflow or attempt to attack allowed services such as PACS.

### Control 2: Firewall Allowlist Between MRI and PACS

**Description:**
Implement strict firewall rules allowing the MRI workstation to communicate only with the PACS server on required ports and protocols. All other inbound and outbound traffic from the MRI workstation should be denied by default.

**Category + Function:**
Technical / Preventive

**How It Reduces Risk Without OS Modification:**
The firewall rules are applied at the network level rather than on the MRI workstation. This limits unauthorized communication while preserving the clinical requirement for the MRI workstation to transmit imaging studies to PACS.

**Limitations / Residual Risk:**
If the allowed PACS communication path is abused, some risk remains. The rules must be accurately documented and tested with Radiology to avoid disrupting patient care.

### Control 3: Passive Network Monitoring for MRI Traffic

**Description:**
Monitor traffic to and from the MRI workstation for unusual connections, unexpected protocols, failed connection attempts, or communication with destinations other than the PACS server.

**Category + Function:**
Technical / Detective

**How It Reduces Risk Without OS Modification:**
Passive monitoring observes network behavior externally and does not require installing agents or changing the Windows XP Embedded configuration. It provides visibility into suspicious activity involving the MRI workstation.

**Limitations / Residual Risk:**
Monitoring does not prevent compromise by itself. It must be paired with alerting and an incident response process to be effective.

### Control 4: Radiology-Specific Operating Procedure

**Description:**
Create a documented procedure for Radiology and IT covering approved MRI workstation use, prohibited actions, escalation steps, and response expectations if abnormal behavior is observed.

**Category + Function:**
Administrative / Preventive

**How It Reduces Risk Without OS Modification:**
The procedure reduces risky human behavior and improves reporting without changing the certified MRI software or operating system. It helps staff understand that the workstation is a restricted medical system, not a general-purpose computer.

**Limitations / Residual Risk:**
Procedures depend on staff awareness and compliance. They do not technically stop malware, unauthorized network traffic, or exploitation.

### Control 5: Restricted Physical Access to MRI Control Workstation

**Description:**
Limit physical access to the MRI control workstation to authorized Radiology and IT personnel only. The workstation area should remain supervised or access-controlled, and any vendor or maintenance access should be logged.

**Category + Function:**
Physical / Preventive

**How It Reduces Risk Without OS Modification:**
This control reduces the chance that an unauthorized person can interact directly with the legacy system, attach removable media, change settings, or access the console. It does not require changes to the MRI operating system.

**Limitations / Residual Risk:**
Physical restrictions do not protect against network-based attacks. They must be combined with segmentation and traffic restrictions.

### Control 6: Documented Exception and Risk Acceptance Review

**Description:**
Document the MRI workstation as a formal security exception, including the reason it cannot be patched, upgraded, replaced, or disconnected. Require periodic review by Security, IT, Radiology leadership, and executive risk owners.

**Category + Function:**
Administrative / Compensating

**How It Reduces Risk Without OS Modification:**
This control ensures the risk is visible, owned, reviewed, and not forgotten. It supports governance and makes sure compensating controls remain aligned with business and clinical constraints.

**Limitations / Residual Risk:**
Documentation does not directly reduce technical exposure. It must drive actual control implementation and periodic validation.

## Implementation Priority

If MedDefense can implement only one control immediately, the highest-priority control should be **Dedicated MRI Network Segmentation**.

This provides the greatest risk reduction because the current highest-risk condition is that the Windows XP MRI workstation is on the same VLAN as general hospital workstations. Segmentation directly limits lateral movement, reduces the MRI workstation's exposure to the rest of the hospital network, and preserves the required connection to PACS. It does not fix the unsupported operating system, but it changes the MRI from a hospital-wide pivot risk into a more contained legacy system risk.

## Conclusion

The MRI workstation cannot be secured through normal patching, replacement, or disconnection because each of those options conflicts with medical certification, budget, or patient care requirements. MedDefense should therefore treat the workstation as a high-risk legacy asset and apply compensating controls around it. The most important immediate action is to isolate the MRI workstation from the general hospital network while allowing only the minimum required communication with PACS.

