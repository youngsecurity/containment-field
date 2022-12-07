---
layout: handbook-page-toc
title: "Compliance Controls"
---

## On this page
{:.no_toc .hidden-md .hidden-lg}

- TOC
{:toc .hidden-md .hidden-lg}

## Purpose

GitLab oversees the execution of cybersecurity and privacy controls to create appropriate evidence of due care and due diligence, demonstrating compliance by ensuring controls are in place to be aware of and comply with all applicable statutory, regulatory and contractual compliance obligations, as well as internal company standards.

## Scope
This applies to all GitLab policies and standards having a direct impact to how GitLab carries out it's IT/Security practices.

The specific policies and standards described in the Policy Reference section below are subject to this control.

## Ownership
This control is owned by Security Compliance.

## Controls

| Control Number | Control Title | Control Statement | Goal | TOD | TOE |
|:---------|:-------------|:------|:-----|:-----|:-----|
| CPL-01 | Statutory, Regulatory & Contractual Compliance | GitLab Inc. has implemented mechanisms to facilitate the identification and implementation of relevant legislative statutory, regulatory and contractual security controls. | Does the organization facilitate the implementation of relevant legislative statutory, regulatory and contractual controls? | 1. Identify policies and procedures responsible for identification and implementation of relevant legislative statutory, regulatory and contractual security controls. <br> <br> 2. Examine policies and procedures for: purpose; scope; roles and responsibilities; management commitment; coordination among organizational entities; compliance; and implementation requirements. | 1. Identify applicable federal laws, Executive Orders, directives, regulations, policies, standards, contractual requirements, and guidance. <br> <br> 2. Examine security controls to ensure coverage of applicable federal laws, Executive Orders, directives, regulations, policies, standards, contractual requirements, and guidance. |
| CPL-01.1 | Non-Compliance Oversight | GitLab Inc. has implemented mechanisms to document and review instances of non-compliance with statutory, regulatory and/or contractual obligations to develop appropriate risk mitigation actions. | Does the organization document and review instances of non-compliance with statutory, regulatory and/or contractual obligations to develop appropriate risk mitigation actions? | 1. Identify policies and procedures responsible for identification and implementation of instance with non-compliance with relevant legislative statutory, regulatory and contractual security controls. <br> <br> 2. Examine policies and procedures for: purpose; scope; roles and responsibilities; management commitment; coordination among organizational entities; compliance; and implementation requirements. | 1. Identify applicable federal laws, Executive Orders, directives, regulations, policies, standards, contractual requirements, and guidance. <br> <br> 2. Examine security controls to ensure coverage of applicable federal laws, Executive Orders, directives, regulations, policies, standards, contractual requirements, and guidance. |
| CPL-02 | Security Controls Oversight | GitLab Inc. has implemented mechanisms responsible for security controls oversight. | Does the organization provide a security controls oversight function? | 1. Inspect security collateral for evidence of assignment of security controls oversight. <br> <br> 2. Interview security leadership to ensure the responsible party has the correct level of authority and autonomy to achieve program objectives. | 1. Examine change control records, or other relevant records, for a sample of security control reviews, updates and management approvals. |
| CPL-03 | Security Assessments | GitLab Inc. has established mechanisms to ensure team members regularly review controlled documents within their area of responsibility for accuracy and adherence to appropriate security policies, standards and other applicable requirements. | Does the organization ensure managers regularly review the processes and documented procedures within their area of responsibility to adhere to appropriate security policies, standards and other applicable requirements? | 1. Examine organizational policies and procedures for the requirements and frequency of controlled document review. | 1. Pull a population of all controlled documents. <br> <br> 2. Inspect a sample of controlled document to for evidence they are reviewed and approved in accordance to TOD. |
| CPL-04 | Audit Activities | GitLab Inc. has implemented mechanisms to plan and execute compliance audits that minimize the impact of audit activities on business operations. | Does the organization plan audits that minimize the impact of audit activities on business operations? | 1. Examine security documentation for a security assessment plan for the information systems. <br> <br> 2. Examine the security assessment plan for a description of the scope of the assessment including: security controls and sub-controls under assessment; assessment procedures to be used to determine security control effectiveness; and assessment environment, assessment team, and assessment roles and responsibilities. | 1. Obtain a population of audit activities performed during the period. <br> <br> 2. Examine the audit activities for evidence they are executed in accordance to TOD. |

* *Test of Design* - (TOD) – verifies that a control is designed appropriately and that it will prevent or detect a particular risk.
* *Test of Operating Effectiveness* - (TOE) - used for verifying that the control is in place and it operates as it was designed.

### Policy Reference
- [Engineering Department](/handbook/engineering/) Policies and Standards
  - [Development Department](/handbook/engineering/development/)
  - [Infrastructure Department](/handbook/engineering/infrastructure/)
    - [Backup Policies](/handbook/engineering/infrastructure/production/#backups) and [Backup Recovery Testing](https://gitlab.com/gitlab-com/gl-infra/gitlab-restore/postgres-gprd/blob/master/README.md)
    - [Change Management](/handbook/engineering/infrastructure/change-management/)
    - [Disaster Recovery](https://gitlab.com/gitlab-com/gl-infra/readiness/-/blob/master/library/disaster-recovery/index.md) and [Disaster Recovery - Databases](/handbook/engineering/infrastructure/database/disaster_recovery.html)
    - [Incident Management](/handbook/engineering/infrastructure/incident-management/)
    - [Production Architecture Page](/handbook/engineering/infrastructure/production/architecture/)
  - [Quality Department](/handbook/engineering/quality/)
  - [Security Department](/handbook/security/)
    - [Data Classification Policy](/handbook/security/data-classification-standard.html)
    - [Data Protection Impact Assessment (DPIA) Policy](/handbook/legal/privacy/dpia-policy)
    - [Incident Response Guide](/handbook/security/security-operations/sirt/sec-incident-response.html)
    - [GitLab Password Policy Guidelines](/handbook/security/#gitlab-password-policy-guidelines)
    - [Risk Management](/handbook/security/security-assurance/security-risk/storm-program/index.html)
    - [Security Incident Communications Plan](/handbook/security/security-operations/sirt/security-incident-communication-plan.html)
    - [Security Operations On-Call Guide](/handbook/security/secops-oncall.html#major-incident-response-workflow) for Major Incidents
    - [Third Party Risk Management Procedure](/handbook/security/security-assurance/security-risk/third-party-risk-management.html)
    - [Vulnerability Management](/handbook/security/threat-management/vulnerability-management/#vulnerability-management-overview)
  - [Support Team](/handbook/support/)
  - [GitLab Security Practices](/handbook/security/)
    - [Business Continuity Plan](/handbook/business-ops/gitlab-business-continuity-plan/)
    - [Data Team](/handbook/business-technology/data-team/) Policies and Standards
    - [Team Member Enablement Policies and Standards](/handbook/business-ops/team-member-enablement/onboarding-access-requests/)
      - [Inventory Management](/handbook/business-ops/team-member-enablement/onboarding-access-requests/#fleet-intelligence--remote-lockwipe) <!-- Fleetsmith will be deprecated for DriveStrike. When this happens, this link needs to be updated. -->
    - [IT Help Team](/handbook/business-ops/team-member-enablement/self-help-troubleshooting/) Policies and Standards
- General Policies and Standards
  - [Offboarding Procedures](/handbook/people-group/offboarding/offboarding_guidelines/)
