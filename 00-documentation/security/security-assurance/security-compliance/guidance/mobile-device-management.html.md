---
layout: handbook-page-toc
title: "Mobile Device Management Controls"
---

## On this page
{:.no_toc .hidden-md .hidden-lg}

- TOC
{:toc .hidden-md .hidden-lg}

## Purpose
GitLab govern risks associated with mobile devices, regardless if the device is owned by the organization, its users or trusted third-parties. Wherever possible, technologies are employed to centrally manage mobile device access and data storage practices to restrict logical and physical access to the devices, as well as the amount and type of data that can be stored, transmitted or processed. 

## Scope
This applies to all GitLab, Inc. employees. The production environment includes all endpoints and cloud assets used in hosting GitLab.com and its subdomains.  [Endpoint devices](https://about.gitlab.com/handbook/business-technology/team-member-enablement/onboarding-access-requests/endpoint-management/) are inclusive of all GitLab-procured systems/devices and are categorized differently from [mobile devices](https://about.gitlab.com/handbook/security/security-assurance/security-compliance/guidance/mobile-device-management.html) which are team-member owned devices.

## Ownership
This control is owned by IT Ops

## Controls

| Control Number | Control Title | Control Statement | Goal | TOD | TOE | 
|:---------|:-------------|:------|:-----|:-----|:-----|
| MDM-01 | Centralized Management of Mobile Devices | GitLab Inc. has implemented mechanisms to develop, govern & update procedures to facilitate the implementation of mobile device management controls. | Does the organization develop, govern & update procedures to facilitate the implementation of mobile device management controls? | 1. Identify policies, procedures, or other relevant documentation that govern mobile device management controls. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level workflows that support the implementation of mobile device management controls. <br> <br> 3: Examine policies and procedures for: purpose; scope; roles and responsibilities; management commitment; coordination among organizational entities; compliance; and implementation requirements. | 1. Examine relevant documentation and configurations that support the facilitation of mobile device management controls over security software, infrastructure, architectures and they relate to mobile device management controls. | 
| MDM-03 | Full Device & Container-Based Encryption | GitLab Inc. has implemented cryptographic mechanisms to protect the confidentiality and integrity of information on mobile devices through full-device or container encryption. | Are cryptographic mechanisms utilized to protect the confidentiality and integrity of information on mobile devices through full-device or container encryption? | 1. Identify policies, procedures, or other relevant documentation that facilitate the implementation of mechanisms to protect the confidentiality and integrity of information on mobile devices through full-device or container encryption. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level workflows that support the implementation of confidentiality and integrity of information following mobile device management controls. <br> <br> 3. Examine policies and procedures for: purpose; scope; roles and responsibilities; management commitment; coordination among organizational entities; compliance; and implementation requirements. | 1. Examine relevant documentation and configurations that support the facilitation of confidentiality and integrity of information on mobile devices accessing security software, infrastructure, architectures as they relate to mobile device management controls. <br> <br> 2. Pull a population of all managed mobile devices connected to GitLab’s network. <br> <br> 3. Inspect a sample of evidence to confirm cryptographic protections have been implemented according to TOD. | 

* *Test of Design* - (TOD) – verifies that a control is designed appropriately and that it will prevent or detect a particular risk.
* *Test of Operating Effectiveness* - (TOE) - used for verifying that the control is in place and it operates as it was designed.

### Policy Reference

* [Acceptable Use Policy](https://about.gitlab.com/handbook/people-group/acceptable-use-policy/)
* [Endpoint Management](https://about.gitlab.com/handbook/business-technology/team-member-enablement/onboarding-access-requests/endpoint-management/)
