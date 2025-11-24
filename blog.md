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
        Print-inspired briefs from the trenches of identity and industrial security. Headlines read
        like a broadsheet; the columns click through to the full deep dives.
      </p>
      <p class="news-strapline">
        I write about identity done right (Okta, lifecycle, federation), Zero Trust without the buzzwords,
        and OT security patterns that respect safety and reality.
      </p>

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
