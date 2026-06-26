# Physical Security Risk Assessment

## Purpose

This document decomposes five physical security observations from the MedDefense Central walk-through into structured risk components. Each observation is analyzed using the following model:

* **Vulnerability**: the specific weakness or gap observed.
* **Threat**: a plausible event or actor that could exploit the weakness.
* **Impact**: the consequence to MedDefense if the threat materializes, mapped to the CIA Triad.
* **Severity**: an overall risk rating justified by the business and security impact.

## Observation 1: Server Room Access

**Vulnerability:**
The server room is located on the ground floor near a corridor shared with the cafeteria, uses the same generic badge issued to all employees, has no camera coverage at the door, and has no visitor log.

**Threat:**
An employee, contractor, visitor following an employee, or malicious insider could enter or approach the server room without specific authorization and without creating a reliable audit trail.

**Impact:**
This creates a risk to **Confidentiality**, **Integrity**, and **Availability**. Unauthorized physical access could allow someone to view, steal, damage, disconnect, or tamper with servers and network equipment supporting clinical, billing, authentication, and administrative services.

**Severity:**
**Critical** — the weakness affects the physical protection of core IT infrastructure, and a single unauthorized action in the server room could disrupt hospital operations, compromise sensitive data, or alter critical systems.

## Observation 2: Network Closet

**Vulnerability:**
The second-floor network closet has no lock, the door is ajar, and switch management credentials are posted on a laminated sheet next to the switch stack.

**Threat:**
Any person with physical access to the area could enter the closet, use the exposed credentials, connect unauthorized devices, change switch settings, intercept traffic, or disable network connectivity.

**Impact:**
This impacts **Confidentiality**, **Integrity**, and **Availability**. Exposed network credentials could allow unauthorized access to network management interfaces, traffic redirection, network configuration changes, or disruption of connectivity for workstations, medical devices, and clinical services.

**Severity:**
**Critical** — the combination of unlocked physical access and exposed administrative credentials creates an immediate path to compromise network infrastructure.

## Observation 3: Nurse Station

**Vulnerability:**
A nurse station workstation is left unattended while logged into the EHR system with a patient record visible, and staff are discouraged from logging out between shifts for efficiency.

**Threat:**
An unauthorized person, including a visitor, patient, contractor, or staff member without a need to know, could view or interact with the active EHR session.

**Impact:**
This primarily impacts **Confidentiality** because protected patient information is visible to unauthorized individuals. It also impacts **Integrity** because an unauthorized person could modify patient records, enter incorrect information, or perform actions under another user's session.

**Severity:**
**High** — the observation exposes patient health information and creates a realistic possibility of unauthorized record modification in a clinical environment.

## Observation 4: Medical IoT

**Vulnerability:**
A connected vital signs monitor displays its IP address and firmware version, has not been updated since 2019, and appears to be on the same IP range as nurse station workstations.

**Threat:**
An attacker or unauthorized internal user could use the exposed IP address and outdated firmware information to identify, target, or exploit the medical device, especially because it appears to share the same network segment as general workstations.

**Impact:**
This impacts **Integrity** and **Availability**, with potential **Confidentiality** concerns. A compromised medical device could display inaccurate readings, become unavailable during patient care, or expose diagnostic and network information useful for further attacks.

**Severity:**
**High** — the device is part of patient care, appears outdated, and lacks visible network isolation from workstations, increasing the risk of clinical and operational impact.

## Observation 5: Emergency Exit

**Vulnerability:**
A fire exit door between the public waiting area and the restricted administrative wing is propped open with a wooden wedge, and a handwritten sign instructs staff not to close it.

**Threat:**
A visitor, patient, contractor, or unauthorized person from the public waiting area could enter the restricted administrative wing without badge access or staff escort.

**Impact:**
This impacts **Confidentiality**, **Integrity**, and **Availability**. Unauthorized access to the administrative wing could expose offices, documents, workstations, IT staff areas, and security personnel locations, enabling data exposure, tampering, theft, or disruption of administrative and IT operations.

**Severity:**
**High** — the open door bypasses access control between public and restricted areas and creates a direct path toward IT and security offices.

## Summary

The walk-through shows that MedDefense Central has multiple physical security weaknesses that create direct cyber and operational risks. The most serious issues are the weak server room access controls and the unsecured network closet with exposed management credentials, because both could allow direct compromise of critical infrastructure.

The nurse station, medical IoT, and emergency exit observations also represent significant risk because they connect physical security weaknesses to patient privacy, clinical system integrity, and unauthorized access to restricted operational areas.

