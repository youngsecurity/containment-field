---
layout: handbook-page-toc
title: "Endpoint Security Controls"
---

## On this page
{:.no_toc .hidden-md .hidden-lg}

- TOC
{:toc .hidden-md .hidden-lg}

## Purpose
GitLab ensures that endpoint devices are appropriately protected against reasonable security threats to those devices and the data they store, transmit and process.  Applicable statutory, regulatory and contractual compliance requirements dictate the minimum safeguards that must be in place to protect the confidentiality, integrity, availability and safety considerations.

## Scope
This control applies to all systems within the production environment. The production environment includes all endpoints and cloud assets used in hosting GitLab.com and its subdomains.  [Endpoint devices](https://about.gitlab.com/handbook/business-technology/team-member-enablement/onboarding-access-requests/endpoint-management/) are inclusive of all GitLab-procured systems/devices and are categorized differently from [mobile devices](https://about.gitlab.com/handbook/security/security-assurance/security-compliance/guidance/mobile-device-management.html) which are team-member owned devices.

## Ownership
This control is owned by IT Ops.

## Controls

| Control Number | Control Title | Control Statement | Goal | TOD | TOE | 
|:---------|:-------------|:------|:-----|:-----|:-----|
| END-04 | Malicious Code Protection (Anti-Malware) | GitLab Inc. has implemented mechanisms to utilize anti-malware technologies to detect and eradicate malicious code. | Does the organization utilize antimalware technologies to detect and eradicate malicious code? | 1. Examine policies, procedures or associated documentation addressing malicious code and software protection, malicious code and software protection mechanisms, records of malicious code and software protection updates and information system configurations settings utilized to detect and eradicate malicious code and software including at the enterprise level. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level workflows that support the facilitation of anti-malware technology used to detect and eradicate malicious code and software including at the enterprise level. | 1. Examine automated anti-malware mechanisms utilized to detect, prevent and act upon the introduction of unauthorized or malicious code or software for evidence that the configured settings are operating as intended. <br> <br> 2. Based on ToD, this could include pulling populations and testing a sample set of: * Information system vulnerabilities * Physical assets * Vulnerability scans. | 
| END-06 | File Integrity Monitoring (FIM) | GitLab Inc. has implemented mechanisms to utilize File Integrity Monitor (FIM) technology to detect and report unauthorized changes to system files and configurations. | Does the organization utilize File Integrity Monitor (FIM) technology to detect and report unauthorized changes to system files and configurations? | 1. Examine policies, procedures or associated documentation addressing the use of File Integrity Monitor (FIM) technology to verify software, firmware and information integrity as well as prevent, detect and alert upon unauthorized changes to system files and configurations. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level workflows that support the facilitation of FIM technology used to verify software, firmware and information integrity as well as prevent, detect and alert upon unauthorized changes to system files and configuration. | 1. Examine documentation describing the current configuration settings of the FIM technology for evidence configurations support the documentation outlined in the ToD. <br> <br> 2. Pull a population of FIM automated mechanisms for evidence the mechanisms are configured as identified <br> <br> 3. Test a select sample set of automated mechanisms and their configuration settings identified for evidence that these mechanisms are operating as intended. | 
| END-07 | Host Intrusion Detection and Prevention Systems (HIDS / HIPS) |  GitLab Inc. has implemented mechanisms to utilize Host-based Intrusion Detection / Prevention Systems (HIDS / HIPS) on sensitive systems. | Does the organization utilize Host-based Intrusion Detection / Prevention Systems (HIDS / HIPS) on sensitive systems? | 1. Examine policies, procedures or associated documentation addressing the use of Host Intrusion Detection and Prevention Systems (HIDS/HIPS) technology and monitoring on sensitive systems and endpoints. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level workflows that support the facilitation of Host Intrusion Detection and Prevention Systems (HIDS/HIPS) technology and monitoring on sensitive systems and endpoints. | 1. Examine documentation describing the current configuration settings of the HIDS/HIPS technology for evidence configurations support the documentation outlined in the ToD. <br> <br> 2. Pull a population of HIDS/HIPS automated mechanisms for evidence the mechanisms are configured as identified. <br> <br> 3. Test a select sample set of automated mechanisms and their configuration settings identified for evidence that these mechanisms are operating as intended. | 

* *Test of Design* - (TOD) – verifies that a control is designed appropriately and that it will prevent or detect a particular risk.
* *Test of Operating Effectiveness* - (TOE) - used for verifying that the control is in place and it operates as it was designed.

### Policy Reference

* [Endpoint Management](https://about.gitlab.com/handbook/business-technology/team-member-enablement/onboarding-access-requests/endpoint-management/)
* [Mobile Device Management](https://about.gitlab.com/handbook/security/security-assurance/security-compliance/guidance/mobile-device-management.html)
