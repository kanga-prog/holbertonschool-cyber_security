# Threat Actor Taxonomy

## Overview

This document classifies eight anonymized intelligence reports using the six required threat actor categories:

* Nation-state
* Organized crime
* Hacktivist
* Insider threat
* Unskilled attacker
* Shadow IT

Each report is classified based on observable behavior: what the actor did, how they operated, what they targeted, and what motivation is most strongly supported by the evidence.

---

## Report A

**Actor Type:** Nation-state

**Internal/External:** External
The attackers compromised the company through a zero-day vulnerability in the VPN appliance. This indicates an external intrusion rather than misuse of legitimate internal access.

**Resources:** High
The actor used a zero-day vulnerability, a custom-built remote access tool, encrypted DNS communications, and a stolen code-signing certificate. These capabilities require significant resources, infrastructure, and operational maturity.

**Sophistication:** High
The attack lasted 14 months and involved stealthy, systematic copying of proprietary drug trial data. Custom malware, encrypted DNS command-and-control, code-signing abuse, and long dwell time are strong indicators of advanced tradecraft.

**Primary Motivation:** Espionage
The stolen Phase III clinical trial data was highly valuable strategic intellectual property. The objective appears to be intelligence collection and theft of proprietary research rather than immediate extortion or disruption.

**Confidence Level:** High
Confidence is high because the combination of zero-day exploitation, custom tooling, stealth, long-term persistence, and theft of high-value pharmaceutical research strongly matches a nation-state or advanced persistent threat profile.

---

## Report B

**Actor Type:** Organized crime

**Internal/External:** External
The attack began with an external email campaign against the hospital billing department and later escalated into ransomware deployment and extortion.

**Resources:** Medium
The attackers used a known Adobe Reader vulnerability and a commercially available RAT, which suggests access to criminal tooling but not necessarily nation-state-level resources. The later ransomware deployment and data exfiltration show organized criminal capability.

**Sophistication:** Medium to High
The attackers successfully phished users, exploited a known vulnerability, maintained access for three weeks, exfiltrated 15GB of patient records, and deployed ransomware across the network. This is more sophisticated than a simple commodity attack, but it relies on known vulnerabilities and available tools.

**Primary Motivation:** Financial gain
The ransom demand of 40 Bitcoin and the threat to publish patient data show a financially motivated double-extortion operation. Blackmail is part of the method, but financial gain is the primary motivation.

**Confidence Level:** High
Confidence is high because ransomware deployment, data theft, cryptocurrency demand, and a publication threat are classic organized crime indicators.

---

## Report C

**Actor Type:** Hacktivist**

**Internal/External:** External
The attackers exploited a SQL injection vulnerability in the public website’s content management system. They did not use internal privileges or attempt to move into internal hospital systems.

**Resources:** Low to Medium
The actor used a web application vulnerability and performed a defacement. This does not require major funding, but it does require some technical ability.

**Sophistication:** Low to Medium
The attack was limited to website defacement through SQL injection. The attackers did not attempt lateral movement, persistence, ransomware deployment, or patient data theft.

**Primary Motivation:** Philosophical or political beliefs
The defacement criticized the hospital’s decision to close a free community health clinic and included the logo of an activist group. The goal was protest and public messaging.

**Confidence Level:** High
Confidence is high because the attack included a political/social message, activist branding, and no financial or espionage objective.

---

## Report D

**Actor Type:** Insider threat

**Internal/External:** Internal
The attacker was a former IT administrator who had legitimate privileged knowledge and created a secondary VPN account before termination. The activity came from the administrator’s home IP address.

**Resources:** Low to Medium
The actor did not need expensive infrastructure or advanced external tooling. Their main resource was privileged internal knowledge, administrative access, and an unauthorized secondary VPN account.

**Sophistication:** Medium
The attacker created a hidden VPN account, disabled automated backups before termination, and later deleted production database tables. This required insider knowledge and planning, even if it did not involve advanced malware.

**Primary Motivation:** Revenge
The destructive activity occurred two days after termination following a disciplinary hearing. The timing and sabotage strongly suggest retaliation.

**Confidence Level:** High
Confidence is high because attribution to the former administrator is supported by the home IP address, the hidden VPN account, the backup sabotage, and the timing after termination.

---

## Report E

**Actor Type:** Unskilled attacker

**Internal/External:** External
The compromise came through automated exploitation of a known vulnerability in a remote management tool. The same wallet was linked to infections across more than 300 organizations, indicating broad external scanning rather than targeted access.

**Resources:** Low
The attackers used a publicly available mining tool and exploited a CVE published six months earlier. This suggests low-cost, commodity tooling.

**Sophistication:** Low
There was no lateral movement, no patient data access, no persistent backdoor, and no targeted reconnaissance. The behavior matches mass automated exploitation.

**Primary Motivation:** Financial gain
The installation of Monero mining software shows that the actor’s goal was to make money through unauthorized use of victim computing resources.

**Confidence Level:** High
Confidence is high because the report explicitly describes publicly available tooling, mass exploitation, no targeting, and cryptocurrency mining.

---

## Report F

**Actor Type:** Shadow IT

**Internal/External:** Could be either
The root cause was internal shadow IT: a biomedical engineering employee connected a personal Raspberry Pi to the medical device network without authorization. However, an external attacker later discovered the exposed device, used default credentials, and pivoted to the nurse call system. Therefore, the initiating risk was internal, while the exploitation was external.

**Resources:** Low
The employee used a personal Raspberry Pi and default credentials. The external attacker only needed to discover the exposed service and log in with default credentials.

**Sophistication:** Low
The incident resulted from poor configuration, default credentials, and unauthorized device deployment. The external exploitation did not require advanced tools or techniques.

**Primary Motivation:** Ethical motivations
The employee had no malicious intent and claimed to be monitoring network performance for a personal project. The motivation was curiosity, learning, and perceived operational improvement rather than crime or sabotage.

**Confidence Level:** High
Confidence is high for the shadow IT classification because the key enabling behavior was an unauthorized personal device connected to a sensitive medical network. The external attacker is part of the incident chain, but the actor category most directly tested by this report is shadow IT.

---

## Report G

**Actor Type:** Could be insider threat, organized crime, or external credential compromise

**Internal/External:** Could be either
The activity used a legitimate physician account, which could indicate an insider misusing access. However, the physician was on extended medical leave, out of the country, and denied involvement. This also supports the possibility of an external attacker using stolen credentials.

**Resources:** Medium
The actor did not use obvious malware or advanced tooling, but the activity was sustained over six weeks and focused on high-value insurance patients. This suggests more planning than random curiosity, but not enough evidence to prove nation-state or highly resourced activity.

**Sophistication:** Medium
The attacker used legitimate credentials and avoided obvious ransomware, defacement, or noisy malware. The off-hours access pattern and targeted selection of high-value insurance records suggest deliberate data collection.

**Primary Motivation:** Data exfiltration
The clearest observed objective was unauthorized access and download of 3,200 patient records. Because there was no ransom demand and no known dark web posting, financial gain is plausible but not proven.

**Confidence Level:** Low
Confidence is low because the same evidence can support several hypotheses: insider misuse, stolen physician credentials used by organized crime, or another external actor quietly collecting data.

### Ambiguity Analysis for Report G

Report G is deliberately ambiguous because the observed behavior does not clearly identify the actor type.

**Possible actor type 1: Insider threat**
This could be an insider if someone with access to the physician’s credentials used them intentionally. It could also involve credential sharing, a coworker misusing a known password, or someone inside the hospital using the account as cover.

**Possible actor type 2: Organized crime**
This could be organized crime if the physician’s credentials were stolen through phishing, password reuse, malware, or credential markets. The focus on patients with high-value insurance plans supports a possible fraud or resale motive.

**Possible actor type 3: Nation-state or advanced actor**
This is less likely than organized crime or insider misuse, but still possible if the records had strategic intelligence value. However, the report does not mention custom tooling, persistence, infrastructure linked to APT groups, or research data.

**Evidence needed to distinguish the actor type:**

1. Authentication logs: source IP reputation, geolocation, VPN usage, device fingerprint, MFA events, and impossible travel indicators.
2. Endpoint evidence: whether the physician’s device was infected with malware or whether another internal workstation used the account.
3. Account history: password reset events, failed login attempts, credential sharing, or access from unusual devices.
4. Data destination: where the downloaded records were sent and whether the destination matches personal cloud storage, criminal infrastructure, or known threat infrastructure.
5. User context: whether any employee had a motive or opportunity to use the physician’s account.
6. Financial indicators: whether the records later appear in insurance fraud, dark web markets, or extortion attempts.
7. Access pattern: whether the actor accessed only billing-rich records or also searched for other strategic or sensitive data.

**Most likely classification:**
The most likely classification is organized crime using stolen credentials, because the records were concentrated in patients with high-value insurance plans and were accessed while the physician was out of the country. However, confidence remains low without proof of credential theft, data sale, or fraud.

---

## Report H

**Actor Type:** Organized crime

**Internal/External:** External
The unauthorized access came from a Tor exit node, and the sender demanded cryptocurrency in exchange for not publishing the vulnerability and stolen patient records.

**Resources:** Medium
The actor exploited a broken authentication endpoint in a patient scheduling API and extracted 2,000 records. This required technical skill, but there is no evidence of custom malware, zero-days, or nation-state resources.

**Sophistication:** Medium
The actor identified and exploited an authentication flaw, extracted real patient data, used Tor for anonymity, and attempted extortion. This is more capable than a basic script kiddie attack but not highly advanced.

**Primary Motivation:** Blackmail
The actor demanded $50,000 in cryptocurrency and threatened to publish both the vulnerability details and the stolen patient records. The pressure tactic is blackmail/extortion.

**Confidence Level:** High
Confidence is high because the cryptocurrency demand, proof of stolen records, Tor access, and publication threat clearly indicate criminal extortion.

---

## Summary Table

| Report | Actor Type                                                            | Internal / External | Resources     | Sophistication | Primary Motivation                 | Confidence |
| ------ | --------------------------------------------------------------------- | ------------------- | ------------- | -------------- | ---------------------------------- | ---------- |
| A      | Nation-state                                                          | External            | High          | High           | Espionage                          | High       |
| B      | Organized crime                                                       | External            | Medium        | Medium to High | Financial gain                     | High       |
| C      | Hacktivist                                                            | External            | Low to Medium | Low to Medium  | Philosophical or political beliefs | High       |
| D      | Insider threat                                                        | Internal            | Low to Medium | Medium         | Revenge                            | High       |
| E      | Unskilled attacker                                                    | External            | Low           | Low            | Financial gain                     | High       |
| F      | Shadow IT                                                             | Could be either     | Low           | Low            | Ethical motivations                | High       |
| G      | Ambiguous: insider / organized crime / external credential compromise | Could be either     | Medium        | Medium         | Data exfiltration                  | Low        |
| H      | Organized crime                                                       | External            | Medium        | Medium         | Blackmail                          | High       |

## Final Assessment

The eight reports show that threat actor classification should be based on behavior rather than assumptions about identity. Some cases are clear: custom malware and long-term pharmaceutical espionage strongly indicate a nation-state actor, while ransomware and cryptocurrency demands strongly indicate organized crime.

Other cases require more careful reasoning. Report F shows that a security incident can begin with non-malicious shadow IT but still be exploited by an external attacker. Report G shows why analysts must preserve uncertainty: valid credentials, off-hours access, and targeted data theft can fit insider misuse, credential compromise, or organized criminal activity.
::: 

