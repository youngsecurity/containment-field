---
layout: handbook-page-toc
title: "Change Management Controls"
---

## On this page
{:.no_toc .hidden-md .hidden-lg}

- TOC
{:toc .hidden-md .hidden-lg}

## Purpose
GitLab governs changes in a sustainable and ongoing manner that involves active participation from both technology and business stakeholders to ensure that only authorized changes occur.

## Scope
This control applies to all changes on all systems within our production environment that support the business of GitLab.com.

## Ownership
The owner of this control is the Infrastructure Team. <br>
The Process owner(s) are Infrastructure, IT Ops and Security.

## Controls

| Control Number | Control Title | Control Statement | Goal | TOD | TOE | 
|:---------|:-------------|:------|:-----|:-----|:-----|
| CHG-01 | Change Management Program | GitLab Inc. has implemented mechanisms to facilitate the implementation of change management security controls. | Does the organization facilitate the implementation of change management controls? | 1. Identify policies and procedures responsible for the implementation of change management security controls. <br> <br> 2. Examine policies and procedures for: purpose; scope; roles and responsibilities; management commitment; coordination among organizational entities; compliance; and implementation requirements. | 1. Examine change control policies, procedures and user-access security controls to ensure coverage and appropriate configuration of applicable change management processes. <br> <br> 2. Inspect a sample of controlled documents to evidence they are reviewed and approved in accordance to TOD. <br> <br> 3. Pull a population of change control records. <br> <br> 4. Inspect a sample of controlled documents to evidence that change management mechanisms exist to identify and document in accordance to TOD. | 
| CHG-02 | Configuration Change Control | GitLab Inc. has implemented mechanisms to govern the technical configuration change control processes by testing and documenting proposed changes in a non-production environment before changes are implemented in a production environment. | Does the organization govern the technical configuration change control processes? | 1. Inquire of appropriate personnel to determine the process for making changes to production. <br> <br> 2. Inspect the (Change Management policy, sample change documentation, etc.) to determine the process for making changes to production and how the change is evaluated for potential security and business impacts. | 1. Obtain and inspect a system generated listing of all changes (commits) to the system during the period under review. <br> <br> 2. Select an annualized sample of changes that occurred during the period to determine if they were tested and approved in line with the change management policy by all relevant business and IT stakeholders. <br> <br> 3. Obtain and inspect documentation (i.e merge requests/issues) that each sampled change was tested in line with the Change Management policy by all relevant business and IT stakeholders. <br> <br> 4. Obtain and inspect documentation (i.e merge requests/issues) that each sampled change was approved in line with the Change Management policy by all relevant business and IT stakeholders. <br> <br> 5. Obtain and inspect documentation that each sampled change that was migrated to production was the same change that was approved for migration. | 
| CHG-04 | Access Restriction For Change | GitLab Inc. has implemented mechanisms to enforce configuration restrictions in an effort to restrict the ability of users to conduct unauthorized changes. | Does the organization enforce configuration restrictions in an effort to restrict the ability of users to conduct unauthorized changes? | 1. Inquire of appropriate personnel to determine the process for migrating changes to production and what privileges/roles allow a user to migrate to production. <br> <br> 2. Inspect (user/role/privilege listing, user guide, other evidence) to determine which privileges/roles grant the user the ability to migrate and make changes to production. | 1. Obtain and inspect a listing of all accounts (user/system/service) for the system and their associated roles/privileges. Filter the listing for those roles/privileges with the ability to migrate and to make changes to production. <br> <br> 2. Obtain and inspect a listing of all current team members and their associated job title/roles. <br> <br> 3. Obtain and inspect a listing of all new hired team members during the period under audit. <br> <br> 4. Obtain and inspect a listing of all terminated team members. <br> <br> 5. For 100% of the accounts with the ability to migrate and make changes to production, determine the owner and their role/job title/account purpose. <br> <br> 6. For 100% of the accounts with the ability to migrate and make changes to production, determine if the account is owned by a terminated user. <br> <br> 7. For 100% of the accounts with the ability to migrate and make changes to production, determine if the account is owned by a user provisioned the access during the period under audit. If so, obtain evidence that the user was approved for the access prior to granting the access. <br> <br> 8. For 100% of the accounts with the ability to migrate and make changes to production, determine whether the account is owned by a non-developer. <br> <br> 9. For 100% of the accounts with the ability to migrate and make changes to production, determine whether the account is owned by an appropriate IT personnel. | 
| CHG-06 | Security Functionality Verification | GitLab Inc. has implemented mechanisms to verify the functionality of security controls when anomalies are discovered. | Does the organization verify the functionality of security controls when anomalies are discovered? | 1. Identify policies and procedures that verify the functionality of security controls when anomalies are discovered. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level workflows that support the discovery of anomalies. | 1. Identify detection and monitoring procedures or standards used to assist with the identification of anomalies. <br> <br> 2. Examine change detection mechanisms including but not limited to: system startup, restart, shutdown, and abort. <br> <br> 3. Examine notification mechanisms including electronic alerts to system administrators, messages to local computer consoles, and/or hardware indications such as lights. | 
|CHG-07 | Project Audit Events Review | Audit events are reviewed quarterly to ensure no inappropriate changes to key change management Segregation Of Duties (SOD) settings. | Have sensitive change management settings been changed during the quarter? | 1. Inspect MR approval settings and protected branch settings for each in-scope GitLab project. 2. If MR approval settings and protected branch settings are appropriately configured per the change management policy, obtain the audit events for the period, to observe if either settings have been modified during the period. | 1. For each audit event where settings were modified, obtain the related change management issue to ensure this change was authorized and appropriate.|



* *Test of Design* - (TOD) – verifies that a control is designed appropriately and that it will prevent or detect a particular risk.
* *Test of Operating Effectiveness* - (TOE) - used for verifying that the control is in place and it operates as it was designed.

### Policy Reference
* [Security Change Management](/handbook/security/change-management-policy.html)
* [Infrastructure Change Management](/handbook/engineering/infrastructure/change-management/)
* [Business Technology Change Management Workflow](/handbook/business-technology/change-management/)
