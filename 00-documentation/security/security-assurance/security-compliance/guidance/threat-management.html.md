---
layout: handbook-page-toc
title: "Threat Management Controls"
---

## On this page
{:.no_toc .hidden-md .hidden-lg}

- TOC
{:toc .hidden-md .hidden-lg}

## Purpose
GitLab proactively identifies, assesses and remediates technology-related threats based on a thorough risk analysis to determine the potential risk posed to the security and privacy of the organization’s systems, data and business processes. 

## Scope
This control applies to all systems within our production environment. The production environment includes all endpoints and cloud assets used in hosting GitLab.com and its subdomains. This may include third-party systems that support the business of GitLab.com.

## Ownership
This control is owned by SIRT

## Controls

| Control Number | Control Title | Control Statement | Goal | TOD | TOE | 
|:---------|:-------------|:------|:-----|:-----|:-----|
| THR-01 | Threat Intelligence Program | GitLab Inc. has implemented mechanisms for a threat intelligence program that includes a cross-organization information-sharing capability that can influence the development of the system and security architectures, selection of security solutions, monitoring, threat hunting, response and recovery activities. | Does the organization implement a threat awareness program that includes a cross-organization information-sharing capability? | 1. Examine the policies, procedures and related documents associated with the Threat Intelligence Program (TIP) or similar that facilitates cross-organizational information sharing used to influence the development of system and security activities. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level planning and workflows that support system and security development and architecture including but not limited to: System and security architecture; Security solutions; Monitoring; Threat hunting; Response and recovery. | 1. Examine cross-organization information sharing the influenced the development and security of the system during the examination period. <br> <br> 2. Validate information sharing was considered and influenced system and security development as outlined in the ToD. | 
| THR-02 | Indicators of Exposure (IOE) | GitLab Inc. has implemented mechanisms to develop Indicators of Exposure (IOE) to understand the potential attack vectors that attackers could use to attack the organization.| Does the organization develop Indicators of Exposure (IOE) to understand the potential attack vectors that attackers could use to attack the organization? | 1. Examine policies, procedures and related documentation used to develop and facilitate Indicators of Exposure (IOE) for potential attack vectors used to attack the organization including various types of fraud. | 1. Examine the various procedures used to identify and facilitate IOE including but not limited to: risk assessment security control monitoring Configuration management Monitoring Change management Vulnerability identification, review, remediation. | 
| THR-04 | Insider Threat Program | GitLab Inc. has implemented mechanisms for an insider threat program that includes a cross-discipline insider threat incident handling team. | Does the organization implement an insider threat program that includes a cross-discipline insider threat incident handling team? | 1. Examine policies, procedures and related documentation used to develop and facilitate a cross-discipline insider threat program and insider threat incident handling team. | 1. Examine the various procedures used to identify and handle insider threats including but not limited to: risk assessment security control monitoring Configuration management Monitoring Change management Vulnerability identification, review, remediation. <br> <br> 2. Obtain a list of insider threat handling team members during the examination period. |

* *Test of Design* - (TOD) – verifies that a control is designed appropriately and that it will prevent or detect a particular risk.
* *Test of Operating Effectiveness* - (TOE) - used for verifying that the control is in place and it operates as it was designed.

### Policy Reference
