---
layout: default
title: Identity, Zero Trust & OT Security Blog | Sentinel Opus
permalink: /blog/
description: Notes on identity, Zero Trust, automation, and OT security.
styles:
  - /assets/css/blog.css
---

<main class="blog-page-main">

  <!-- BLOG HERO -->
  <section class="blog-hero">
    <div class="container blog-hero-inner">
      <p class="eyebrow">Blog</p>
      <h1>Deep dives on identity, automation, and OT security</h1>
      <p class="blog-hero-sub">
        Field notes from real-world IAM, Zero Trust, Linux, and SCADA work. No fluff — just patterns,
        postmortems, and guides you can actually use.
      </p>
      <div class="blog-hero-pills">
        <span class="chip">Identity</span>
        <span class="chip">Zero Trust</span>
        <span class="chip">OT/ICS</span>
        <span class="chip">Digital Twin</span>
        <span class="chip">Cloud</span>
        <span class="chip">Linux &amp; Automation</span>
      </div>
    </div>
  </section>

  <!-- BLOG LIST -->
  <section class="blog-listing newsprint">
    <div class="container">
      <div class="news-masthead">
        <div class="news-flag">
          <span class="news-flag-name">Sentinel Opus Ledger</span>
          <span class="news-flag-tagline">Identity • Zero Trust • OT Security</span>
        </div>
        <div class="news-edition">
          <span class="news-edition-label">Field Notes Edition</span>
          <span class="news-edition-date">{{ "now" | date: "%A, %B %-d, %Y" }}</span>
        </div>
      </div>

      
      <p class="news-strapline">
        I write about identity done right (Okta, lifecycle, federation), Zero Trust,
        and OT security — plus a flagship 15-part refinery digital twin build.
      </p>

      {% assign welcome_post = site.posts | where: "title", "Welcome" | first %}
      <section class="refinery-series welcome-feature">
        <div class="refinery-header">
          <h2>Start here: Welcome</h2>
          <p class="refinery-sub">What this blog is about — why identity, Zero Trust, and OT security matter, and how I approach them.</p>
        </div>
        {% if welcome_post %}
        <article class="refinery-card refinery-card--welcome">
          <h3>{{ welcome_post.title }}</h3>
          <p class="refinery-teaser">
            {{ welcome_post.excerpt | strip_html | truncate: 200 }}
          </p>
          <div class="refinery-tags">
            <span class="chip">Identity</span>
            <span class="chip">Zero Trust</span>
            <span class="chip">OT/ICS</span>
          </div>
          <a class="card-link" href="{{ welcome_post.url | relative_url }}">Read the welcome post →</a>
        </article>
        {% endif %}
      </section>

      <section id="refinery-series" class="refinery-series">
        <div class="refinery-header">
          <h2>The Refinery Rebuild Series — A 15-Part Deep Dive Into the Future of OT Security</h2>
          <p class="refinery-sub">Upcoming articles detailing the Zero Trust OT/ICS digital twin refinery build.</p>
        </div>
        <div class="refinery-grid">
          {% assign refinery_titles = "
          Rebuilding the Refinery: How I Designed a Zero Trust OT/ICS Digital Twin from Scratch |
          Why Modern Refineries Need Identity-First OT Security — And How I Designed It |
          Inside the OT Lab: Simulating a Real Refinery Without the Danger |
          Cloud + OT: The Future of Remote Operations Centers (And How I Built Mine on AWS) |
          No More VPNs: Using Cloudflare Zero Trust to Secure OT Like It’s 2025 |
          The Problem with Industrial Security Today — And the Architecture That Fixes It |
          Attack the Twin: How Cyber Threats Behave Inside a Digital Refinery |
          Failure Is Data: Simulating Pressure Spikes, Vibration Failures, and Alarm Cascades |
          The Death of Perimeter-Based OT Security: A Zero Trust Blueprint for Critical Infrastructure |
          From Local Lab to Cloud ROC: Designing Secure Telemetry Flows for Industrial Systems |
          How to Bridge IT, OT, and Cloud Without Breaking the Plant |
          Identity Beats Firewalls: Why Okta Belongs in Industrial Control Systems |
          Digital Twins Are Not Enough: Why Industrial Twins Must Include Security |
          Engineering a Modern Refinery: What My Digital Twin Proves About the Future of OT |
          Building the Operator Console of the Future: Dashboards That Actually Matter
          " | split: "|" %}
          {% for t in refinery_titles %}
          {% assign title = t | strip %}
          <article class="refinery-card">
            <h3>{{ title }}</h3>
            <p class="refinery-teaser">Practical notes from my refinery digital twin: Zero Trust design, identity-first OT, Cloudflare ZT, attack simulations, and ROC pipelines.</p>
            <div class="refinery-tags">
              <span class="chip">Identity</span>
              <span class="chip">Zero Trust</span>
              <span class="chip">OT/ICS</span>
              <span class="chip">Digital Twin</span>
              <span class="chip">Cloud</span>
              <span class="chip">Automation</span>
            </div>
          </article>
          {% endfor %}
        </div>
      </section>

      <div class="news-rules" aria-hidden="true"></div>

      <div class="blog-grid news-grid">
        {% for post in site.posts %}
        <article class="blog-card news-card{% if forloop.first %} news-card--lead{% endif %}">
          <a class="blog-card-link" href="{{ post.url | relative_url }}">
            <div class="blog-card-meta news-card-meta">
              <span class="blog-card-date">
                {{ post.date | date: "%A, %B %-d, %Y" }}
              </span>

              {% if post.tags %}
              <span class="blog-card-tag">
                {{ post.tags | join: ", " }}
              </span>
              {% endif %}
            </div>

            <h3 class="blog-card-title news-card-title">
              {{ post.title }}
            </h3>

            {% if post.excerpt %}
            <p class="blog-card-excerpt news-card-excerpt">
              {{ post.excerpt | strip_html | truncate: 180 }}
            </p>
            {% endif %}

            <div class="blog-card-footer news-card-footer">
              <span class="news-read-more">Continue reading</span>
              <span class="blog-card-arrow" aria-hidden="true">→</span>
            </div>
          </a>
        </article>
        {% endfor %}
      </div>

      {% if site.posts == empty %}
      <p class="blog-empty">
        No posts yet. I’m probably busy breaking and rebuilding something in a lab.
      </p>
      {% endif %}
    </div>
  </section>

</main>
