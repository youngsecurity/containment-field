---
layout: handbook-page-toc
title: "Configuration Management Controls"
---

## On this page
{:.no_toc .hidden-md .hidden-lg}

- TOC
{:toc .hidden-md .hidden-lg}

## Purpose
GitLab uses mechanisms to detect and alert on deviations from baseline configurations in production environments to ensure that configuration standards are being applied to all GitLab production systems.

## Scope

This control applies to all systems within our production environment. The production environment includes all endpoints and cloud assets used in hosting GitLab.com and its subdomains. This may include third-party systems that support the business of GitLab.com.

## Ownership
* Infrastructure owns this control.

## Controls

| Control Number | Control Title | Control Statement | Goal | TOD | TOE | 
|:---------|:-------------|:------|:-----|:-----|:-----|
| CFG-01 | Configuration Management Program | GitLab Inc. has implemented mechanisms to facilitate the implementation of configuration management security controls. | Does the organization facilitate the implementation of configuration management controls? | 1. Identify policies and procedures that outline responsibilities for configuration management. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level workflows that support the facilitation of configuration management. <br> <br> 3. Examine policies and procedures for: purpose; scope; roles and responsibilities; management commitment; coordination among organizational entities; compliance; and implementation requirements. | 1. Identify detection and monitoring procedures or standards used to assist with identification of configuration changes and vulnerabilities. <br> <br> 2. Examine change detection mechanisms including but not limited to: file integrity monitoring tools, vulnerability detection (known and unknown), vulnerability scans. | 
| CFG-02 | System Hardening Through Baseline Configurations | GitLab Inc. has implemented mechanisms to develop, document, review, update and maintain secure baseline configurations at least annually as part of system component installations and upgrades for technology platforms that are consistent with industry-accepted system hardening standards and automating reports on baseline configurations of the systems. | Does the organization develop, document and maintain secure baseline configurations for technology platform that are consistent with industry-accepted system hardening standards? | 1. Identify policies and procedures that outline responsibilities for baseline configurations and system hardening. <br> <br> 2. Interview key organizational personnel within GitLab to discuss high level workflows that support the facilitation of baseline configuration management and system hardening. <br> <br> 3. Examine policies and procedures for: purpose; scope; roles and responsibilities; management commitment; coordination among organizational entities; compliance; and implementation requirements. | 1. Identify applicable industry-accepted system hardening standards. <br> <br> 2. Examine automation reports on baseline configurations of the systems. <br> <br> 3. Examine documentation outlining baseline configurations and system hardening for technology platforms and systems for evidence of review and updates on (at minimum) an annual basis. | 

* *Test of Design* - (TOD) – verifies that a control is designed appropriately and that it will prevent or detect a particular risk.
* *Test of Operating Effectiveness* - (TOE) - used for verifying that the control is in place and it operates as it was designed.

### Policy Reference
*  [Chef deployment process](https://gitlab.com/gitlab-com/gl-infra/readiness/-/blob/master/library/cicd-pipeline/index.md)
*  [Baseline configurations and Chef cookbooks are maintained in the GitLab-cookbook repository](https://gitlab.com/gitlab-cookbooks) 
*  [Terraform - used to initialize GitLab.com infrastructure](https://gitlab.com/gitlab-com/gl-infra/readiness/-/blob/master/library/terraform-automation/index.md)
*  [Terraform configurations maintained in the gitlab-com-infrastructure repository](https://gitlab.com/gitlab-com/gitlab-com-infrastructure)
*  [Production Change Requests Handbook entry](/handbook/engineering/infrastructure/change-management/)

