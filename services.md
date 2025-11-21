---
layout: page
title: Services
permalink: /services/
body_class: services-page
---

<section class="page-hero services-hero">
  <div class="container services-hero-inner">
    <div class="services-hero-copy">
      <p class="eyebrow">Services</p>
      <h1>Identity, Automation, and OT Security that actually ships</h1>
      <p class="lead">
        I help teams design and implement secure, reliable infrastructure —
        from Okta and Cloudflare Zero Trust to Linux automation and OT networks.
        No black boxes. No slideware. Just systems that work and are easy to operate.
      </p>
      <div class="cta-row">
        <a class="btn primary" href="{{ '/contact/' | relative_url }}">Book a consult</a>
        <a class="btn ghost" href="mailto:{{ site.email | default: 'joey@sentinelopusconsulting.com' }}">
          Email me directly
        </a>
      </div>
      <ul class="services-badges" aria-label="Key capabilities">
        <li>Okta &amp; Identity Architecture</li>
        <li>Cloudflare Zero Trust</li>
        <li>Linux &amp; Automation</li>
        <li>SCADA / OT Integration</li>
      </ul>
    </div>

    <div class="services-hero-highlight" aria-hidden="true">
      <div class="services-hero-card">
        <span class="card-label">Typical outcomes</span>
        <ul>
          <li>Fewer tickets and access escalations</li>
          <li>Cleaner, auditable identity &amp; access</li>
          <li>Zero Trust that users don’t hate</li>
          <li>OT networks that are segmented, not fragile</li>
        </ul>
      </div>
    </div>
  </div>
</section>

<section class="section services-section">
  <div class="container">
    <h2 class="section-title">What I help you ship</h2>
    <p class="section-sub">
      Every engagement is practical, hands-on, and oriented around outcomes:
      fewer surprises, fewer tickets, and infrastructure that’s easy to live with.
    </p>

    <div class="svc-grid">
      <article class="svc-card">
        <header class="svc-card-header">
          <img
            src="{{ '/assets/icons/user-shield.svg' | relative_url }}"
            alt="Identity &amp; Access icon"
            class="svc-icon"
            loading="lazy"
            decoding="async"
          >
          <h3>Identity &amp; Access Management</h3>
        </header>
        <p>
          Okta as the control plane for users, apps, and infrastructure. Federation,
          lifecycle, and access patterns that don’t devolve into chaos six months later.
        </p>
        <ul>
          <li>Okta org design, groups, and access policies</li>
          <li>SAML / OIDC integrations for key applications</li>
          <li>Lifecycle automation for joiners / movers / leavers</li>
          <li>Basic governance &amp; access review playbooks</li>
        </ul>
        <p class="svc-footer">Good fit when you’ve “outgrown” ad-hoc IAM and need a clear design.</p>
      </article>

      <article class="svc-card">
        <header class="svc-card-header">
          <img
            src="{{ '/assets/icons/cloud-lock.svg' | relative_url }}"
            alt="Zero Trust icon"
            class="svc-icon"
            loading="lazy"
            decoding="async"
          >
          <h3>Zero Trust &amp; Network Edge</h3>
        </header>
        <p>
          Replace flat networks and brittle VPNs with identity-aware, policy-driven access
          using Cloudflare and modern edge patterns.
        </p>
        <ul>
          <li>Cloudflare Zero Trust &amp; Access configuration</li>
          <li>SSH / RDP / web app access without VPN sprawl</li>
          <li>Device posture, mTLS, and least-privilege policies</li>
          <li>Migrations from perimeter firewalls to Zero Trust</li>
        </ul>
        <p class="svc-footer">Good fit when “just open the firewall” is the current answer to everything.</p>
      </article>

      <article class="svc-card">
        <header class="svc-card-header">
          <img
            src="{{ '/assets/icons/automation.svg' | relative_url }}"
            alt="Automation icon"
            class="svc-icon"
            loading="lazy"
            decoding="async"
          >
          <h3>Linux, Automation &amp; Infra</h3>
        </header>
        <p>
          Make environments repeatable, testable, and version-controlled instead
          of one-off snowflakes that nobody wants to touch.
        </p>
        <ul>
          <li>Linux server baselines and hardening</li>
          <li>Ansible playbooks for common operations</li>
          <li>Intro patterns for Terraform &amp; infra-as-code</li>
          <li>Lab environments for training &amp; safe change</li>
        </ul>
        <p class="svc-footer">Good fit when your infra lives in shell history and tribal knowledge.</p>
      </article>

      <article class="svc-card">
        <header class="svc-card-header">
          <img
            src="{{ '/assets/icons/server-cog.svg' | relative_url }}"
            alt="ICS / OT integration icon"
            class="svc-icon"
            loading="lazy"
            decoding="async"
          >
          <h3>SCADA / OT &amp; Electrical Integration</h3>
        </header>
        <p>
          Bridge cyber and the shop floor: SCADA / ICS, PLCs, and electrical systems
          with security and safety in mind — not just theory.
        </p>
        <ul>
          <li>Network segmentation for ICS / SCADA environments</li>
          <li>Role-based access patterns for engineers &amp; operators</li>
          <li>Logging &amp; monitoring for critical OT systems</li>
          <li>Practical controls that don’t break operations</li>
        </ul>
        <p class="svc-footer">Good fit when OT risk keeps coming up but nobody owns it.</p>
      </article>
    </div>
  </div>
</section>

<section class="section services-fit">
  <div class="container services-fit-inner">
    <div>
      <h2 class="section-title">Who I’m a good fit for</h2>
      <p class="section-sub">
        I do my best work with teams who want honest feedback, clear plans,
        and systems that will still make sense a year from now.
      </p>
      <div class="fit-grid">
        <div class="fit-card">
          <h3>Great fit</h3>
          <ul>
            <li>Security, IT, or engineering leaders who own outcomes</li>
            <li>Teams ready to document and standardize how things work</li>
            <li>Orgs that treat security and operations as a long-term asset</li>
          </ul>
        </div>
        <div class="fit-card fit-card--nofit">
          <h3>Not a great fit</h3>
          <ul>
            <li>“Just pass the audit” projects with no intent to maintain</li>
            <li>Pure slideware or strategy decks with no implementation</li>
            <li>Situations where nobody can be the internal owner</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="section services-engagement">
  <div class="container">
    <h2 class="section-title">How engagements work</h2>
    <p class="section-sub">
      The process is lightweight, transparent, and designed so you always know
      what’s happening and why.
    </p>

    <div class="engagement-grid">
      <article class="engagement-step">
        <span class="engagement-step-number">1</span>
        <h3>Discovery &amp; priorities</h3>
        <p>
          We map your current environment, goals, and constraints —
          what exists today, what hurts, and what has to work on day one.
        </p>
      </article>

      <article class="engagement-step">
        <span class="engagement-step-number">2</span>
        <h3>Target design &amp; roadmap</h3>
        <p>
          I outline a realistic architecture and phased plan: what we’ll build now,
          what comes later, and the trade-offs along the way.
        </p>
      </article>

      <article class="engagement-step">
        <span class="engagement-step-number">3</span>
        <h3>Build, automate, harden</h3>
        <p>
          Implementation work: Okta configs, Cloudflare policies, Linux baselines,
          automation, documentation, and knowledge transfer as we go.
        </p>
      </article>

      <article class="engagement-step">
        <span class="engagement-step-number">4</span>
        <h3>Handoff &amp; ongoing options</h3>
        <p>
          You get runbooks, diagrams, and clean hand-off. I can stay on in a
          fractional / retainer capacity or step back once you’re stable.
        </p>
      </article>
    </div>
  </div>
</section>

<section class="section services-faq">
  <div class="container">
    <h2 class="section-title">Common questions</h2>

    <div class="faq-grid">
      <article class="faq-item">
        <h3>Do you offer fixed-scope projects or retainers?</h3>
        <p>
          Both. Smaller, well-defined projects (Okta cleanup, Cloudflare rollout,
          lab design) are typically fixed-scope. Longer roadmaps (multi-month
          IAM / OT uplift) often work best as a retainer.
        </p>
      </article>

      <article class="faq-item">
        <h3>Can you work with our internal team?</h3>
        <p>
          Yes — that’s the default. My goal is to leave your team stronger:
          better patterns, better documentation, and systems they’re confident
          owning without me.
        </p>
      </article>

      <article class="faq-item">
        <h3>Do you only work remotely?</h3>
        <p>
          Most work is remote, but on-site is possible for the right fit,
          especially when OT / electrical environments are involved.
        </p>
      </article>

      <article class="faq-item">
        <h3>What’s the best way to get started?</h3>
        <p>
          A short discovery call. We’ll look at where you are now, where you
          want to be, and whether I’m the right person to help. If not, I’ll
          tell you honestly and point you in a better direction.
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
        we can start small, design clearly, and build something your team
        actually wants to use.
      </p>
    </div>
    <div class="cta-row">
      <a class="btn primary" href="{{ '/contact/' | relative_url }}">Book a consult</a>
      <a class="btn" href="mailto:{{ site.email | default: 'joey@sentinelopusconsulting.com' }}">Email me directly</a>
    </div>
  </div>
</section>
