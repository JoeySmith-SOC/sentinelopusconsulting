---
title: "Linux Automation"
image: /assets/img/projects/linux-automation.jpg
featured: true
short: "IaC + hardening pipelines for consistent, auditable infrastructure."
engagement: Lab Environment / Reference Architecture
tags:
  - Linux
  - Ansible
  - Terraform
  - DevSecOps
  - Automation
stack:
  - Ubuntu
  - Ansible
  - Terraform
  - Docker
  - Kubernetes
  - GitHub Actions
takeaways:
  - Golden images and Ansible baselines you can enforce and audit.
  - CI-backed builds for servers, containers, and clusters without snowflakes.
  - Runbooks for ops teams to maintain drift-free environments.
links:
  repo: https://github.com/JoeySmith-SOC/operator-linux-automation
---

## Problem / Context
Infrastructure drift and manual provisioning lead to inconsistent security posture and outages.

## Approach / Architecture
Codified golden images, CIS benchmarks, and idempotent builds with Ansible and Terraform. Pipelines build servers, containers, and clusters with GitHub Actions.

## Outcome / Impact
Version-controlled automation for faster, compliant, repeatable infrastructure deployments that ops can extend.
