---
layout: handbook-page-toc
title: "Continuous Monitoring Controls"
---

## On this page
{:.no_toc .hidden-md .hidden-lg}

- TOC
{:toc .hidden-md .hidden-lg}

## Purpose
GitLab maintains ongoing situational awareness of security-related events through the centralized collection, analysis and review of security-related event logs from systems, applications and services. Without comprehensive visibility into infrastructure, operating system, database, application and other logs, GitLab will have “blind spots” in its situational awareness that could lead to system compromise, data exfiltration, or unavailability of needed computing resources.

## Scope
This control applies to all systems within our production environment. The production environment includes all endpoints and cloud assets used in hosting GitLab.com and its subdomains. This may include third-party systems that support the business of GitLab.com.

## Ownership
* This control is owned by Infrastructure.  
* The process is owned by Security Compliance, Infrastructure and Security Operations. 

## Controls

| Control Number | Control Title | Control Statement | Goal | TOD | TOE | 
|:---------|:-------------|:------|:-----|:-----|:-----|
| MON-01 | Continuous Monitoring | GitLab Inc. has implemented mechanisms for enterprise-wide monitoring controls such as Intrusion Detection / Prevention Systems (IDS / IPS) technologies on critical systems, key network segments and network choke points.  GitLab utilizes Host-based Intrusion Detection / Prevention Systems (HIDS/HIPS) to continuously monitor inbound and outbound communications traffic for unusual or unauthorized activities and actively responds to alerts from physical, cybersecurity, privacy and supply chain activities, blocking unwanted activities to achieve and maintain situational awareness.  GitLab utilizes Wireless Intrusion Detection / Protection Systems (WIDS / WIPS) to identify rogue wireless devices and detect attack attempts via wireless networks.  GitLab sends logs to a Security Incident Event Manager (SIEM) or similar automated tool to review event logs on an ongoing basis and escalate incidents in accordance with established timelines and procedures. | Does the organization facilitate the implementation of enterprise-wide monitoring controls? | 1. Examine the policies, procedures and related documents associated with enterprise-wide monitoring technologies such as Intrusion Detection / Prevention Systems (IDS/IPS) on critical systems, key network segments and network choke points. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level planning and workflows that support the enterprise-wide monitoring technologies such as Intrusion Detection / Prevention Systems (IDS/IPS) on critical systems, key network segments and network choke points. | 1. Identify critical systems, key network segments and network choke points. <br> <br> 2. Examine policies, procedures, related documentation and automated configurations used to support IDS/IPS on identified critical systems. <br> <br> 3. Examine the IDS/IPS monitoring for evidence of: Monitoring for anomalies Audit logs / records configured, documented and reviewed according to policy Network monitoring for cybersecurity events Roles and responsibilities defined Detection and resolution requirements Baseline configurations are enabled according to policy. | 
| MON-02 | Centralized Collection of Security Event Logs | GitLab Inc. has implemented mechanisms to utilize a Security Incident Event Manager (SIEM) or similar automated tool, to support the centralized collection of security-related event logs to maintain situational awareness. | Does the organization utilize a Security Incident Event Manager (SIEM) or similar automated tool, to support the centralized collection of security-related event logs? | 1. Examine the policies, procedures and related documents associated with the documentation and configuration of a Security Incident Event Manager (SIEM) or similar automated tool used to centralize collection of security related event logs. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level planning and workflows that support the SIEM. | 1. Examine policies, procedures, related documentation and automated configurations used to facilitate the SIEM. <br> <br> 2. Review event logs for the entire examination period for evidence that the SIEM captured all event logs outlined in the automated configurations and related documentation.
| MON-03 | Content of Audit Records | GitLab Inc. has implemented mechanisms to configure systems to produce audit records that contain sufficient information to, at a minimum: ▪ Establish what type of event occurred; ▪ When (date and time) the event occurred;▪ Where the event occurred; ▪ The source of the event; ▪ The outcome (success or failure) of the event; and ▪ The identity of any user/subject associated with the event. | Does the organization configure systems to produce audit records that contain sufficient information to, at a minimum: ▪ Establish what type of event occurred; ▪ When (date and time) the event occurred; ▪ Where the event occurred; ▪ The source of the event; ▪ The outcome (success or failure) of the event; and ▪ The identity of any user/subject associated with the event? | 1. Examine the policies, procedures and related documents associated with the documentation and configuration of a Security Incident Event Manager (SIEM) or similar automated tool used to produce audit records. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level planning and workflows that support the SIEM. <br> <br> 3. Examine SIEM configuration for evidence that altering configurations for the SIEM are based on segregation of duties, job role responsibility etc. and any change to the configurations or records follows documented policies and procedures. <br> <br> 4. Examine the SIEM configuration to evidence information is collected. Including but not limited to: Type of event When (date and time) Where Source of event Outcome (success or failure) Identify user/subject associated with event. | 1. Pull a population of all audit logs for the examination period. <br> <br> 2. Examine manual or automated configurations for audit logs. <br> <br> 3. Examine sample set of audit logs for evidence that the SIEM captured all information as outlined in ToD through either manual or configured processes. | 
| MON-10 | Audit Record Retention | GitLab Inc. has implemented mechanisms to retain audit records for a time period consistent with records retention requirements to provide support for after-the-fact investigations of security incidents and to meet statutory, regulatory and contractual retention requirements. | Does the organization retain audit records for a time period consistent with records retention requirements to provide support for after-the-fact investigations of security incidents and to meet statutory, regulatory and contractual retention requirements? | 1. Identify statutory, regulatory and contractual retention and disposal requirements. <br> <br> 2. Examine the policies, procedures and related documents associated with audit record retention and disposal. | 1. Pull a population of all audit records <br> <br> 2. Examine manual processes or automated configurations for evidence that audit records are retained and/or disposed of according to statutory, regulatory and contractual retention and disposal requirements. <br> <br> 3. Examine a sample set of audit records for evidence that records were retained or destroyed according to statutory, regulatory and contractual retention and disposal requirements. | 

* *Test of Design* - (TOD) – verifies that a control is designed appropriately and that it will prevent or detect a particular risk.
* *Test of Operating Effectiveness* - (TOE) - used for verifying that the control is in place and it operates as it was designed.

### Policy Reference

* [GitLab Audit Logging Policy](/handbook/security/audit-logging-policy.html)
* [Monitoring of GitLab.com](/handbook/engineering/monitoring/)
* [GitLab.com Logging Runbook](https://gitlab.com/gitlab-com/runbooks/tree/master/logging/doc)
    *  [GitLab.com audit logging infrastructure](https://gitlab.com/gitlab-com/runbooks/tree/master/logging/doc#logging-infrastructure-overview)
    *  [GitLab.com - what are we logging](https://gitlab.com/gitlab-com/runbooks/tree/master/logging/doc#what-are-we-logging)
* [GitLab.com Main Monitoring Dashboards](/handbook/engineering/monitoring/#main-monitoring-dashboards)
* [SOX IT General Controls Scoping](https://docs.google.com/spreadsheets/d/143pUC61YVS1VC-GWsRZb5wdiUCeu-PEwAc751sOPsdE/edit?ts=5d323bbf#gid=214635064)
* [Record Retention Policy](/handbook/legal/record-retention-policy/)
* [Incident Management](/handbook/engineering/infrastructure/incident-management/)
* [Security Incident Response Guide](/handbook/security/security-operations/sirt/sec-incident-response.html)
* [DELKE](https://gitlab.com/gitlab-com/gl-security/secops/detection/delke)
* [Incident Management - Security Incidents](/handbook/engineering/infrastructure/incident-management/#security-incidents)
