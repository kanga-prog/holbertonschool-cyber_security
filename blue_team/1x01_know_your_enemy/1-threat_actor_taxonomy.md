# Threat Actor Taxonomy

## Overview

This document classifies eight anonymized intelligence reports using the required six threat actor categories:

- Nation-state
- Organized crime
- Hacktivist
- Insider threat
- Unskilled attacker
- Shadow IT

Each classification is based on observable behavior: access method, target selection, resources, sophistication, motivation, and confidence level.

---

## Report A

**Actor Type:** Nation-state

**Internal/External:** External  
The actor entered through a zero-day vulnerability in the company's VPN appliance. This indicates an external intrusion rather than activity from a legitimate internal user.

**Resources:** High  
The actor used a zero-day vulnerability, a custom-built remote access tool, encrypted DNS communication, and a stolen code-signing certificate. These capabilities require strong funding, infrastructure, and technical expertise.

**Sophistication:** High  
The operation lasted 14 months and involved stealthy, systematic theft of proprietary drug trial data. Custom malware, encrypted DNS command-and-control, code-signing abuse, and long dwell time show advanced tradecraft.

**Primary Motivation:** Espionage  
The stolen Phase III clinical trial data was valuable intellectual property worth an estimated $2 billion in future revenue. The objective was strategic information theft rather than disruption or immediate payment.

**Confidence Level:** High  
Confidence is high because zero-day exploitation, custom tooling, stealthy persistence, and theft of pharmaceutical research strongly match a nation-state or advanced persistent threat profile.

---

## Report B

**Actor Type:** Organized crime

**Internal/External:** External  
The attack began with an external phishing email campaign against the hospital billing department and ended with ransomware deployment.

**Resources:** Medium  
The attackers used a known Adobe Reader vulnerability and a commercially available RAT. This suggests access to criminal tooling, ransomware infrastructure, and extortion processes, but not nation-state-level resources.

**Sophistication:** Medium to High  
The attackers successfully phished users, exploited a known vulnerability, maintained access for three weeks, exfiltrated 15GB of patient records, and deployed ransomware across the hospital network.

**Primary Motivation:** Financial gain  
The demand for 40 Bitcoin and the threat to publish patient records show a financially motivated ransomware and double-extortion operation.

**Confidence Level:** High  
Confidence is high because ransomware deployment, patient-data exfiltration, cryptocurrency payment demand, and publication threats are classic organized crime indicators.

---

## Report C

**Actor Type:** Hacktivist

**Internal/External:** External  
The attackers exploited a SQL injection vulnerability in the hospital's public website. They did not use internal access and did not attempt to move beyond the public web server.

**Resources:** Low to Medium  
The actor used a web application vulnerability and performed a public website defacement. This requires some technical ability but not major funding or advanced infrastructure.

**Sophistication:** Low to Medium  
The attack was limited to website defacement. There was no patient-data access, lateral movement, persistence, ransomware deployment, or internal network compromise.

**Primary Motivation:** Philosophical or political beliefs  
The defacement criticized the hospital's decision to close a free community health clinic and included the logo of an activist group. The goal was protest and public messaging.

**Confidence Level:** High  
Confidence is high because the attack included an activist message, a known activist logo, and no evidence of financial gain, espionage, or internal sabotage.

---

## Report D

**Actor Type:** Insider threat

**Internal/External:** Internal  
The actor was a terminated IT administrator who had privileged knowledge of the environment. The unauthorized VPN account was created before termination and later used from the administrator's home IP address.

**Resources:** Low to Medium  
The actor did not need expensive tools or external infrastructure. Their main resources were privileged access, internal knowledge, and the ability to create a secondary VPN account.

**Sophistication:** Medium  
The actor created a hidden VPN account, disabled automated backups before termination, and later deleted production database tables. This shows planning and insider knowledge.

**Primary Motivation:** Revenge  
The sabotage occurred two days after termination following a disciplinary hearing. The timing and destructive behavior strongly indicate retaliation.

**Confidence Level:** High  
Confidence is high because the hidden VPN account, home IP address, backup sabotage, and termination timeline directly support an insider threat classification.

---

## Report E

**Actor Type:** Unskilled attacker

**Internal/External:** External  
The compromise came through automated exploitation of a known remote management tool vulnerability. The same wallet was linked to infections across more than 300 organizations, showing mass external exploitation.

**Resources:** Low  
The actor used a public CVE and publicly available cryptocurrency mining software. This indicates low-cost commodity tooling.

**Sophistication:** Low  
There was no lateral movement, no patient-data access, no persistent backdoor, and no targeted reconnaissance. The behavior matches automated opportunistic exploitation.

**Primary Motivation:** Financial gain  
The actor installed Monero mining software to profit from the victim's computing resources.

**Confidence Level:** High  
Confidence is high because the report explicitly describes public tools, mass automated exploitation, no targeting, and cryptocurrency mining.

---

## Report F

**Actor Type:** Shadow IT

**Internal/External:** Could be either  
The root cause was internal shadow IT: a biomedical engineering employee connected a personal Raspberry Pi to the medical device network without authorization. However, the actual compromise was performed by an external attacker who found the exposed device and used default credentials.

**Resources:** Low  
The employee used a personal Raspberry Pi, and the external attacker only needed to discover the exposed port and use default credentials.

**Sophistication:** Low  
The incident resulted from unauthorized device deployment, poor configuration, outdated software, and default credentials. The external exploitation did not require advanced techniques.

**Primary Motivation:** Ethical motivations  
The employee had no malicious intent and claimed the device was used to monitor network performance for a personal project. The motivation was curiosity, learning, or perceived operational improvement, not sabotage or financial gain.

**Confidence Level:** High  
Confidence is high because the key enabling behavior was an unauthorized personal device connected to a sensitive medical network, which is a clear shadow IT scenario.

---

## Report G

**Actor Type:** Organized crime

**Internal/External:** External  
The most likely scenario is an external attacker using stolen or compromised physician credentials. The physician was on extended medical leave, was out of the country, denied involvement, and the account was used during off-hours. These facts make direct physician misuse less likely.

**Resources:** Medium  
The actor did not use obvious malware or custom tools, but the activity lasted six weeks and targeted 3,200 patient records. The focus on patients with high-value insurance plans suggests organized selection rather than random curiosity.

**Sophistication:** Medium  
The attacker used legitimate credentials to avoid detection, accessed records during off-hours, and selected patients who may be valuable for insurance fraud. This shows deliberate credential-based data theft.

**Primary Motivation:** Financial gain  
The concentration on patients with high-value insurance plans suggests a likely fraud, resale, or monetization motive. No ransom demand was received, so blackmail is less supported than financial gain through stolen healthcare data.

**Confidence Level:** Medium  
Confidence is medium because organized crime is the best single classification, but the report is intentionally ambiguous. The same activity could also fit insider misuse or another form of credential compromise if additional evidence appears.

### Ambiguity Analysis for Report G

Report G is ambiguous because the access used a legitimate physician account. Valid credentials can hide several different actor types.

**Why organized crime is the best classification:**  
The physician was out of the country and on medical leave, the access occurred only during off-hours, the records were unrelated to the physician's patients, and the records focused on high-value insurance plans. These facts point toward stolen credentials used for healthcare data theft and possible insurance fraud.

**Other plausible actor types:**

- **Insider threat:** Another employee could have known or obtained the physician's credentials and used the account as cover.
- **Unskilled attacker:** This is less likely, but possible if the credentials were obtained through a basic phishing or credential-stuffing attack.
- **Nation-state:** This is unlikely because the target was insurance-rich patient records, not strategic research, government data, or intellectual property.

**Evidence that would help distinguish the actor type:**

1. Authentication logs showing source IP, VPN use, device fingerprint, MFA events, and geolocation.
2. Endpoint evidence showing whether the physician's device or another internal workstation was compromised.
3. Login history showing impossible travel, failed login attempts, or password reset events.
4. Data destination showing whether records were sent to personal cloud storage, criminal infrastructure, or known threat infrastructure.
5. Fraud indicators showing whether the patients later experienced insurance fraud or identity theft.
6. Internal investigation showing whether another employee had motive, opportunity, or access to the physician's credentials.
7. Dark web monitoring showing whether the records later appeared for sale.

---

## Report H

**Actor Type:** Organized crime

**Internal/External:** External  
The unauthorized access came from a Tor exit node, and the sender demanded cryptocurrency in exchange for not publishing the vulnerability and stolen patient records.

**Resources:** Medium  
The actor exploited a broken authentication endpoint in a patient scheduling API and extracted 2,000 patient records. This required technical skill but not custom malware, zero-day exploitation, or nation-state resources.

**Sophistication:** Medium  
The actor identified and exploited an authentication flaw, used Tor for anonymity, exfiltrated authentic patient records, and used the data as proof for extortion.

**Primary Motivation:** Blackmail  
The actor demanded $50,000 in cryptocurrency and threatened to publish the vulnerability details and stolen patient records. This is a clear blackmail/extortion scenario.

**Confidence Level:** High  
Confidence is high because the cryptocurrency demand, proof of stolen data, Tor access, and publication threat clearly indicate organized criminal extortion.

---

## Summary Table

| Report | Actor Type | Internal / External | Resources | Sophistication | Primary Motivation | Confidence |
|---|---|---|---|---|---|---|
| A | Nation-state | External | High | High | Espionage | High |
| B | Organized crime | External | Medium | Medium to High | Financial gain | High |
| C | Hacktivist | External | Low to Medium | Low to Medium | Philosophical or political beliefs | High |
| D | Insider threat | Internal | Low to Medium | Medium | Revenge | High |
| E | Unskilled attacker | External | Low | Low | Financial gain | High |
| F | Shadow IT | Could be either | Low | Low | Ethical motivations | High |
| G | Organized crime | External | Medium | Medium | Financial gain | Medium |
| H | Organized crime | External | Medium | Medium | Blackmail | High |

---

## Final Assessment

The reports show that threat actor classification must be based on observed behavior rather than assumptions. Reports A, B, C, D, E, F, and H have strong indicators that support clear classification.

Report G remains the most ambiguous case, but it still requires a primary classification. The best classification is organized crime because the access occurred through likely stolen credentials and targeted patients with high-value insurance plans, which supports a financial fraud or resale motive. The ambiguity should be preserved in the analysis, but the report should still have one main actor type.

