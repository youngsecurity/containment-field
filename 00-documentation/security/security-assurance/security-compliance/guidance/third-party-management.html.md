---
layout: handbook-page-toc
title: "Third-Party Management Controls"
---

## On this page

{:.no_toc .hidden-md .hidden-lg}

- TOC
  {:toc .hidden-md .hidden-lg}

## Purpose

GitLab ensures that security and privacy risks associated with third-parties are minimized and enable measures to sustain operations should a third-party become defunct and operates so that only trustworthy third-parties are used.

## Scope

This control applies to all third party providers that interact with data within the GitLab production environment, or any third party providers that a GitLab production system relies upon.

## Ownership

The control owner is Security Compliance

## Controls

| Control Number | Control Title | Control Statement | Goal | TOD | TOE | 
|:---------|:-------------|:------|:-----|:-----|:-----|
| TPM-01 | Third-Party Management | GitLab Inc. has implemented mechanisms for third-party management security controls. | Does the organization facilitate the implementation of third-party management controls? | 1. Identify policies, procedures, or other relevant documentation responsible for the implementation of third-party management security controls. <br> <br> 2. Examine policies and procedures for: Purpose; Scope; Roles and responsibilities; Management commitment; Coordination among organizational entities; Compliance; and Implementation requirements. | 1. Examine relevant policies, procedures and other documentation that support the security for managing third-parties. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level workflows that support the implementation of confidentiality and integrity of information with the implementation of third-parties.  |
| TPM-02 | Third-Party Criticality Assessments | GitLab Inc. has implemented mechanisms to identify, prioritize and assess suppliers and partners of critical systems, components and services using a supply chain risk assessment process relative to their importance in supporting the delivery of high-value services. | Does the organization identify, prioritize and assess suppliers and partners of critical systems, components and services using a supply chain risk assessment process? | 1. Identify policies, procedures, or other relevant documentation responsible for the implementation of third-party management security controls. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level workflows that support the assessment of third-party vendors to deliver high-value services. | 1. Examine relevant policies, procedures and other documentation that support the security for vetting third-parties. <br> <br> 2. Examine security control risk assessments for evidence of documented and planned remedial activities as outlined in the ToD. |
| TPM-03 | Supply Chain Protection | GitLab Inc. has implemented security safeguard mechanisms when evaluating security risks and addressing identified weaknesses or deficiencies in the security associated with the services and product supply chain and to limit harm from potential adversaries who identify and target the organization’s supply chain by utilizing tailored acquisition strategies, contract tools and procurement methods for the purchase of unique systems, system components or services. | Does the organization evaluate security risks associated with the services and product supply chain? | 1. Identify industry-recognized cybersecurity and privacy practices utilized for threat awareness addressing security risks and identifying weaknesses or deficiencies via third-party services. <br> <br> 2. Identify the policies, procedures and related documents outlining the organization-wide implementation and management of baseline secure procurement processes. | 1. Examine the procurement processes for evidence they follow the industry-recognized cybersecurity and privacy standards. <br> <br> 2. Interview key organizational personnel within GitLab conducting discussions for evidence that mechanisms exist to reduce the likelihood of unauthorized modifications and protect systems and components and document in accordance to TOD. |
| TPM-07 | Monitoring for Third-Party Information Disclosure | GitLab Inc. has implemented mechanisms to monitor for evidence of unauthorized exfiltration or disclosure of organizational information. | Does the organization monitor for evidence of unauthorized exfiltration or disclosure of organizational information? | 1. Identify the policies, procedures and related documents outlining the organization-wide security requirements third-parties must comply with related to unauthorized exfiltration or disclosure of organizational information | 1. Inspect monitoring tool and related configurations of unauthorized exfiltration of information. <br> <br> 2. Obtain a population of data exfiltration incidents and obtained evidence that appropriate remediation was completed based on the outlined policies and procedures. |
| TPM-09 | Third-Party Deficiency Remediation | GitLab Inc. has implemented mechanisms to address weaknesses or deficiencies in supply chain elements identified during independent or organizational assessments of such elements. | Does the organization address weaknesses or deficiencies in supply chain elements identified during independent or organizational assessments of such elements? | 1. Identify the policies, procedures and related documents outlining the organization-wide security requirements third-parties must comply with and how to address identified weaknesses and/or deficiencies. | 1. Obtain a population of third-party assessments completed. <br> <br> 2. Select a sample of assessments and evaluate if any identified weaknesses and/or deficiencies were remediated aligned to the policies and procedures. |
| TPM-10 | Managing Changes To Third-Party Services | GitLab Inc. has implemented mechanisms to control changes to services by suppliers, taking into account the criticality of business information, systems and processes that are in scope by the third-party. | Does the organization control changes to services by suppliers, taking into account the criticality of business information, systems and processes that are in scope by the third-party? | 1. Identify the policies, procedures and related documents outlining the organization-wide security requirements third-parties must comply with and the communication requirements to stakeholders outlining the impact and approval of proposed changes prior to initiating a change. | 1. Examine formal policies, procedures or other relevant documentation to appropriately identify the security requirements for third-party providers. <br> <br> 2. Identify if any changes have occurred via third-party services. <br> <br> 3. Interview key organizational personnel within GitLab conducting discussions for evidence that mechanisms exist to communicate with third-party personnel regarding signed contracts and document in accordance to TOD. <br> <br> 4. Confirm potential security and business impacts were identified, assessed and approved prior to initiating the change of service via the third-party provider. |


* *Test of Design* - (TOD) – verifies that a control is designed appropriately and that it will prevent or detect a particular risk.
* *Test of Operating Effectiveness* - (TOE) - used for verifying that the control is in place and it operates as it was designed.

### Policy Reference

- [Legal Handbook page](/handbook/legal/)
- [Procure to Pay process](/handbook/finance/procurement/)
- [Uploading Vendor Contract into ContractWorks process](/handbook/legal/vendor-contract-filing-process/)
- [Contract types](/handbook/finance/procurement/procurement-services)
- [NetSuite Vendor Report](https://app.periscopedata.com/app/gitlab/557709/Vendor-Reporting)
- [Process for modifying sales contracts](/handbook/legal/customer-negotiations/)
- [Process for negotiating terms](/handbook/sales/field-operations/order-processing/#process-for-agreement-terms-negotiations-when-applicable-and-contacting-legal)
- [Vendor compliance monitoring process in the Compliance repo runbook](https://gitlab.com/gitlab-com/gl-security/security-assurance/sec-compliance/compliance/blob/master/runbooks/Vendor_Security_Report_Review.md)
- [PCI-DSS SAQ-A 12.8.4 - Monitor Service Providers' PCI DSS Compliance Status](https://gitlab.com/gitlab-com/gl-security/security-assurance/sec-compliance/compliance/issues/100)
- [Procure to Pay section of the handbook](/handbook/finance/accounting/#procure-to-pay)
- [Third Party Risk Management Procedure](/handbook/security/security-assurance/security-risk/third-party-risk-management.html)
