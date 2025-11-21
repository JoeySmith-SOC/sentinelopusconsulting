---
layout: default
title: Blog
permalink: /blog/
styles:
  - /assets/css/blog.css
---

<div class="blog-page-main">
  <section class="blog-hero">
    <div class="blog-hero-media">
      <video
        class="blog-hero-video"
        autoplay
        muted
        loop
        playsinline
        preload="metadata"
        aria-hidden="true">
        <source src="{{ '/assets/video/blog_hero_background.mp4' | relative_url }}" type="video/mp4">
        Your browser does not support the video tag.
      </video>
      <div class="blog-hero-overlay"></div>
    </div>

    <div class="container">
      <div class="blog-hero-inner">
        <p class="eyebrow">Blog</p>
        <h1>Practical identity, Zero Trust, and OT security that actually ships</h1>
        <p class="blog-hero-sub">
          Field-tested patterns from real deployments: Okta, Cloudflare Zero Trust, Linux automation,
          and industrial networks that stay safe without slowing the work down.
        </p>
        <div class="blog-hero-actions">
          <a class="btn primary" href="{{ '/contact/' | relative_url }}">Book a consult</a>
          <a class="btn ghost" href="{{ '/tags/' | relative_url }}">Browse by tag</a>
        </div>
        <div class="blog-hero-pills">
          <span class="chip">Identity &amp; lifecycle</span>
          <span class="chip">Zero Trust without VPN pain</span>
          <span class="chip">Linux &amp; automation</span>
          <span class="chip">OT &amp; SCADA safety</span>
        </div>
      </div>
    </div>
  </section>

  <section class="blog-listing" aria-labelledby="blog-latest">
    <div class="container">
      <div class="blog-listing-head">
        <div>
          <p class="eyebrow">Latest</p>
          <h2 id="blog-latest">Fresh thinking on identity, automation, and OT</h2>
          <p class="blog-listing-sub">
            Short, to-the-point articles you can put to work — no buzzwords, just the patterns that make systems reliable.
          </p>
        </div>
      </div>

      {% if site.posts and site.posts != empty %}
      <div class="blog-grid">
        {% for post in site.posts %}
        <article class="blog-card">
          <a class="blog-card-link" href="{{ post.url | relative_url }}">
            <div class="blog-card-meta">
              <span class="blog-card-date">{{ post.date | date: "%b %d, %Y" }}</span>
              {% if post.tags and post.tags != empty %}
                <span class="blog-card-tag">{{ post.tags | first }}</span>
              {% endif %}
            </div>

            <h3 class="blog-card-title">{{ post.title }}</h3>

            {% if post.tldr %}
              <p class="blog-card-excerpt">{{ post.tldr }}</p>
            {% else %}
              <p class="blog-card-excerpt">{{ post.excerpt | strip_html | truncate: 140 }}</p>
            {% endif %}

            {% if post.tags and post.tags.size > 1 %}
            <ul class="blog-card-tags" aria-label="Topics">
              {% for tag in post.tags limit:3 %}
                <li>{{ tag }}</li>
              {% endfor %}
            </ul>
            {% endif %}

            <div class="blog-card-footer">
              <span>Read article</span>
              <span class="blog-card-arrow">→</span>
            </div>
          </a>
        </article>
        {% endfor %}
      </div>
      {% else %}
        <p class="blog-empty">Articles are on the way. Check back soon.</p>
      {% endif %}
    </div>
  </section>
</div>
