---
title: "SCADA Security Automation Lab"
image: /assets/img/projects/all_projects.jpg
featured: true
short: "Zero Trust segmentation, IDS, and automated response in an ICS environment."
engagement: Lab Environment / Reference Architecture
tags:
  - SCADA
  - ICS Security
  - Ansible
  - Snort IDS
  - OT Networks
stack:
  - Parrot OS
  - VirtualBox
  - VLANs
  - iptables
  - Snort
  - Wireshark
  - Python
  - Ansible
  - Grafana
takeaways:
  - Segmentation and RBAC patterns that respect OT constraints.
  - IDS + automation path from alert to action with playbooks.
  - Dashboards that baseline OT traffic for operators and engineers.
links:
  repo: https://github.com/JoeySmith-SOC/scada-lab
---

## Problem / Context
Industrial networks often lack segmentation, visibility, and automation across IT/OT boundaries.

## Approach / Architecture
Built a lab simulating OT/ICS infrastructure with VLAN segmentation, RBAC, Snort IDS, and Ansible automation. Included logging and dashboards for operators.

## Outcome / Impact
Demonstrated “alert-to-action” response workflows and dashboards showing live traffic baselines operators can understand.
