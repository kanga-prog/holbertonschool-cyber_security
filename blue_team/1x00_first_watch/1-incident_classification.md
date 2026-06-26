# Incident Classification Using the CIA Triad

## Purpose

This document classifies six security-relevant incidents from the MedDefense incident log using the CIA Triad as the analytical framework.

The CIA Triad is composed of:

* **Confidentiality**: Information is protected from unauthorized access.
* **Integrity**: Information or systems are protected from unauthorized or incorrect modification.
* **Availability**: Systems, services, or data remain accessible when needed.

Each incident is assessed by identifying the primary CIA pillar impacted, explaining the reason, and identifying any secondary CIA impact when supported by the incident description.

## Incident Classification Table

| Incident   | Summary                                                                                                                                                                                                              | Primary CIA Pillar Impacted | Primary Justification                                                                                                                                                    | Secondary CIA Pillar Impacted | Secondary Justification                                                                                                                                                                   |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Incident A | A ransomware payload encrypted `billing-srv-01` over the weekend, preventing the finance team from processing insurance claims for 4 days; the available backup was 3 weeks old because of a misconfigured cron job. | Availability                | The billing and claims processing service became unavailable for 4 days, directly disrupting finance operations.                                                         | Integrity                     | The ransomware altered data by encrypting it without authorization, and the outdated backup created a risk that restored billing data would not reflect the most recent business records. |
| Incident B | A broken access control issue in the patient portal allowed authenticated patients to view other patients' lab results by modifying a URL parameter.                                                                 | Confidentiality             | Patient lab results were accessible to users who were not authorized to view them.                                                                                       | None identified               | The incident description does not indicate that patient records were modified or that the portal became unavailable.                                                                      |
| Incident C | A pharmacy management system displayed incorrect dosages for a medication across all three sites for approximately 6 hours after a database update script overwrote dosage values.                                   | Integrity                   | Medication dosage values were incorrectly modified, causing the system to display inaccurate clinical information.                                                       | Availability                  | Although the system remained online, the affected medication data was not reliably usable for safe pharmacy operations during the 6-hour period.                                          |
| Incident D | MedDefense Central's public-facing website was defaced and its homepage was replaced with a political message; it was restored from backup within 2 hours and did not contain patient data.                          | Integrity                   | The website content was modified without authorization.                                                                                                                  | Availability                  | The legitimate public website content was unavailable to users while the defaced homepage was displayed.                                                                                  |
| Incident E | The EHR system experienced a 9-hour outage during a planned database migration because the migration took longer than expected and the rollback procedure had not been tested.                                       | Availability                | Physicians could not use the EHR system for 9 hours and had to resort to paper records.                                                                                  | None identified               | The incident description does not confirm that EHR data was accessed by unauthorized users or incorrectly modified.                                                                       |
| Incident F | An IT intern's personal laptop was connected to the corporate WiFi for 3 weeks, was running a torrent client, and had access to the same internal network segment as the HR file share.                              | Confidentiality             | An unmanaged personal device on the internal network created an unauthorized exposure path to sensitive internal resources, including the HR file share network segment. | Availability                  | A torrent client on the internal network could consume bandwidth or introduce malware, creating a potential service disruption risk, although no actual outage is stated.                 |

## Summary

The six incidents show that MedDefense has experienced impacts across all three CIA pillars:

* **Availability** was significantly affected by the ransomware incident and the EHR outage.
* **Confidentiality** was affected by the patient portal access control failure and the unmanaged personal laptop on the internal network.
* **Integrity** was affected by the pharmacy dosage error and the website defacement.

Several incidents also had secondary impacts. This demonstrates that real security events often affect more than one CIA pillar and must be analyzed in terms of both technical failure and business impact.

