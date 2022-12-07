---
layout: handbook-page-toc
title: "Business Continuity & Disaster Recovery Controls"
---

## On this page
{:.no_toc .hidden-md .hidden-lg}

- TOC
{:toc .hidden-md .hidden-lg}

## Purpose
GitLab maintains the capability to sustain business-critical functions while successfully responding to and recovering from incidents through a well-documented and exercised process to help recover from adverse situations with the minimal impact to operations, as well as provide the ability for e-discovery.

## Scope
The business continuity and disaster recovery plan is comprehensive by nature and will impact all GitLab stakeholders. The scope of GitLab Business Continuity & Disaster Recovery Plan will cover:
* BC/DR plan for gitlab.com
* BC/DR plan for customers.gitlab.com (Azure)
* BC/DR plan for license.gitlab.com (AWS)
* Processes and procedures that support business operations and above environments

## Ownership
* Business Operations owns this control.
* Infrastructure will provide implementation support for all of the above mentioned sites and owns the backup configuration 100%. They are responsible to run both app snapshots and database backups.

## Controls

| Control Number | Control Title | Control Statement | Goal | TOD | TOE | 
|:---------|:-------------|:------|:-----|:-----|:-----|
| BCD-01 | Business Continuity Management System (BCMS) | GitLab Inc. has implemented mechanisms to facilitate contingency planning security controls to help ensure resilient assets and services. | Does the organization facilitate the implementation of contingency planning controls? | 1. Identify formal policies, procedures or other relevant documentation that outline GitLab’s mechanisms to facilitate contingency planning. Including but not limited to: communication, roles and responsibilities, business continuity, recovery, insurance, incident response and incident reporting. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level workflows that support the facilitation of the organizational level contingency plan. <br> <br> 3. Examine policies and procedures for: purpose; scope; roles and responsibilities; management commitment; coordination among organizational entities; compliance; and implementation requirements. | 1. Examine organizational contingency planning policy and procedures or other relevant documents to support the facilitation of contingency planning protocols. <br> <br> 2. Examine security controls as they relate to contingency planning for evidence that security controls facilitate implementation and adherence of contingency plans to help ensure resilient assets and services. |
| BCD-02 | Identify Critical Assets | GitLab Inc. has established mechanisms to identify, document and resume the critical systems, applications and services that support essential missions and business processes within Recovery Time Objectives (RTOs) with little or no loss of operational continuity of the defined time period of the contingency plan’s activation. | Does the organization identify and document the critical systems, applications and services that support essential missions and business functions? | 1. Inspect formal policies, procedures or other relevant documentation that outline Recovery Time Objectives (RTO), restoration priorities and metrics to resume all missions and business functions, essential mission and business functions and continue essential mission and business functions. | 1. Examine associated policies and procedures as outlined in the TOD for evidence the critical systems, applications and services list that support essential missions and business functions is included as part of contingency plan documentation and activation procedures. | 
| BCD-04 | Contingency Plan Testing & Exercises | GitLab Inc. has implemented mechanisms to conduct tests and/or exercises to determine the contingency plan’s effectiveness and the organization’s readiness to execute the plan. | Does the organization conduct tests and/or exercises to determine the contingency plan's effectiveness and the organization’s readiness to execute the plan? | 1. Examine contingency planning policy and procedures addressing contingency plan testing and/or exercises results for evidence that the measures identified determine the contingency plan’s effectiveness and GitLab’s readiness to execute the plan. | 1. Pull a population of all contingency plan tests and/or exercises during the examination period. <br> <br> 2. Examine results for a sample selection of contingency plan tests/exercises conducted to determine if the contingency plans effectiveness and organization’s readiness to execute the plan were taken into account. | 
| BCD-05 | Contingency Plan Root Cause Analysis (RCA) & Lessons Learned | GitLab Inc. has implemented mechanisms to conduct Root Cause Analysis (RCA) and “lessons learned” activity every the contingency plan is activated. | Does the organization conduct a Root Cause Analysis (RCA) and "lessons learned" activity every time the contingency plan is activated? | 1. Examine contingency planning policies, procedures or other relevant documentation that outline contingency planning Root Cause Analysis (RCA) and lessons learned requirements each time the contingency plan is activated. | 1. Pull a population of all contingency plan tests and/or exercises during the examination period. <br> <br> 2. Examine results for a sample selection of contingency plan tests/exercises conducted to determine if RCA and lessons learned were considered as part of each activated contingency plan. | 
| BCD-06 | Contingency Planning & Updates | GitLab Inc. has established mechanisms to keep contingency plans current with business requirements and technology changes. | Does the organization keep contingency plans current with business needs and technology changes? | 1. Examine contingency planning policies, procedures and other relevant documents for the measures to be employed to ensure contingency plans are current with business requirements and technology changes as well as frequency and documentation of review. | 1. Inspect the contingency planning policies, procedure and other relevant documentation for evidence they are current with business requirements and technology changes through a review and approval process. | 
| BCD-07 | Alternative Security Measures | GitLab Inc. has implemented alternative or compensating controls to satisfy security requirements when the primary means of implementing the security requirements is unavailable or compromised. | Does the organization implement alternative or compensating controls to satisfy security functions when the primary means of implementing the security function is unavailable or compromised? | 1. Examine contingency planning policies, procedures or other relevant documentation that outline measures to support risk mitigation alternatives or compensating controls to satisfy security requirements when the primary means of implementing security requirements is unavailable or compromised. | 1. Examine alternative or compensating controls outlined in the contingency planning documentation for evidence that the measures identified support security requirements when the primary means of security requirements is unavailable or compromised. <br> <br> 2. Examine documentation or configurations describing continuous monitoring efforts for evidence that these mechanisms are configured to satisfy security requirements when primary means of implementing security requirements are unavailable or compromised. | 
| BCD-11 | Data Backups | GitLab Inc. has implemented mechanisms to create and routinely test recurring backups of data, software and system images verifying the reliability of the backup process to ensure the integrity and availability of the data. | Does the organization create recurring backups of data, software and system images to ensure the availability of the data? | 1. Inquire of appropriate personnel to determine the process for completing backups. <br> <br> 2. Inspect the (Backup policy, system evidence etc.) to determine the process for completing backups. | 1. According to the defined frequency of backups, select a sample of (days/weeks/months) and obtain evidence for the selected sample to determine if the backups were completed successfully. <br> <br> 2. In case of any failures, obtain and inspect documentation that the failure(s) was researched and resolved timely and in line with the backup policy. | 
| BCD-12 | Information System Recovery & Reconstitution | GitLab Inc. has implemented mechanisms to ensure the recovery and restoration of systems to a known state after a disruption, compromise or failure. | Does the organization ensure the recovery and reconstitution of systems to a known state after a disruption, compromise or failure? | 1. Inquire of appropriate personnel to determine the process for completing backup restoration tests from completed backups. <br> <br> 2. Inspect (Backup policy, Restoration guidance etc.) to determine the process for completing backups restoration tests. | 1. Obtain and inspect the results for the backup restoration test. <br> <br> 2. Review the results of the backup restoration test and the supporting documentation to validate that backups are completed appropriately and are available for restoration. <br> <br> 3. In case of any noted issues identified in the backup restoration test, validate that they have been resolved appropriately. | 
| BCD-13 | Backup & Restoration Hardware Protection | GitLab Inc. has implemented mechanisms to protect backup and restoration of hardware and software. | Does the organization protect backup and restoration hardware and software? | 1. Examine security documentation for backup and restoration of hardware and software policies and procedures. | 1. Examine documentation for outlined automated or configured mechanisms settings to support the backup and restoration of hardware and software as outlined in the policies and procedures. <br> <br> 2. Pull a population of all hardware and software backups and restoration during the examination period. <br> - Confirm hardware and software backup and restorations conducted during the examination period align with the automated or configured mechanism settings. | 

* *Test of Design* - (TOD) – verifies that a control is designed appropriately and that it will prevent or detect a particular risk.
* *Test of Operating Effectiveness* - (TOE) - used for verifying that the control is in place and it operates as it was designed.

### Policy Reference
* [GitLab Business Continuity Plan in Handbook](/handbook/business-ops/gitlab-business-continuity-plan/)
* [Business Continuity Test handbook link](/handbook/business-ops/gitlab-business-continuity-plan/#business-continuity-testing)
* [GitLab Disaster Recovery](https://gitlab.com/gitlab-com/gl-infra/readiness/-/blob/master/library/disaster-recovery/index.md)
* [GitLab Reference Architectures](https://about.gitlab.com/solutions/reference-architectures/)
* [GitLab Infra Epic for Geo](https://gitlab.com/groups/gitlab-com/gl-infra/-/epics/1)
* [GitLab Handbook listing of DR for Databases](/handbook/engineering/infrastructure/database/disaster_recovery.html)
* [NIST Guidance on Business Continuity](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-34r1.pdf)
* [PCI DSS v3.2.1 - Business Continuity Plan](https://www.pcisecuritystandards.org/documents/PCI_DSS_v3-2-1.pdf?agreement=true&time=1551196697261#page=113)
* [Geo and Disaster Recovery](/handbook/engineering/development/enablement/geo/)
* [GitLab DR Design](https://gitlab.com/gitlab-com/gl-infra/readiness/-/blob/master/library/disaster-recovery/index.md#design)
* [GitLab DR for Databases](/handbook/engineering/infrastructure/database/disaster_recovery.html)
* [Project Plan for GitLab's Business Continuity Test - Q1 2020](https://gitlab.com/gitlab-com/gl-security/security-assurance/sec-compliance/compliance/-/issues/1721)
* [Business Continuity Test Plan - Apr 30, 2020](https://gitlab.com/gitlab-com/gl-security/security-assurance/sec-compliance/compliance/-/issues/1818)
* [Business Continuity Exercise Runbook Template](https://gitlab.com/gitlab-com/gl-security/security-assurance/sec-compliance/compliance/-/issues/new?issuable_template=Business_Continuity_Exercise_Runbook)
* [Business Continuity Plan for Malicious Software Attack(s)](https://gitlab.com/gitlab-com/business-ops/Business-Operations/-/issues/264)
* [Business Continuity Test - April 30th, 2020 - Retrospective](https://gitlab.com/gitlab-com/gl-security/security-assurance/sec-compliance/compliance/-/issues/1838)
* [Business Impact Analysis in the handbook](/handbook/business-ops/gitlab-business-continuity-plan#business-impact-analysis)
* [Data Protection Impact Assessment (DPIA) Policy](/handbook/legal/privacy/dpia-policy/index.html)
* [Data Protection Impact Assessments or DPIAs](/handbook/legal/privacy/#data-protection-impact-assessments-dpias)
* [Data Protection Office and the Privacy Office](https://about.gitlab.com/privacy/#data-protection)	
* [NIST BCP with reference to BIA](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-34r1.pdf)
* [Handbook listing for DR](https://gitlab.com/gitlab-com/gl-infra/readiness/-/blob/master/library/disaster-recovery/index.md)
* [Project Plan related to the BC test tabletop exercise](https://gitlab.com/gitlab-com/gl-security/security-assurance/sec-compliance/compliance/-/issues/1721)
* [Business Continuity Testing Procedure](https://gitlab.com/gitlab-com/gl-security/security-assurance/sec-compliance/compliance/-/issues/1818)
* [Retrospective of the exercise documented](https://gitlab.com/gitlab-com/gl-security/security-assurance/sec-compliance/compliance/-/issues/1838)


