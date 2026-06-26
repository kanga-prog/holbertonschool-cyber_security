# Root Cause Analysis: billing-srv-01

## Purpose

This document analyzes the recurring performance degradation observed on `billing-srv-01` and explains why the issue should not be treated as a hardware capacity problem. The analysis uses the diagnostic evidence provided from the server, including the process list and network connections, to identify the underlying security issue, classify the CIA impact, and connect the current activity to the previous ransomware incident that affected the same asset.

## Executive Summary

The recurring CPU saturation on `billing-srv-01` is not primarily a hardware capacity issue. The diagnostic output shows a suspicious process named `kworker` consuming 94.2% CPU under the `www-data` user and connecting to `stratum+tcp://pool.monero.org:4443`. This strongly indicates unauthorized cryptocurrency mining activity, likely Monero mining, running on the billing server.

The visible symptom is reduced system performance, which affects availability. However, the more important security issue is that the server has already been compromised. Before availability is affected, the incident demonstrates violations of system integrity and potentially confidentiality. Upgrading hardware would not remove the unauthorized process, close the original compromise path, or prevent the attacker from continuing to use the server.

## Evidence Reviewed

The diagnostic excerpt shows the following relevant indicators:

```text
PID    USER      PR  NI  %CPU  %MEM    COMMAND
8834   www-data  20   0  94.2   3.1    ./kworker -o stratum+tcp://pool.monero.org:4443
```

```text
Proto  Local Address      Foreign Address        State
tcp    10.10.2.15:45892   185.243.115.89:4443    ESTABLISHED
tcp    10.10.2.15:45901   91.121.87.10:8080      ESTABLISHED
tcp    10.10.2.15:80      10.10.1.0/24:*         LISTEN
```

## 1. Process Identification

The process named `kworker` is suspicious for several reasons. On Linux systems, legitimate kernel worker threads normally appear as kernel-managed processes and are not launched from the current directory as `./kworker`. In this case, the process is running as the `www-data` user, which is commonly associated with web server processes, not kernel-level worker threads.

The command line includes a connection to `stratum+tcp://pool.monero.org:4443`. Stratum is a protocol commonly used by cryptocurrency miners to communicate with mining pools. The reference to `pool.monero.org` indicates that the process is likely mining Monero, a cryptocurrency often abused in cryptojacking incidents because it can be mined on general-purpose CPUs.

The purpose of this process is therefore not to support billing operations. Its likely purpose is to use MedDefense computing resources to generate cryptocurrency for an unauthorized party. The high CPU usage is a symptom of that activity.

## 2. Real Compromise Classification

The sysadmin identified the visible symptom as recurring CPU saturation. That symptom affects availability because the billing server becomes slower and less reliable for business users. However, availability is not the first or most important security issue.

The real compromise affects the following CIA pillars before availability is impacted:

| CIA Pillar | Classification | Justification |
|---|---|---|
| Integrity | Primary security violation | An unauthorized executable is running on `billing-srv-01`, which means the server's expected software state has been modified. The process is not part of the billing workload and should not exist on the system. |
| Confidentiality | Primary security violation | The attacker or unauthorized process has gained enough access to execute code as `www-data` and establish outbound connections. Even if no data theft is proven from the excerpt alone, the compromise creates unauthorized access to a billing server that likely handles sensitive claims and patient-related financial data. |
| Availability | Visible operational symptom | The crypto-mining process consumes 94.2% CPU, degrading the billing server's performance and reducing the availability of billing operations. |

## 3. Why the Hardware Upgrade Recommendation Fails

A hardware upgrade or migration to a more powerful virtual machine would not fix the security problem. It would only provide more CPU resources for the unauthorized crypto-mining process to consume.

The sysadmin's recommendation fails because it treats the symptom rather than the cause. The issue is not that the billing workload is too large for the server. The issue is that an unauthorized process is running on the server and communicating with external infrastructure. Unless MedDefense identifies the initial access path, removes the malicious process, validates the integrity of the host, rotates potentially exposed credentials, and hardens the server, the attacker may continue to use the system or reinfect it after cleanup.

A correct response should include incident containment, forensic review, eradication, recovery from trusted sources, and remediation of the vulnerability or misconfiguration that allowed code execution in the first place.

## 4. Connection to the January Ransomware Incident

The January ransomware incident and the current crypto-mining activity both affected `billing-srv-01`. This suggests that the server has a weak security posture and may have an unresolved root cause that was not addressed during the rebuild.

The repeated compromise of the same server indicates that the January recovery may have restored service without fully identifying how the attacker gained access. It may also indicate persistent exposure, poor hardening, vulnerable web services, weak credentials, insufficient monitoring, or inadequate network segmentation.

The key question is not only why the server is slow. The key question is:

**How did two separate unauthorized payloads execute on the same billing server, and what control failure allowed both incidents to occur?**

Additional questions should include:

- Was the original ransomware entry point identified and remediated?
- Was `billing-srv-01` rebuilt from a trusted image or restored from a potentially compromised backup?
- Are web applications or services on the server vulnerable to remote code execution?
- Are credentials used by the `www-data` service account or application exposed or reused?
- Are outbound connections from billing servers restricted or monitored?
- Are endpoint detection, logging, and alerting properly deployed on this server?
- Is the billing server segmented from other internal systems?

## 5. Recommended Next Steps

MedDefense should treat this as an active compromise rather than a performance ticket.

Recommended actions are:

1. Isolate `billing-srv-01` from the network to stop active unauthorized communication.
2. Preserve volatile and disk evidence before rebuilding or deleting files.
3. Identify the malicious executable, its location, persistence mechanism, and parent process.
4. Review web server logs, authentication logs, cron jobs, startup scripts, and recent file changes.
5. Determine whether billing data, credentials, or application secrets were accessed.
6. Block outbound mining pool traffic and review firewall egress rules.
7. Rebuild the server from a trusted image if compromise is confirmed.
8. Patch the operating system and application stack.
9. Disable unnecessary services and enforce least privilege for application accounts.
10. Deploy monitoring and alerting for abnormal CPU usage, suspicious outbound connections, and unauthorized processes.
11. Investigate whether the January ransomware and current crypto-miner share the same initial access vector.

## Conclusion

The recurring degradation on `billing-srv-01` is a symptom of an active security compromise, not evidence that the server is undersized. The process `./kworker` connecting to a Monero mining pool indicates unauthorized cryptocurrency mining. The first security failures are integrity and confidentiality violations, followed by an availability impact caused by resource exhaustion.

Upgrading the server would not solve the issue because it does not remove the attacker, close the compromise path, or restore trust in the system. The correct response is to investigate `billing-srv-01` as a compromised asset and determine why the same server has now been affected by both ransomware and cryptomining activity.

