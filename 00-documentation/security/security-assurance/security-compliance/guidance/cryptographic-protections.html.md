---
layout: handbook-page-toc
title: "Cryptographic Protection Controls"
---

## On this page
{:.no_toc .hidden-md .hidden-lg}

- TOC
{:toc .hidden-md .hidden-lg}

## Purpose
GitLab ensures the confidentiality of data through implementing and utilizing appropriate cryptographic technologies to protect the confidentiality and integrity of sensitive data both at rest and in transit.  Without encryption, data in transit over public networks can easily be intercepted using automated, open source tools and viewed and maliciously modified by malicious actors.

## Scope
This control is applicable to the production environment and any end user devices that store such data. The production environment includes all endpoints and cloud assets used in hosting GitLab.com and its subdomains. This may also include third-party systems that support the business of GitLab.com

## Ownership
This control is owned by Infrastructure.

## Controls

| Control Number | Control Title | Control Statement | Goal | TOD | TOE |
|:---------|:-------------|:------|:-----|:-----|:-----|
| CRY-01 | Use of Cryptographic Controls | GitLab Inc. has established mechanisms to facilitate the implementation of cryptographic protections security controls using known public standards and trusted cryptographic technologies. | Does the organization facilitate the implementation of cryptographic protections controls using known public standards and trusted cryptographic technologies? | 1. Identify policies and procedures responsible for identification and implementation of cryptographic protections security controls using known public standards and trusted cryptographic technologies. <br> <br> 2. Examine policies and procedures for: purpose; scope; roles and responsibilities; management commitment; coordination among organizational entities; compliance; and implementation requirements. | 1. Examine the cryptographic technology used to facilitate cryptographic protections. <br> <br> 2. Examine the logical and physical access controls use to support cryptographic protections (as applicable). <br> <br> 3. Confirm the cryptographic protections used are known and trusted public standard or technology. |
| CRY-03 | Transmission Confidentiality | GitLab Inc. has implemented cryptographic mechanisms to protect the confidentiality of data being transmitted. | Are cryptographic mechanisms utilized to protect the confidentiality of data being transmitted? | 1. Identify policies and procedures responsible for implementation of cryptographic protections of transmitted data. | 1. Examine relevant documentation for configured mechanism settings to support the protection and confidentiality of data being transmitted. <br> <br> 2. Confirm the methods by which the data being transmitted is encrypted and not visible via plain-text by physical means (e.g., by employing protected distribution systems) or by logical means (e.g., employing encryption techniques). |
| CRY-05 | Encrypting Data At Rest | GitLab Inc. has implemented cryptographic mechanisms to prevent unauthorized disclosure of information at rest. | Are cryptographic mechanisms utilized on systems to prevent unauthorized disclosure of information at rest? | 1. Identify policies and procedures responsible for implementation of cryptographic protections to prevent unauthorized disclosure of information at rest. | 1. Examine relevant documentation for configured cryptographic mechanism settings to support the protection of data at rest from unauthorized disclosure. <br> <br> 2. Confirm the methods by which the data at rest is encrypted and not visible via plain-text by confirming configurations or rule sets for firewalls, gateways, intrusion detection/prevention systems, filtering routers, and authenticator content including the use of cryptographic mechanisms and file share scanning. |
| CRY-09 | Cryptographic Key Management | GitLab Inc. has implemented mechanisms to facilitate cryptographic key management security controls to protect the confidentiality, integrity and availability of keys. | Does the organization facilitate cryptographic key management controls to protect the confidentiality, integrity and availability of keys? | 1. Identify policies and procedures responsible for implementation of a secure public key infrastructure to prevent unauthorized disclosure of information and meeting the requirements of applicable federal laws, Executive Orders, directives, regulations, polilcies, standareds, guidance for such authentication. | 1. Examine formal policies, procedures or other relevant documentation to appropriately identify the configuration settings for secure PKI or obtain PKI services from a reputable provider to support the protection of data from unauthorized disclosure. <br> <br> 2. Pull a population of all configuration settings. <br> <br> 3. Examine a sample set of the automated mechanisms and their configuration settings conducting testing that the mechanisms are operating as intended. |

### Policy Reference
* [GitLab Production Architecture](/handbook/engineering/infrastructure/production/architecture/)
* [Encryption in Transit in Google Cloud](https://cloud.google.com/security/encryption-in-transit/)
* [Deprecate support for TLS 1.0 and TLS 1.1](https://gitlab.com/gitlab-com/gl-security/security-department-meta/issues/202)
* [Encryption Policy](/handbook/security/threat-management/vulnerability-management/encryption-policy.html)
* [GitLab Cryptography Standard](/handbook/security/cryptographic-standard.html)
