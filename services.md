---
layout: page
title: Services
permalink: /services/
body_class: services-page
---

<section class="page-hero services-hero">
  <div class="container">
    <p class="eyebrow">Services</p>
    <h1>Identity, Automation, and OT Security — Built to Ship</h1>
    <p class="lead">
      I help teams design and implement secure, reliable infrastructure —
      from Okta and Zero Trust to Linux automation and OT networks.
    </p>
  </div>
</section>

<section class="section services-section">
  <div class="container">
    <h2 class="section-title">Core Service Areas</h2>
    <p class="section-sub">
      Every engagement is practical, hands-on, and focused on outcomes:
      fewer surprises, fewer tickets, and systems that are easy to operate.
    </p>

    <div class="svc-grid">
      <article class="svc-card">
        <h3>Identity &amp; Access Management</h3>
        <p>
          Okta as the control plane for users, apps, and infrastructure. Federation,
          SSO, and lifecycle automation that doesn’t get in the way.
        </p>
        <ul>
          <li>Okta org design, groups, and access policies</li>
          <li>SAML / OIDC integrations with apps and portals</li>
          <li>Lifecycle automation for joiners / movers / leavers</li>
          <li>Basic access reviews and cleanup plans</li>
        </ul>
      </article>

      <article class="svc-card">
        <h3>Zero Trust &amp; Network Edge</h3>
        <p>
          Replace flat networks with identity-aware, policy-driven access using
          Cloudflare and modern edge patterns.
        </p>
        <ul>
          <li>Cloudflare Zero Trust and Access configuration</li>
          <li>SSH / RDP / web app protection without a VPN mess</li>
          <li>Device posture, mTLS, and least-privilege design</li>
          <li>Migration plans from legacy perimeter models</li>
        </ul>
      </article>

      <article class="svc-card">
        <h3>Automation &amp; Infrastructure</h3>
        <p>
          Make environments repeatable, testable, and version-controlled instead
          of one-off snowflakes.
        </p>
        <ul>
          <li>Linux server baselines and hardening</li>
          <li>Ansible playbooks for common operations</li>
          <li>Infrastructure-as-code patterns (Terraform, Git workflows)</li>
          <li>Lab environments for training and change testing</li>
        </ul>
      </article>

      <article class="svc-card">
        <h3>OT &amp; Electrical Integration</h3>
        <p>
          Bridge cyber and the shop floor: SCADA/ICS, PLCs, and electrical
          systems with security and safety in mind.
        </p>
        <ul>
          <li>Network segmentation for ICS / SCADA environments</li>
          <li>Access patterns for engineers, operators, and vendors</li>
          <li>Logging and monitoring for critical systems</li>
          <li>Practical, field-friendly security improvements</li>
        </ul>
      </article>
    </div>
  </div>
</section>

<section class="section services-engagement">
  <div class="container">
    <h2 class="section-title">How Engagements Work</h2>
    <p class="section-sub">
      I keep the process simple and transparent. No black-box “mystery projects.”
    </p>

    <div class="engagement-grid">
      <article class="engagement-step">
        <h3>1. Discovery &amp; Priorities</h3>
        <p>
          We map your current environment, goals, and constraints — what exists,
          what hurts, and what has to work on day one.
        </p>
      </article>

      <article class="engagement-step">
        <h3>2. Target Architecture &amp; Plan</h3>
        <p>
          I outline a practical architecture and phased roadmap: what we’ll build now,
          what comes later, and the trade-offs involved.
        </p>
      </article>

      <article class="engagement-step">
        <h3>3. Build, Automate, Harden</h3>
        <p>
          Implementation work: Okta configs, Cloudflare policies, Linux baselines,
          automation, and documentation as we go.
        </p>
      </article>

      <article class="engagement-step">
        <h3>4. Handoff &amp; Support Options</h3>
        <p>
          You get runbooks, diagrams, and a clean hand-off. I can stay on in a
          fractional/retainer capacity or step back once you’re stable.
        </p>
      </article>
    </div>
  </div>
</section>

<section class="section services-cta">
  <div class="container services-cta-inner">
    <div>
      <h2 class="section-title">Ready to talk through a project?</h2>
      <p class="section-sub">
        Whether you need IAM cleanup, a Zero Trust rollout, or OT segmentation,
        we can start with a short discovery call.
      </p>
    </div>
    <div class="cta-row">
      <a class="btn primary" href="{{ '/contact/' | relative_url }}">Book a consult</a>
      <a class="btn" href="mailto:{{ site.email | default: 'joey@sentinelopusconsulting.com' }}">Email me directly</a>
    </div>
  </div>
</section>
