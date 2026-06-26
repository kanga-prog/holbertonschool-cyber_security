# 1x01 - Know Your Enemy

## Project Overview

This project is part of the Blue Team curriculum and focuses on understanding the threat landscape affecting the healthcare sector. The goal is to transform raw threat intelligence into a structured and actionable analysis for a fictional healthcare organization: **MedDefense**.

The main deliverable is a healthcare threat landscape summary based on Marcus Webb's intelligence dossier.

## Context

Marcus Webb collected several threat intelligence sources related to cyber threats against hospitals and healthcare organizations. The dossier includes advisory extracts, analyst notes, breach statistics, ransomware case studies, industry analysis, and Marcus's own unfinished notes.

The objective is to synthesize these raw sources into a structured report answering three core questions:

1. Who attacks healthcare organizations?
2. Why is healthcare a preferred target sector?
3. What does the data reveal about current attack trends?

## Target Organization

**MedDefense** is described as a regional hospital with:

* Around 2,000 staff
* Approximately 350 beds
* Regulated patient data
* No research programs
* Limited security budget
* Flat network architecture
* No SIEM
* No formal incident response plan
* Non-isolated backups
* Known public-facing vulnerabilities

## Deliverable

The required output file is:

```text
0-threat_landscape_summary.md
```

Location in the repository:

```text
holbertonschool-cyber_security/
└── blue_team/
    └── 1x01_know_your_enemy/
        ├── README.md
        └── 0-threat_landscape_summary.md
```

## Report Structure

The final report is organized into four main sections:

### 1. Threat Actor Overview

This section identifies and explains the main categories of actors targeting healthcare organizations:

* Organized crime / ransomware-as-a-service groups
* Nation-state / advanced persistent threat actors
* Insider threats
* Hacktivists
* Unskilled / opportunistic attackers

### 2. Healthcare Targeting Logic

This section explains why healthcare is attractive to attackers, including clinical urgency, valuable patient data, exposed systems, regulatory pressure, and broad clinical access needs.

### 3. Trend Analysis

This section identifies changes in healthcare cyber threats, including the rise of double extortion, exploitation of public-facing systems, phishing, valid credentials, and faster ransomware deployment timelines.

### 4. MedDefense Relevance

This section assesses how each actor category applies to MedDefense's specific profile as a regional hospital.

## Key Findings

The dossier shows that MedDefense's most likely adversaries are financially motivated ransomware groups and opportunistic attackers. Insider threats are also highly relevant due to shared credentials, weak offboarding, low training completion, and broad access to patient data.

Nation-state actors are less likely to target MedDefense directly because the hospital has no research programs. However, they remain relevant if MedDefense becomes connected to clinical trials, university research, pharmaceutical partners, or broader healthcare supply chains.

## Defensive Implications

The analysis highlights several priority defensive actions for MedDefense:

* Improve ransomware readiness
* Patch public-facing systems quickly
* Segment the internal network
* Isolate and test backups
* Deploy monitoring and incident response capability
* Strengthen identity and access management
* Reduce insider and email-related risks

## How to Use

From the root of the repository, create the required directory if it does not already exist:

```bash
mkdir -p blue_team/1x01_know_your_enemy
```

Place the deliverable inside the directory:

```bash
blue_team/1x01_know_your_enemy/0-threat_landscape_summary.md
```

Optional check:

```bash
ls -la blue_team/1x01_know_your_enemy
```

Expected files:

```text
README.md
0-threat_landscape_summary.md
```

## Author

Project completed as part of the Holberton School Cyber Security curriculum.
::: 

