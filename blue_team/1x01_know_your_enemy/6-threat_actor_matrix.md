# MedDefense Threat Actor Matrix

## Overview

This matrix consolidates the threat actor analysis developed across the MedDefense threat intelligence work. It prioritizes six actor types and evaluates each one across likelihood, capability, motivation, preferred vector, likely target, and MedDefense-specific exposure.

The matrix uses the following prior work as reference points:

- **T0 Threat Landscape:** healthcare ransomware statistics, actor categories, and MedDefense relevance.
- **T1 Threat Actor Taxonomy:** actor capability, resources, sophistication, and motivations.
- **T2 Ransomware Assessment:** BlackReef RaaS lifecycle and MedDefense ransomware exposure.
- **T3 Insider Assessment:** malicious and negligent insider scenarios.
- **T4 Social Engineering Analysis:** phishing, vishing, smishing, BEC, impersonation, watering hole, brand impersonation, and typosquatting vectors.
- **T5 Supply Chain Assessment:** vendor compromise paths through MedTech Solutions, Microsoft, Sophos, Siemens, and Greenfield Building Management.
- **1x00 Posture Findings:** public-facing system exposure, flat network, weak identity controls, shared accounts, stale accounts, shadow IT, weak monitoring, non-isolated backups, and lack of tested incident response.

---

## Threat Actor Matrix

| Actor Type | Likelihood | Capability | Primary Motivation | Preferred Vector | Primary Target | MedDefense Exposure |
|---|---|---|---|---|---|---|
| **Ransomware Groups / Organized Crime** | **Critical**. Healthcare was identified in T0 as the most-targeted critical infrastructure sector for ransomware, representing 25% of reported ransomware incidents across the 16 critical infrastructure sectors. T0 also states that 73% of healthcare ransomware incidents involved data exfiltration before encryption. MedDefense fits the preferred victim profile: a regional hospital with regulated patient data, operational urgency, limited security resources, and known technical gaps. | **Medium to High**. T1 classifies organized crime as externally operated, financially motivated, and medium-to-high sophistication. T2 shows that BlackReef affiliates may use phishing, purchased access, VPN exploits, credential harvesting, lateral movement, backup neutralization, data exfiltration, and GPO-based ransomware deployment. | **Financial gain** through ransomware payment, double extortion, sale of patient data, and operational pressure. | Public-facing application or VPN exploit, phishing, valid credentials, vendor access, or purchased access from an Initial Access Broker. T2 specifically highlights VPN appliance CVEs, web applications, exposed RDP, phishing, and IAB access. T4 adds phishing and brand impersonation as likely credential-entry paths. T5 adds vendor compromise through MedTech or Microsoft. | EHR server, patient records, Active Directory, backup systems, file servers, billing systems, and all reachable Windows endpoints. These align with the top MedDefense assets: EHR/patient data, domain infrastructure, backups, billing systems, and endpoint fleet. | **MD-GAP-01:** unpatched public-facing systems. **MD-GAP-02:** flat network/lack of segmentation. **MD-GAP-03:** weak identity and privilege management. **MD-GAP-04:** non-isolated backups. **MD-GAP-05:** no SIEM/IDS/effective monitoring. **MD-GAP-06:** no tested incident response plan. |
| **Nation-State APT** | **Low to Medium**. T0 and T1 indicate that nation-state actors usually target healthcare research, pharmaceutical companies, vaccine research, clinical trial data, genetic databases, or strategic national-interest data. MedDefense has no research programs, reducing direct likelihood. Risk increases if MedDefense becomes connected to clinical trials, university research, pharmaceutical partners, or a high-value supply chain. | **High**. T1 describes nation-state actors as highly resourced and sophisticated, using custom malware, zero-day exploitation, stolen certificates, stealth, prolonged dwell time, and strategic targeting. | **Espionage**, strategic intelligence collection, intellectual property theft, or pre-positioning in critical infrastructure. | Spear phishing, zero-day or n-day exploitation of public-facing systems, supply chain compromise, stealthy credential theft, or compromise of a trusted vendor. T5 supply chain exposure through Microsoft, MedTech, Siemens, or Sophos could create an indirect path. | If targeting MedDefense directly, likely targets are EHR data, executive email, identity systems, clinical research-adjacent data, medical device networks, or access to healthcare partners. If targeting indirectly, MedDefense may be a stepping stone to another partner. | **MD-GAP-01:** public-facing exposure. **MD-GAP-03:** weak identity/PAM. **MD-GAP-05:** weak monitoring. **MD-GAP-VRM-01:** third-party/vendor access governance gaps. **MD-GAP-ASSET-01:** limited asset visibility, especially unmanaged or legacy systems. |
| **Insider / Malicious** | **Medium to High**. T0 notes that insiders account for a meaningful portion of healthcare data breaches, and T3 shows realistic MedDefense scenarios involving unauthorized EHR access and post-termination account use. MedDefense's broad clinical access model and weak monitoring increase the likelihood that malicious use of legitimate access could occur. | **Low to Medium**. Malicious insiders may not need advanced tools because they already have legitimate access, internal knowledge, or privileged accounts. Capability becomes medium when the insider has IT admin privileges, knowledge of backups, or access to EHR/export functions. | **Revenge**, financial gain, curiosity, data theft, or sabotage. The dominant motivation depends on role: terminated IT staff may seek revenge; staff accessing patient records may act out of curiosity or personal benefit; billing or clinical staff may steal records for resale. | Legitimate access abuse, stale account use, shared credentials, unauthorized EHR browsing, USB export, email forwarding, personal cloud storage, or use of a secondary VPN account. T3 scenarios include the Ghost Account and Curious Employee cases. | EHR records, claims/billing data, VIP patient records, Active Directory, production databases, privileged accounts, and internal file shares. | **GAP-IAM-01:** shared credentials. **GAP-IAM-02:** no automated offboarding/stale accounts. **GAP-MON-01:** insufficient monitoring of inappropriate EHR access. **GAP-IAM-03:** weak privileged credential management. **GAP-TRAIN-01:** weak privacy/security awareness reinforcement. |
| **Insider / Negligent** | **High**. Negligent insider risk is highly likely because MedDefense already has scenarios involving shared logins, personal NAS usage, and unsafe credential handling. Healthcare staff are busy, need broad access, and often prioritize patient care or operational convenience over security process. | **Low**. Negligent insiders usually do not need advanced capability. The risk comes from unsafe workarounds, poor process, weak training, and lack of enforcement rather than deliberate attack tooling. | **Ethical motivations**, convenience, helpfulness, productivity, curiosity, or error. The user often believes they are helping the organization or making work faster. | Shared accounts, shadow IT, personal NAS devices, plaintext credentials in scripts, email sharing of admin scripts, weak logout practices, misdirected data, and personal storage of patient files. T3 covers all of these directly. | Patient files, PACS workstations, EHR records, unmanaged devices, AD admin credentials, research/convenience copies, and internal scripts. | **GAP-IAM-01:** shared credentials. **GAP-ASSET-01:** shadow IT/unmanaged devices. **GAP-DATA-01:** uncontrolled patient-data storage. **GAP-IAM-03:** weak privileged credential management. **GAP-PROC-01:** lack of secure administrative automation standards. |
| **Hacktivist** | **Low to Medium**. T0 and T1 indicate that hacktivists are less frequent in healthcare than ransomware actors, but attacks are increasing during political, social, or geopolitical events. MedDefense has no major public controversy, but could become a target if connected to healthcare policy, pricing, reproductive health, public health decisions, or geopolitical campaigns against hospitals. | **Low to Medium**. T1 classifies hacktivists as usually low-to-medium sophistication, relying on public tools, DDoS, defacement, leaked credentials, and public vulnerability exploitation. | **Philosophical or political beliefs**, publicity, disruption, or protest. | Website defacement, DDoS, credential leaks, social media pressure, public data leaks, or exploitation of web vulnerabilities. T1 Report C and T4 impersonation/social pressure patterns support this actor style. | Public website, patient portal availability, social media reputation, public-facing applications, and possibly exposed patient data if used for publicity. | **MD-GAP-01:** public-facing web/application exposure. **MD-GAP-05:** limited monitoring and alerting. **GAP-TRAIN-01:** weak reporting/security awareness. **MD-GAP-06:** no tested incident response plan for public disruption or crisis communication. |
| **Unskilled / Opportunistic Attacker** | **High**. T0 and T1 show that opportunistic attackers scan the internet for exposed systems rather than selecting targets manually. MedDefense already had a crypto-miner incident on `billing-srv-01`, proving that its exposed systems can be found and exploited. | **Low**. T1 classifies this actor as low-resource and low-sophistication, using public CVEs, automated scanners, commodity malware, default credentials, credential stuffing, and public exploit scripts. | **Financial gain** or chaos. In MedDefense's case, the most likely motivation is low-effort financial gain through crypto-mining, botnet enrollment, credential theft, or resale of access. | Automated scanning for known CVEs, exploitation of unpatched public-facing systems, weak/default credentials, exposed RDP, exposed web apps, typosquatting, or credential stuffing. T4 smishing/typosquatting can also support low-skill credential harvesting. | Exposed web servers, VPN appliances, remote management tools, billing server, unmanaged devices, and any internet-facing service. | **MD-GAP-01:** unpatched public-facing systems. **GAP-ASSET-01:** unmanaged devices/shadow IT. **MD-GAP-05:** weak monitoring. **MD-GAP-02:** flat network if the initial compromise can pivot internally. **GAP-IAM-01:** weak/shared credentials. |

---

## Actor-by-Actor Notes

### Ransomware Groups / Organized Crime

This is the most direct and dangerous actor category for MedDefense. The organization matches the ransomware victim profile: a mid-size regional hospital with sensitive patient data, clinical urgency, limited security resources, and known weaknesses in patching, segmentation, identity, backups, monitoring, and incident response. BlackReef-style actors would not need a sophisticated custom operation; they could exploit existing gaps through VPN compromise, phishing, purchased credentials, or vendor access.

### Nation-State APT

Nation-state likelihood is lower because MedDefense has no research programs, pharmaceutical IP, or clinical trial function. However, capability and impact remain high if MedDefense is targeted through a supply chain or as a healthcare infrastructure node. APTs are most concerning where vendor access, cloud identity, medical devices, or public-facing systems create a stealthy path into the environment.

### Insider / Malicious

Malicious insiders are dangerous because they use legitimate access and may already know where sensitive data lives. MedDefense has several enabling conditions: shared accounts, stale access, weak EHR monitoring, broad clinical access, and weak privileged credential control. The likely impact ranges from privacy breach to sabotage of systems or data.

### Insider / Negligent

Negligent insiders are highly likely because the organization already shows unsafe patterns: shared PACS login, personal NAS usage, and plaintext administrator credentials. These are not traditional attacks, but they create attacker-ready conditions. Negligent behavior can expose patient data, weaken accountability, and create entry points later abused by external actors.

### Hacktivist

Hacktivists are less likely than ransomware or insider threats, but their attacks can still disrupt hospital operations and reputation. The most likely MedDefense impact would be DDoS, public website defacement, patient portal disruption, or data exposure for publicity. This actor becomes more relevant if MedDefense becomes associated with a controversial policy or a geopolitical campaign.

### Unskilled / Opportunistic Attacker

This actor category is highly likely because internet-scale scanning makes exposure a continuous risk. The previous crypto-miner incident on `billing-srv-01` demonstrates that MedDefense has already been touched by opportunistic exploitation. The impact may start small, but a foothold from an unskilled actor can be sold to a more capable criminal group.

---

## Top 3 Priority Ranking

### 1. Ransomware Groups / Organized Crime

Ransomware groups are the highest-priority threat because they combine **Critical likelihood** with **Critical impact**. T0 shows that healthcare is a leading ransomware target and that data exfiltration is now common before encryption. T2 shows that BlackReef-style ransomware operators specifically prefer hospitals because clinical urgency, valuable patient data, legacy systems, cyber insurance, and regulatory pressure all increase payment leverage. MedDefense also has gaps that map directly to the ransomware attack chain: unpatched public-facing systems enable initial access, flat networking enables lateral movement, weak identity controls support privilege escalation, reachable backups increase payment pressure, and weak monitoring prevents pre-encryption detection. A successful ransomware attack could interrupt patient care, expose regulated data, create ambulance diversions, trigger regulatory obligations, damage public trust, and cause major financial loss.

### 2. Insider / Negligent

Negligent insiders are the second priority because they are **highly likely** and can create the conditions that make external attacks successful. Unlike ransomware operators, negligent insiders may not intend harm, but their behavior undermines the control environment from the inside. The shared Radiology login destroys accountability, the personal NAS creates unmonitored patient-data storage, and plaintext administrator credentials can turn a simple mistake into domain-level compromise. In healthcare, this threat is especially important because staff need fast access to data and systems, which makes over-restriction impractical. The defensive focus must therefore be governance and detection: unique accounts, approved storage, secure automation, access reviews, NAC, DLP, and targeted training.

### 3. Insider / Malicious

Malicious insiders rank third because their likelihood is lower than negligent insider behavior but their impact can be severe. They already have legitimate access, understand internal workflows, and may know which records, databases, or administrative functions matter most. The Ghost Account scenario and Curious Employee scenario show two high-impact paths: post-termination access can become sabotage or unauthorized remote access, while inappropriate EHR access can become a privacy breach and reputational incident. MedDefense's weak offboarding, shared accounts, limited EHR monitoring, and weak privileged access management increase the risk that malicious activity would not be detected until after damage occurs.

---

## Why Other Actors Rank Lower

**Unskilled/opportunistic attackers** are very likely, but their typical impact is lower unless they create a foothold that is later sold or used by organized crime. They remain important because public-facing exposure can turn a low-skill compromise into an initial access broker opportunity.

**Nation-state APTs** have very high capability, but they are less likely to target MedDefense directly because the hospital has no research program or obvious strategic intelligence value. Their risk becomes more serious through supply chain pathways or future research partnerships.

**Hacktivists** can disrupt public-facing services and reputation, but MedDefense currently has no strong political or ideological profile. The risk would increase during public controversy, geopolitical campaigns, or healthcare policy disputes.

---

## Final Board-Level Summary

The Board should worry most about actors that combine high likelihood with high operational impact. For MedDefense, that means ransomware groups first, negligent insiders second, and malicious insiders third. Ransomware is the most dangerous external threat because MedDefense's current gaps align closely with the BlackReef attack lifecycle. Insider risk is the most persistent internal threat because healthcare staff need broad access, and MedDefense lacks strong accountability, monitoring, and governance around that access. The immediate strategic priority is to break the ransomware attack chain while strengthening insider-risk controls: patch public-facing systems, segment the network, enforce MFA and least privilege, isolate backups, monitor EHR and privileged activity, eliminate shared accounts, and implement time-bound third-party access.

