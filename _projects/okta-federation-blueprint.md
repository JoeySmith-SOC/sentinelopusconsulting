---
title: "Okta Federation Blueprint"
image: /assets/img/projects/ot_security_sim.jpg
featured: true
short: "Reference design for SAML/OIDC, hardened policies, and lifecycle integrations."
engagement: Lab Environment / Reference Architecture
tags:
  - Federation
  - Okta
  - OIDC
  - SAML
  - Identity Security
stack:
  - Okta
  - OIDC
  - SAML
  - AWS
  - PowerShell
  - Terraform
takeaways:
  - A vetted pattern for choosing SAML vs OIDC per app, with policy guardrails.
  - Lifecycle flows wired from HR to groups to apps, with audit trails.
  - Hardened federation defaults your admins can maintain after handoff.
links:
  repo: https://github.com/JoeySmith-SOC/okta-federation-blueprint
---

## Problem / Context
Teams struggle to choose and implement secure federation methods that scale, leading to fragile app configs and risky defaults.

## Approach / Architecture
Built a reference blueprint comparing SAML and OIDC patterns with Okta and AD federation. Mapped lifecycle automation from HR to groups to apps, and captured hardened policy defaults and runbooks.

## Outcome / Impact
Delivered reusable templates and documentation for SMB → Enterprise federation adoption, including posture for admins, vendors, and service accounts.
