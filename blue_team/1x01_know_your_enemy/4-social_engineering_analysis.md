# Social Engineering Analysis for MedDefense

## Overview

This document analyzes seven social engineering scenarios targeting MedDefense.  
Each scenario is classified using Security+ 2.2 human-targeted attack vectors and mapped to the target role, psychological lever, observable red flags, and recommended countermeasures.

Social engineering is especially dangerous in healthcare because staff are trained to be responsive, helpful, and fast. Attackers exploit urgency, authority, familiarity, fear, curiosity, and helpfulness to bypass technical controls through human behavior.

---

## Scenario 1

**Scenario:**  
An email arrives in the inbox of Sarah Park, IT Director, appearing to come from FortiGate support:  
"Critical firmware vulnerability detected on your FortiGate 100F. Click here to download the emergency patch. Failure to patch within 24 hours may result in service termination."  
The sender domain is `fortinet-support.net`.

### Vector Type: Brand impersonation

This is a brand impersonation attack delivered through email. The attacker impersonates FortiGate/Fortinet support to make the message look like a legitimate vendor security notification.

### Target

**Sarah Park, IT Director**  
She is vulnerable because she is responsible for perimeter security, firmware updates, and urgent remediation of critical infrastructure vulnerabilities. A message about a FortiGate appliance directly matches her responsibilities.

### Psychological Lever

**Urgency and fear**  
The message creates time pressure by saying the vulnerability must be patched within 24 hours and threatens service termination.

### Red Flags

- The sender domain is `fortinet-support.net`, not an official Fortinet domain.
- The message pressures the recipient to download an emergency patch from an email link instead of using the official vendor portal.
- The threat of "service termination" is unusual for a firmware vulnerability notification.

### Technical Control

Implement **email security controls with domain authentication and URL rewriting**, including SPF, DKIM, DMARC validation, attachment sandboxing, and blocking of lookalike vendor domains.

### Administrative Control

Require that all firewall and VPN firmware updates be downloaded only from the **official vendor support portal** after independent verification through an approved change management process.

---

## Scenario 2

**Scenario:**  
The CFO, Robert Kim, receives an email appearing to come from Dr. Patricia Morales, CEO:  
"Robert, I need you to process a wire transfer of $85,000 to the account below immediately. This is for a confidential equipment acquisition. Do not discuss with anyone until the deal closes. I am in meetings all day, email only."  
The sender address has a subtle difference from the real CEO email.

### Vector Type: Business Email Compromise (BEC)

This is a BEC attempt because the attacker impersonates the CEO to trick the CFO into making a fraudulent wire transfer.

### Target

**Robert Kim, CFO**  
He is vulnerable because he has authority over financial transfers and may be accustomed to urgent executive-level financial requests.

### Psychological Lever

**Authority and urgency**  
The email uses the CEO's authority and demands immediate action while discouraging verification.

### Red Flags

- The sender address has a subtle difference from the real CEO email address.
- The request demands secrecy and says not to discuss the transaction with anyone.
- The CEO requests a large wire transfer while claiming to be unavailable except by email.

### Technical Control

Deploy **email impersonation protection** that flags lookalike domains, display-name spoofing, and unusual executive payment requests.

### Administrative Control

Require **dual approval and out-of-band verification** for all wire transfers above a defined threshold, especially when requested by email or involving new bank details.

---

## Scenario 3

**Scenario:**  
A nurse at MedDefense Central answers the phone. The caller identifies themselves as "Mike from IT" and says:  
"We're doing an emergency security audit after the billing server incident. I need to verify your login works correctly. Can you read me your username and the password you use for the EHR system?"

### Vector Type: Vishing

This is vishing because the attacker uses a voice/phone call to socially engineer the nurse into revealing credentials.

### Target

**Nurse at MedDefense Central**  
The nurse is vulnerable because clinical staff are busy, trained to be helpful, and may comply quickly with requests that appear to come from IT during an emergency.

### Psychological Lever

**Authority and helpfulness**  
The caller claims to be from IT and uses the recent billing server incident as a pretext to make the request sound legitimate.

### Red Flags

- IT should never ask a user to read their password over the phone.
- The caller uses an urgent "emergency security audit" to pressure compliance.
- The nurse cannot independently verify that the caller is really from IT.

### Technical Control

Implement **phishing-resistant MFA** for EHR access so stolen passwords alone cannot be used to log in.

### Administrative Control

Create and train staff on a **help desk identity verification policy**: IT must never ask for passwords, and staff must call back through the official help desk number for any credential-related request.

---

## Scenario 4

**Scenario:**  
All MedDefense employees receive a text message:  
"MedDefense Parking: Your staff parking permit expires tomorrow. Renew immediately to avoid towing: [link]."  
The link leads to a page that looks like MedDefense's internal HR portal and asks for AD credentials.

### Vector Type: Smishing

This is smishing because the attack uses SMS text messages to lure employees to a credential-harvesting page.

### Target

**All MedDefense employees**  
Employees are vulnerable because parking is a normal staff concern, the message affects everyone, and the threat of towing creates immediate pressure.

### Psychological Lever

**Urgency and fear**  
The message warns that the parking permit expires tomorrow and threatens towing if action is not taken.

### Red Flags

- The parking renewal request arrives by SMS instead of through the official HR or facilities system.
- The link asks for AD credentials on a page reached from a text message.
- The message creates a deadline and threat of towing to pressure quick action.

### Technical Control

Deploy **mobile threat defense and DNS/web filtering** to block known phishing domains and credential-harvesting pages on managed devices.

### Administrative Control

Establish a policy that staff parking, HR, and benefits updates are communicated only through approved internal channels, not through unsolicited SMS links.

---

## Scenario 5

**Scenario:**  
The website of the Regional Healthcare Association, an industry group MedDefense physicians visit monthly for CME credits, is compromised. Visitors browsing specific pages are silently redirected to a site that attempts to exploit a browser vulnerability to install malware.

### Vector Type: Watering hole attack

This is a watering hole attack because the attacker compromises a website frequently visited by the intended victim group and uses it to infect visitors.

### Target

**MedDefense physicians**  
They are vulnerable because they regularly visit the Regional Healthcare Association website for CME credits and likely trust the site.

### Psychological Lever

**Familiarity and trust**  
The attack relies on users trusting a legitimate industry website they already visit for professional purposes.

### Red Flags

- Browser redirects to an unexpected domain after visiting a CME page.
- Browser warnings, pop-ups, or unexpected downloads appear from a normally trusted site.
- Security tools detect exploit attempts or unusual network connections after visiting the site.

### Technical Control

Use **endpoint detection and response (EDR), browser isolation, and web filtering** to block exploit attempts and suspicious redirects from compromised websites.

### Administrative Control

Define a process for reporting suspicious behavior on trusted professional websites and require browsers to remain updated through managed patching.

---

## Scenario 6

**Scenario:**  
Someone registers the domain `meddefence-portal.com` using "defence" instead of "defense." They create a pixel-perfect copy of MedDefense's patient portal. Google Ads are purchased so the fake portal appears above the real one in search results for "MedDefense patient portal."

### Vector Type: Typosquatting

This is typosquatting because the attacker registers a lookalike domain that relies on a spelling variation of the legitimate MedDefense domain.

### Target

**Patients and possibly MedDefense staff**  
Patients are vulnerable because they may search for the patient portal instead of typing the known URL. Staff may also be fooled if they use search results to access the portal.

### Psychological Lever

**Familiarity and trust**  
The fake portal looks like the real MedDefense portal and appears in search results, making users believe it is legitimate.

### Red Flags

- The domain uses `meddefence` instead of `meddefense`.
- The fake portal appears as a sponsored search result above the real portal.
- The site asks for credentials or personal information on a domain that does not match MedDefense's official domain.

### Technical Control

Implement **domain monitoring and takedown services** for lookalike domains, plus HSTS, certificate monitoring, and brand abuse detection.

### Administrative Control

Publish and train users on the official patient portal URL, and include warnings that MedDefense will not ask patients or staff to log in through sponsored search links.

---

## Scenario 7

**Scenario:**  
A person in scrubs carrying a stethoscope and a hospital-branded coffee cup approaches the restricted corridor leading to the IT department. They follow a staff member through the badge-controlled door, saying:  
"Thanks! My badge is in my locker, I'm just running back to grab something from my desk."  
Their visitor badge, partially hidden by the stethoscope, expired two days ago.

### Vector Type: Impersonation

This is impersonation because the person presents themselves as hospital staff or an authorized clinical worker to gain physical access to a restricted area.

### Target

**Staff member entering the restricted IT corridor**  
The staff member is vulnerable because the person looks familiar and credible in the hospital environment, and social norms make people reluctant to challenge someone in scrubs.

### Psychological Lever

**Familiarity and helpfulness**  
The attacker uses hospital clothing, a stethoscope, a branded coffee cup, and friendly language to appear legitimate and make the staff member feel comfortable holding the door.

### Red Flags

- The person is trying to enter a restricted IT area without using their own badge.
- The visitor badge is partially hidden and expired.
- The excuse "my badge is in my locker" is used to bypass badge-controlled access.

### Technical Control

Use **anti-tailgating access controls** such as badge turnstiles, mantraps, door alarms, and CCTV monitoring for restricted IT areas.

### Administrative Control

Enforce a **no-tailgating policy** requiring every person to badge in individually. Staff should be trained to politely challenge unknown individuals and report expired or hidden badges to security.

---

## Summary Table

| Scenario | Vector Type | Target | Psychological Lever | Main Technical Control | Main Administrative Control |
|---|---|---|---|---|---|
| 1 | Brand impersonation | IT Director | Urgency / Fear | Email security and lookalike-domain detection | Vendor patch verification through change management |
| 2 | Business Email Compromise | CFO | Authority / Urgency | Executive impersonation detection | Dual approval and out-of-band verification |
| 3 | Vishing | Nurse | Authority / Helpfulness | Phishing-resistant MFA | Help desk verification and no-password-disclosure policy |
| 4 | Smishing | All employees | Urgency / Fear | Mobile threat defense and DNS/web filtering | Approved HR/parking communication channels |
| 5 | Watering hole attack | Physicians | Familiarity / Trust | EDR, browser isolation, web filtering | Suspicious-site reporting and managed browser patching |
| 6 | Typosquatting | Patients / staff | Familiarity / Trust | Domain monitoring and takedown | Publish official portal URL and warn against sponsored links |
| 7 | Impersonation | Staff entering IT corridor | Familiarity / Helpfulness | Anti-tailgating controls | No-tailgating and badge challenge policy |

---

## Final Assessment

The seven scenarios show that social engineering risk at MedDefense is not limited to phishing emails. Attackers can target executives, clinicians, IT staff, patients, and physical access controls by exploiting normal healthcare behaviors: urgency, helpfulness, trust, and reluctance to challenge others. The strongest defense is layered: technical controls reduce the chance that malicious links, lookalike domains, malware, and credential theft succeed, while administrative controls ensure staff know how to verify requests, report suspicious activity, and refuse unsafe shortcuts even under pressure.

