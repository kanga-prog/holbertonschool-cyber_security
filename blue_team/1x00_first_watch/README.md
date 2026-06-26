# First Watch: Security Posture Assessment

## Project Overview

This project is a structured security posture assessment for MedDefense Health Systems, a regional healthcare organization operating three sites: MedDefense Central Hospital, Westside Clinic, and Corporate HQ.

The objective is to analyze incomplete and disorganized internal documentation in order to build an initial understanding of the organization's environment. This work focuses on identifying assets, services, data types, security-relevant organizational structure, and documentation gaps that must be addressed before deeper security assessment activities can be performed.

This project does not involve live scanning, exploitation, or direct interaction with production systems. All analysis is based on provided artifacts.

## Scenario

You are acting as a Junior Security Analyst at MedDefense Health Systems. The organization has never had a mature dedicated security function, and existing documentation is incomplete, outdated, or scattered across different sources.

The Deputy CISO has requested a professional security posture assessment for executive review. The first step is to extract a structured understanding of the environment from the onboarding documentation packet.

## Objectives

The main objectives of this project are to:

- Identify MedDefense's sites, departments, and security-relevant reporting structure.
- Build an initial inventory of IT infrastructure mentioned in the documentation.
- Identify critical data types and IT-dependent business services.
- Document missing, incomplete, ambiguous, or contradictory information.
- Establish a reliable foundation for future risk assessment, gap analysis, and remediation planning.

## Scope

The scope of this project includes:

- MedDefense Central Hospital
- Westside Clinic
- Corporate HQ
- Servers, network equipment, endpoints, medical IoT devices, cloud services, and third-party services mentioned in the provided documentation
- Organizational and reporting structures relevant to security
- Known documentation gaps and unresolved questions

The scope does not include:

- Vulnerability scanning
- Penetration testing
- Exploitation
- Live network discovery
- Direct verification of assets or controls

## Methodology

The assessment follows a documentation-based analysis approach:

1. Review the complete onboarding packet.
2. Extract factual information about the organization and its IT environment.
3. Organize assets by function, location, and available technical details.
4. Identify data types and critical services supported by the infrastructure.
5. Separate confirmed facts from assumptions.
6. Record missing, incomplete, or contradictory information as known unknowns.

## Deliverables

The main deliverable for Task 0 is:

```text
0-environment_summary.md
```

This file contains a structured environment summary organized into the following sections:

1. Organization Overview
2. IT Infrastructure Identified
3. Data and Services
4. Known Unknowns

## Repository Structure

```text
holbertonschool-cyber_security/
└── blue_team/
    └── 1x00_first_watch/
        ├── README.md
        └── 0-environment_summary.md
```

## Key Security Concepts Applied

This project introduces foundational security analysis concepts, including:

- Asset identification
- Business and technical context analysis
- CIA Triad-based thinking
- Security-relevant data classification
- Dependency mapping
- Documentation gap analysis
- Separation of facts, assumptions, and unknowns

## Professional Notes

All findings must be written in a professional tone suitable for a security assessment deliverable. Statements must be justified by evidence from the provided documentation. Information that cannot be confirmed must not be presented as fact and should instead be documented as a known unknown.

## Author

Junior Security Analyst  
MedDefense Health Systems

